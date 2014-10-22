  X  = evalin('base', 'X');
  Y  = evalin('base', 'Y');
  
  obstacle_global  = evalin('base', 'obstacle_global');
  obstacle_number  = evalin('base', 'obstacle_number');
  
  agents_zone  = evalin('base', 'agents_zone');
   
  force_matrix = evalin('base', 'force_matrix');
   
  ko  = evalin('base', 'ko');
  n = evalin('base', 'n');
  
  array_length = length(obstacle_global);
  
  force_matrix(:,6,:) = 0 ; % obstacle force sutununu sifirlayalim
  if(obstacle_number ~= 0) 
    for j = 1 : 1 : n
      for i = 1 : 1 : array_length
        distance_to_point   = norm([(obstacle_global(1,i) - X(j))  (obstacle_global(2,i) - Y(j))]);
        force_matrix(1,6,j) = force_matrix(1,6,j) + (((X(j) - obstacle_global(1,i)) / (distance_to_point^2))) / ((distance_to_point - agents_zone(j))^2);
        force_matrix(2,6,j) = force_matrix(2,6,j) + (((Y(j) - obstacle_global(2,i)) / (distance_to_point^2))) / ((distance_to_point - agents_zone(j))^2);
      end
        force_matrix(1,6,j) = (force_matrix(1,6,j) * ko); %/ array_length;
        force_matrix(2,6,j) = (force_matrix(2,6,j) * ko); %/ array_length;
    end
  end
  assignin('base', 'force_matrix', force_matrix);