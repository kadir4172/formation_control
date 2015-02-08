n = evalin('base', 'n');
u = evalin('base', 'u');
force_matrix = evalin('base', 'force_matrix');
feedback_matrix = evalin('base', 'feedback_matrix');


gazebo_index_array = (feedback_matrix(:,7) - mod(feedback_matrix(:,7),10)) / 10;
string_to_send = [];
for i = 1 : 1 : n
   str1 = num2str(force_matrix(1,7,i)/900,5);
   str2 = num2str(force_matrix(2,7,i)/900,5);
   str3 = num2str(i,5);
   str4 = num2str(gazebo_index_array(i),5);
   str5 = ' '; 
   string_to_send = [string_to_send str1 str5 str2 str5 str3 str5 str4 str5];
end
   string_to_send = strcat(string_to_send, ' \n');

fopen(u);
flushinput(u);
fwrite(u,string_to_send);
fclose(u);




assignin('base', 'ka', ka);
assignin('base', 'kr', kr);
assignin('base', 'kf', kf);
assignin('base', 'km', km);
assignin('base', 'ko', ko);
assignin('base', 'ka2', ka2);