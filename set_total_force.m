  force_matrix = evalin('base', 'force_matrix');
  n = evalin('base', 'n');
  
  max_force = 1000;

  for i = 1 : 1 : n
    force_matrix(1,7,i) = force_matrix(1,1,i) + force_matrix(1,2,i) + force_matrix(1,3,i) - force_matrix(1,4,i) + force_matrix(1,5,i);
    force_matrix(2,7,i) = force_matrix(2,1,i) + force_matrix(2,2,i) + force_matrix(2,3,i) - force_matrix(2,4,i) + force_matrix(2,5,i);
    
    if (abs(force_matrix(1,7,i)) > max_force)
        force_matrix(1,7,i) = max_force * (force_matrix(1,7,i)/abs(force_matrix(1,7,i)));
        force_matrix(2,7,i) = max_force * (force_matrix(2,7,i)/abs(force_matrix(2,7,i)));
    end
  end
  
  assignin('base', 'force_matrix', force_matrix);