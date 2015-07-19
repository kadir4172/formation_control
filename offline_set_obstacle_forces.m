  X  = evalin('base', 'X_offline');
  Y  = evalin('base', 'Y_offline');
  offline_inside_outside_array  = evalin('base', 'offline_inside_outside_array');
  
  obstacle_global  = evalin('base', 'obstacle_global');
  obstacle_number  = evalin('base', 'obstacle_number');
  
  agents_radius  = evalin('base', 'agents_radius');
   
  offline_force_matrix = evalin('base', 'offline_force_matrix');
   
  offline_ko  = evalin('base', 'offline_ko');
  n = evalin('base', 'n');
  
  array_length = length(obstacle_global);
  
  offline_force_matrix(:,6,:) = 0 ; % obstacle force sutununu sifirlayalim
  if(obstacle_number ~= 0) 
    for j = 1 : 1 : n
      for i = 1 : 1 : array_length
        distance_to_point   = norm([(obstacle_global(1,i) - X(j))  (obstacle_global(2,i) - Y(j))]);
        offline_force_matrix(1,6,j) = offline_force_matrix(1,6,j) + (((X(j) - obstacle_global(1,i)) / (distance_to_point^2))) / ((distance_to_point - agents_radius(j))^2);
        offline_force_matrix(2,6,j) = offline_force_matrix(2,6,j) + (((Y(j) - obstacle_global(2,i)) / (distance_to_point^2))) / ((distance_to_point - agents_radius(j))^2);
      end
        offline_force_matrix(1,6,j) = (offline_force_matrix(1,6,j) * offline_ko); %/ array_length;
        offline_force_matrix(2,6,j) = (offline_force_matrix(2,6,j) * offline_ko); %/ array_length;
    end
  end
  assignin('base', 'offline_force_matrix', offline_force_matrix);