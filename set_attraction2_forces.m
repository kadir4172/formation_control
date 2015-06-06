  inside_outside_array  = evalin('base', 'inside_outside_array');
  
  X  = evalin('base', 'X');
  Y  = evalin('base', 'Y');
   real_time_scale = evalin('base', 'real_time_scale');
  formation_x = evalin('base', 'formation_x');
  formation_y = evalin('base', 'formation_y');
  
  array_length = length(formation_x);
  
  force_matrix = evalin('base', 'force_matrix');
  
  ka2  = evalin('base', 'ka2');
 
  n = evalin('base', 'n');
  
  force_matrix(:,5,:) = 0 ; % attractive force2 sutununu sifirlayalim
  for i = 1 : 1 : n
    if(inside_outside_array(i) == 0) %eger agent shape icerisinde degilse hesaplansin
      for j = 1 : 1 : array_length
        distance_to_point = norm([(formation_x(j) - X(i))  (formation_y(j) - Y(i))]) * real_time_scale;
        force_matrix(1,5,i) = force_matrix(1,5,i) + ((formation_x(j) - X(i)) * real_time_scale / (distance_to_point)^3) ;
        force_matrix(2,5,i) = force_matrix(2,5,i) + ((formation_y(j) - Y(i)) * real_time_scale / (distance_to_point)^3) ;
      end
        force_matrix(1,5,i) = (force_matrix(1,5,i) * ka2) / array_length;
        force_matrix(2,5,i) = (force_matrix(2,5,i) * ka2) / array_length;
    end
  end
  
 assignin('base', 'force_matrix', force_matrix);




