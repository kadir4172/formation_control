  offline_force_matrix = evalin('base', 'offline_force_matrix');
  n = evalin('base', 'n');
  max_force = evalin('base', ' max_force');
  max_force = max_force ;

  for i = 1 : 1 : n
    offline_force_matrix(1,7,i) = offline_force_matrix(1,1,i) + offline_force_matrix(1,2,i) + offline_force_matrix(1,3,i) - offline_force_matrix(1,4,i) + offline_force_matrix(1,5,i) + offline_force_matrix(1,6,i);
    offline_force_matrix(2,7,i) = offline_force_matrix(2,1,i) + offline_force_matrix(2,2,i) + offline_force_matrix(2,3,i) - offline_force_matrix(2,4,i) + offline_force_matrix(2,5,i) + offline_force_matrix(2,6,i);
    
    amplitude = offline_force_matrix(1,7,i)^2 + offline_force_matrix(2,7,i)^2 ;
    amplitude = sqrt(amplitude);
    gain = 1;
    if(amplitude > max_force)
            gain = max_force / amplitude;
    end
 
   
      offline_force_matrix(1,7,i) = gain * offline_force_matrix(1,7,i);
      offline_force_matrix(2,7,i) = gain * offline_force_matrix(2,7,i);
    
    
  end
  
  assignin('base', 'offline_force_matrix', offline_force_matrix);
  