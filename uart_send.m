n = evalin('base', 'n');
%u = evalin('base', 'u');
%y = evalin('base', 'y');
s = evalin('base', 's');
force_matrix = evalin('base', 'force_matrix');
max_force    = evalin('base', 'max_force');
heading_robots    = evalin('base', 'heading_robots');
motor_ratio = 5000;
max_motor   = 14;
%feedback_matrix = evalin('base', 'feedback_matrix');
%mrec_active   = evalin('base', 'mrec_active');
%formation_sendto_gazebo   = evalin('base', 'formation_sendto_gazebo');
%formation_x = evalin('base', 'formation_x');
%formation_y = evalin('base', 'formation_y');

%gazebo_index_array = (feedback_matrix(:,7) - mod(feedback_matrix(:,7),10)) / 10;

%string_to_send = strcat(string_to_send, 'mrec ');
%str_mrec = num2str(mrec_active,1);
%string_to_send = [string_to_send, ' ', str_mrec, ' '];
Xdot = force_matrix(1,7,:)./motor_ratio;
Ydot = force_matrix(2,7,:)./motor_ratio; %range : +-100 / 5000

%Xdot = ones(n,1);
%Ydot = ones(n,1);
string_to_send = [char(85)];
proximity_circle_radius = 0.010;
Xdot
for i = 1 : 1 : n
   if(abs(Xdot(:,:,i))<proximity_circle_radius)
       Xdot(:,:,i) = 0;
   end
   if(abs(Ydot(:,:,i))<proximity_circle_radius)
       Ydot(:,:,i) = 0;
   end
   bearing = atan2(Ydot(i), Xdot(i));
   bearing_deg = bearing * 180 / pi;
   bearing_deg = bearing_deg + 360;
   bearing_deg = mod(bearing_deg, 360);
   
   bearing_deg = bearing_deg - heading_robots(i); %% robotun anlýk bas acýsýndan cýkartalým
   
   amplitude     = sqrt(Xdot(i)^2 + Ydot(i)^2);
   saturated_amp = min((max_force/motor_ratio), max(0, amplitude));

   velocity = saturated_amp * motor_ratio / max_force * max_motor;
   M1  = round(velocity * cosd(270 - bearing_deg));
   M2  = round(velocity * cosd(30  - bearing_deg));
   M3  = round(velocity * cosd(150 - bearing_deg));

   if(abs(M1) > max_motor)
       M1 = max_motor * M1 / abs(M1);
   end
   if(abs(M2) > max_motor)
       M2 = max_motor * M2 / abs(M2);
   end
   if(abs(M3) > max_motor)
       M3 = max_motor * M3 / abs(M3);
   end
   
   if(M1 == 0)
       M1 = 75;
   elseif(M1 > 0)
       M1 = M1 + 44;
   else
       M1 = 59 - M1;    
   end
      
   if(M2 == 0)
       M2 = 75;
   elseif(M2 > 0)
       M2 = M2 + 44;
   else
       M2 = 59 - M2;    
   end
         
      
   if(M3 == 0)
       M3 = 75;
   elseif(M3 > 0)
       M3 = M3 + 44;
   else
       M3 = 59 - M3;    
   end
          
           
   
   str1 = char(M1);
   str2 = char(M2);
   str3 = char(M3);
   string_to_send = [string_to_send, str1, str2, str3];
end

string_to_send = [string_to_send, ' \n']
formation_ok = evalin('base', 'formation_ok');


   
   %string_to_send = strcat(string_to_send, num2str(10));
   assignin('base', 'string_to_send', string_to_send);
   fprintf(s,'%s',string_to_send);
   %settings = fgets(s)

%fopen(u);
%flushinput(u);
%fwrite(u,string_to_send);
%fclose(u);

%{
if(formation_sendto_gazebo == 1) % eger yeni formation sekli varsa ya da mrec den yeni bir sekil geliyorsa
  string_to_send = [];
  for i = 1 : 4 : length(formation_x)
    str1 = num2str(formation_x(i));
    str2 = num2str(formation_y(i));
    string_to_send = [string_to_send, str1, ' ', str2, ' '];
  end
  string_to_send = strcat(string_to_send, ' \n');
  fopen(y); % 5053 u dinleyen publisher_formation la konusalim
  flushinput(y);
  fwrite(y,string_to_send);
  fclose(y);
  formation_sendto_gazebo = 0;
end

%{
assignin('base', 'ka', ka);
assignin('base', 'kr', kr);
assignin('base', 'kf', kf);
assignin('base', 'km', km);
assignin('base', 'ko', ko);
assignin('base', 'ka2', ka2);
%}
assignin('base', 'formation_sendto_gazebo', formation_sendto_gazebo);
%}