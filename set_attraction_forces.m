  inside_outside_array  = evalin('base', 'inside_outside_array');
  
  X  = evalin('base', 'X');
  Y  = evalin('base', 'Y');
  
  formation_x = evalin('base', 'formation_x');
  formation_y = evalin('base', 'formation_y');
  
  array_length = length(formation_x);
  
  force_matrix = evalin('base', 'force_matrix');
  
  ka  = evalin('base', 'ka');
 
  n = evalin('base', 'n');
  max_attraction_force = 1500;
  
  force_matrix(:,1,:) = 0 ; % attractive force sutununu sifirlayalim
  for i = 1 : 1 : n
    if(inside_outside_array(i) ~= 1) %eger agent shape icerisinde degilse hesaplansin
      for j = 1 : 1 : array_length
        force_matrix(1,1,i) = force_matrix(1,1,i) + (formation_x(j) - X(i));
        force_matrix(2,1,i) = force_matrix(2,1,i) + (formation_y(j) - Y(i));
      end
        force_matrix(1,1,i) = (force_matrix(1,1,i) * ka) / array_length;
        force_matrix(2,1,i) = (force_matrix(2,1,i) * ka) / array_length;
     
         
      if (abs(force_matrix(1,1,i)) > max_attraction_force)
        force_matrix(1,1,i) = max_attraction_force * (force_matrix(1,1,i)/abs(force_matrix(1,1,i)));
      end
      
      if (abs(force_matrix(2,1,i)) > max_attraction_force)
        force_matrix(2,1,i) = max_attraction_force * (force_matrix(2,1,i)/abs(force_matrix(2,1,i)));
      end
      
    end
  end
  
 assignin('base', 'force_matrix', force_matrix);




