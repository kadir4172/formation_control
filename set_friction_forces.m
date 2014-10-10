  Xdot  = evalin('base', 'Xdot');
  Ydot  = evalin('base', 'Ydot');
  force_matrix = evalin('base', 'force_matrix');
  
  
  
  kf  = evalin('base', 'kf');
 
  n = evalin('base', 'n');
  
  for i = 1 : 1 : n 
    force_matrix(1,4,i) = kf * Xdot(i);
    force_matrix(2,4,i) = kf * Ydot(i);
  end
  
  assignin('base', 'force_matrix', force_matrix);