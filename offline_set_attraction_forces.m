  offline_inside_outside_array  = evalin('base', 'offline_inside_outside_array');
  
  X  = evalin('base', 'X_offline');
  Y  = evalin('base', 'Y_offline');
  
  formation_x = evalin('base', 'formation_x');
  formation_y = evalin('base', 'formation_y');
  
  array_length = length(formation_x);
  
  offline_force_matrix = evalin('base', 'offline_force_matrix');
  
  offline_ka  = evalin('base', 'offline_ka');
 
  n = evalin('base', 'n');
  max_attraction_force = 1500;
  
  offline_force_matrix(:,1,:) = 0 ; % attractive force sutununu sifirlayalim
  for i = 1 : 1 : n
    if(offline_inside_outside_array(i) ~= 1) %eger agent shape icerisinde degilse hesaplansin
      for j = 1 : 1 : array_length
        offline_force_matrix(1,1,i) = offline_force_matrix(1,1,i) + (formation_x(j) - X(i));
        offline_force_matrix(2,1,i) = offline_force_matrix(2,1,i) + (formation_y(j) - Y(i));
      end
        offline_force_matrix(1,1,i) = (offline_force_matrix(1,1,i) * offline_ka) / array_length;
        offline_force_matrix(2,1,i) = (offline_force_matrix(2,1,i) * offline_ka) / array_length;
     
         
      if (abs(offline_force_matrix(1,1,i)) > max_attraction_force)
        offline_force_matrix(1,1,i) = max_attraction_force * (offline_force_matrix(1,1,i)/abs(offline_force_matrix(1,1,i)));
      end
      
      if (abs(offline_force_matrix(2,1,i)) > max_attraction_force)
        offline_force_matrix(2,1,i) = max_attraction_force * (offline_force_matrix(2,1,i)/abs(offline_force_matrix(2,1,i)));
      end
      
    end
  end
  
 assignin('base', 'offline_force_matrix', offline_force_matrix);




