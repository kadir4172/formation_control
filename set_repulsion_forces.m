  inside_outside_array  = evalin('base', 'inside_outside_array');
  
  X  = evalin('base', 'X');
  Y  = evalin('base', 'Y');
  
  formation_x = evalin('base', 'formation_x');
  formation_y = evalin('base', 'formation_y');
  
  array_length = length(formation_x);
  
  force_matrix = evalin('base', 'force_matrix');
  
  kr = evalin('base', 'kr');
 
  n = evalin('base', 'n');
  

  force_matrix(:,2,:) = 0 ; % repulsive force sutununu sifirlayalim
  for i = 1 : 1 : n
    if(inside_outside_array(i) ~= 0) %eger agent, shape disarisinda degilse hesaplansin
      for j = 1 : 1 : array_length
        distance_to_point = norm([(formation_x(j) - X(i))  (formation_y(j) - Y(i))]);
        force_matrix(1,2,i) = force_matrix(1,2,i) + ((X(i) - formation_x(j)) / (distance_to_point)^3);
        force_matrix(2,2,i) = force_matrix(2,2,i) + ((Y(i) - formation_y(j)) / (distance_to_point)^3);
      end
        force_matrix(1,2,i) = force_matrix(1,2,i) * kr;
        force_matrix(2,2,i) = force_matrix(2,2,i) * kr;
    end
  end
  
 assignin('base', 'force_matrix', force_matrix);

