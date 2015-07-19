#include <gazebo/gazebo.hh>
#include <gazebo/transport/transport.hh>
#include <gazebo/msgs/msgs.hh>
#include <gazebo/math/gzmath.hh>
#include <boost/bind.hpp>
#include <gazebo/physics/physics.hh>
#include <gazebo/common/common.hh>
#include <stdio.h>
#include <iostream>
#include <sys/socket.h>
#include <netinet/in.h>
#include <sys/types.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <netdb.h> 


#define BUFLEN 5096
#define PORT 5054


gazebo::transport::PublisherPtr pub_create;
gazebo::transport::PublisherPtr pub_delete;

gazebo::msgs::Factory msg_create;

bool formation_sequence = FALSE;
void Parse_Buffer(char*);



void err(const char *str)
{
    perror(str);
    exit(1);
}

int main(int _argc, char **_argv)
{

    // Load gazebo
    gazebo::setupClient(_argc, _argv);

    gazebo::transport::NodePtr node_create(new gazebo::transport::Node());
    gazebo::transport::NodePtr node_delete(new gazebo::transport::Node());
  
    struct sockaddr_in my_addr, cli_addr;
 
    int sockfd, i; 
    socklen_t slen=sizeof(cli_addr);
    char buf[BUFLEN];
    if ((sockfd = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP))==-1)
      err("socket");
    else 
      printf("Server : Socket() successful\n");

    bzero(&my_addr, sizeof(my_addr));
    my_addr.sin_family = AF_INET;
    my_addr.sin_port = htons(PORT);
    my_addr.sin_addr.s_addr = htonl(INADDR_ANY);
    if (bind(sockfd, (struct sockaddr* ) &my_addr, sizeof(my_addr))==-1)
      err("bind");
    else
      printf("Server : bind() successful\n");


    // Start transport
    gazebo::transport::run();

    // Create our node for communication
    node_create->Init();
    node_delete->Init();

    // Publish to a Gazebo topic (model yaratmak icin Factory topic e publish yapmaliyiz)
    pub_create = node_create->Advertise<gazebo::msgs::Factory>("~/factory");

    // Modeller' silmek icin request topic e publish yapmaliyiz
    pub_delete = node_delete->Advertise<gazebo::msgs::Request>("~/request");


   
   
  // Wait for a subscriber to connect
    //pub->WaitForConnection();  //baglanti beklemeyelim
  
  while(1)
    {
        if (recvfrom(sockfd, buf, BUFLEN, 0, (struct sockaddr*)&cli_addr, &slen)==-1)
            err("recvfrom()");
            
            if(formation_sequence == TRUE){
              formation_sequence = FALSE;
            }
            else{
              formation_sequence = TRUE;
            }
          
            //printf("Received packet from %s:%d\nData: %s\n\n", inet_ntoa(cli_addr.sin_addr), ntohs(cli_addr.sin_port), buf);
            
            gazebo::msgs::Request *msg_ptr;
            msg_ptr = new gazebo::msgs::Request;
            if(formation_sequence == TRUE)
               msg_ptr = gazebo::msgs::CreateRequest("entity_delete","4model4"); 
            else
               msg_ptr = gazebo::msgs::CreateRequest("entity_delete","5model5"); 

            pub_delete->Publish(*msg_ptr); //4 numarali agentlari (eski formation i silelim)
            delete msg_ptr;
            Parse_Buffer(buf);  //matlab tarafindan her paket geldiginde parse edip topic olarak yayinlayalim
            memset(buf,0,sizeof(buf));
    }
    close(sockfd);
    return 0;
}

void Parse_Buffer(char* buf){
    int i = 0;
    int counter = 0;
    char *str = buf;
    char c[1024];
    memset(c,0,sizeof(c));
    float f[2] = {0};


    while (str[i])
      {
       if (isspace(str[i])){
          f[counter] = std::atof(c);
          counter++; 
          memset(c,0,sizeof(c));
       }
        else{      
          sprintf(c,"%s%c", c,str[i]);
       }

        if(counter == 2){
          //printf("Yollanan: %f %f\n", f[0], f[1]);
          if(formation_sequence == TRUE){
            msg_create.set_sdf_filename("model://model5");
          }
         else{
            msg_create.set_sdf_filename("model://model4");
          }
          gazebo::msgs::Set(msg_create.mutable_pose(), gazebo::math::Pose(gazebo::math::Vector3(f[0],f[1], 0), gazebo::math::Quaternion(0, 0, 0)));
          pub_create->Publish(msg_create);
          counter = 0;
        }
        i++;
    }
    return;
}

