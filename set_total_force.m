  force_matrix = evalin('base', 'force_matrix');
  n = evalin('base', 'n');
  max_force = evalin('base', ' max_force');
  max_force = max_force * 12;

  for i = 1 : 1 : n
    force_matrix(1,7,i) = force_matrix(1,1,i) + force_matrix(1,2,i) + force_matrix(1,3,i) - force_matrix(1,4,i) + force_matrix(1,5,i) + force_matrix(1,6,i);
    force_matrix(2,7,i) = force_matrix(2,1,i) + force_matrix(2,2,i) + force_matrix(2,3,i) - force_matrix(2,4,i) + force_matrix(2,5,i) + force_matrix(2,6,i);
    
    amplitude = force_matrix(1,7,i)^2 + force_matrix(2,7,i)^2 ;
    amplitude = sqrt(amplitude);
    gain = 1;
    if(amplitude > max_force)
            gain = max_force / amplitude;
    end
 
   
      force_matrix(1,7,i) = gain * force_matrix(1,7,i);
      force_matrix(2,7,i) = gain * force_matrix(2,7,i);
  
 

  end
  
  assignin('base', 'force_matrix', force_matrix);