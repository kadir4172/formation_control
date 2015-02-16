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


#define BUFLEN 2048
#define PORT 5052


gazebo::transport::PublisherPtr pub;
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

    gazebo::transport::NodePtr node(new gazebo::transport::Node());
  
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
    node->Init();

  // Publish to a Gazebo topic
    pub = node->Advertise<gazebo::msgs::Pose>("~/ref_velocities");

  // Wait for a subscriber to connect
    //pub->WaitForConnection();  //baglanti beklemeyelim
    while(1)
    {
        if (recvfrom(sockfd, buf, BUFLEN, 0, (struct sockaddr*)&cli_addr, &slen)==-1)
            err("recvfrom()");
            //printf("Received packet from %s:%d\nData: %s\n\n", inet_ntoa(cli_addr.sin_addr), ntohs(cli_addr.sin_port), buf);
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
    float f[4] = {0};
    static bool wait_for_mrec = 0;
  
    char key[] = "mrec";
    char b[]  = "mrec"   ;
    float mrec_flag = 0.0;
    while (str[i])
      {
       //strcpy(b,c);
       if (isspace(str[i])){
          if(wait_for_mrec == 1){
            wait_for_mrec = 0; 
            mrec_flag = std::atof(c);
            memset(c,0,sizeof(c));
            i++;
            continue;         
          }
          if(strcmp (c,key)==0){
            memset(c,0,sizeof(c));
            wait_for_mrec = 1;   
          }
          else{
          f[counter] = std::atof(c);
          counter++; 
          memset(c,0,sizeof(c));
          }
        }
        else      
          sprintf(c,"%s%c", c,str[i]);
      
        if(counter == 4){
          gazebo::math::Quaternion quat(f[3],f[0],f[1],f[2]); 
          gazebo::math::Vector3 pos(mrec_flag,0,0);
          gazebo::math::Pose data(pos,quat);
          gazebo::msgs::Pose data_msg;
          gazebo::msgs::Set(&data_msg, data);
          pub->Publish(data_msg);
          //printf("Yollanan: %f %f %f %f \n", f[1], f[2], f[3], f[4]);
          counter = 0;
        }
        i++;
    }
    return;
}
