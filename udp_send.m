n = evalin('base', 'n');
u = evalin('base', 'u');
y = evalin('base', 'y');
force_matrix = evalin('base', 'force_matrix');
feedback_matrix = evalin('base', 'feedback_matrix');
mrec_active   = evalin('base', 'mrec_active');
formation_sendto_gazebo   = evalin('base', 'formation_sendto_gazebo');
formation_x = evalin('base', 'formation_x');
formation_y = evalin('base', 'formation_y');

gazebo_index_array = (feedback_matrix(:,7) - mod(feedback_matrix(:,7),10)) / 10;
string_to_send = [];
string_to_send = strcat(string_to_send, 'mrec ');
str_mrec = num2str(mrec_active,1);
string_to_send = [string_to_send, ' ', str_mrec, ' '];


for i = 1 : 1 : n
   str1 = num2str(force_matrix(1,7,i)/900,5);
   str2 = num2str(force_matrix(2,7,i)/900,5);
   str3 = num2str(i,5);
   str4 = num2str(gazebo_index_array(i),5);
   str5 = ' '; 
   string_to_send = [string_to_send, str1, str5, str2, str5, str3, str5, str4, str5];
end
   string_to_send = strcat(string_to_send, ' \n');

fopen(u);
flushinput(u);
fwrite(u,string_to_send);
fclose(u);

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