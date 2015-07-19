  X  = evalin('base', 'X');
  Y  = evalin('base', 'Y');
  
  obstacle_global  = evalin('base', 'obstacle_global');
  obstacle_number  = evalin('base', 'obstacle_number');
    inside_outside_array  = evalin('base', 'inside_outside_array');
  agents_radius  = evalin('base', 'agents_radius');
   
  force_matrix = evalin('base', 'force_matrix');
   
  ko  = evalin('base', 'ko');
  n = evalin('base', 'n');
  
  array_length = length(obstacle_global);
  
  force_matrix(:,6,:) = 0 ; % obstacle force sutununu sifirlayalim
  if(obstacle_number ~= 0) 
    for j = 1 : 1 : n
         if(inside_outside_array(j) ~= 1) %eger agent shape icerisinde degilse hesaplansin
         ko_to_use = ko;   
         else
         ko_to_use = ko/8;
         end
      for i = 1 : 1 : array_length
        distance_to_point   = norm([(obstacle_global(1,i) - X(j))  (obstacle_global(2,i) - Y(j))]);
        force_matrix(1,6,j) = force_matrix(1,6,j) + (((X(j) - obstacle_global(1,i)) / (distance_to_point^2))) / ((distance_to_point - agents_radius(j))^2);
        force_matrix(2,6,j) = force_matrix(2,6,j) + (((Y(j) - obstacle_global(2,i)) / (distance_to_point^2))) / ((distance_to_point - agents_radius(j))^2);
      end
        force_matrix(1,6,j) = (force_matrix(1,6,j) * ko_to_use); %/ array_length;
        force_matrix(2,6,j) = (force_matrix(2,6,j) * ko_to_use); %/ array_length;
       
    end
  end
  assignin('base', 'force_matrix', force_matrix);