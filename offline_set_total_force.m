  offline_force_matrix = evalin('base', 'offline_force_matrix');
  n = evalin('base', 'n');
  
  max_force = 100;

  for i = 1 : 1 : n
    offline_force_matrix(1,7,i) = offline_force_matrix(1,1,i) + offline_force_matrix(1,2,i) + offline_force_matrix(1,3,i) - offline_force_matrix(1,4,i) + offline_force_matrix(1,5,i) + offline_force_matrix(1,6,i);
    offline_force_matrix(2,7,i) = offline_force_matrix(2,1,i) + offline_force_matrix(2,2,i) + offline_force_matrix(2,3,i) - offline_force_matrix(2,4,i) + offline_force_matrix(2,5,i) + offline_force_matrix(2,6,i);
    
    if (abs(offline_force_matrix(1,7,i)) > max_force)
      offline_force_matrix(1,7,i) = max_force * (offline_force_matrix(1,7,i)/abs(offline_force_matrix(1,7,i)));
    end
    
    if (abs(offline_force_matrix(2,7,i)) > max_force)
      offline_force_matrix(2,7,i) = max_force * (offline_force_matrix(2,7,i)/abs(offline_force_matrix(2,7,i)));
    end
  end
  
  assignin('base', 'offline_force_matrix', offline_force_matrix);
  