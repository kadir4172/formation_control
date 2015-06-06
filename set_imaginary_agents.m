formation_center = evalin('base', 'formation_center');
formation_x = evalin('base', 'formation_x');
formation_y = evalin('base', 'formation_y');
formation_ok_in = evalin('base', 'formation_ok');
n = evalin('base', 'n');
x_max = evalin('base', 'x_max');
y_max = evalin('base', 'y_max');
search_step = evalin('base', 'search_step');

grid_map = evalin('base', 'grid_map'); % bos grid map i alalim
free_map = [];
free_map = test_inside_outside(formation_x , formation_y , free_map, x_max, y_max); %obstaclerin icinde dogmayalim diye biraz daha genislettik

probable_map = grid_map .* (~free_map);
[row col] = find(probable_map == 1);

X_pos_array = -1*x_max: search_step : x_max;
Y_pos_array = -1*y_max: search_step : y_max;
%yer_sayisi = length(row)
if (length(row) >= n  && formation_ok_in == 1)
 choose_list = 1 : 1 : length(row);
 rand_list = datasample(choose_list, n, 'Replace', false);    
 for i = 1 : 1 : n
   X_offline(i) = X_pos_array(row(rand_list(i)));
   Y_offline(i) = Y_pos_array(col(rand_list(i)));
   Xdot_offline(i) = 0;
   Ydot_offline(i) = 0;
 end
 formation_ok = 1 ;
 assignin('base', 'X_offline', X_offline);
 assignin('base', 'Y_offline', Y_offline);
 assignin('base', 'Xdot_offline', Xdot_offline);
 assignin('base', 'Ydot_offline', Ydot_offline);
else
 formation_ok = 0;
end
  assignin('base', 'formation_ok', formation_ok);

 
 