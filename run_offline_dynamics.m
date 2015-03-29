offline_force_matrix = evalin('base', 'offline_force_matrix');
offline_dt           = evalin('base','offline_dt');
offline_force_matrix           = evalin('base','offline_force_matrix');
X  = evalin('base', 'X_offline');
Y  = evalin('base', 'Y_offline');

F = [1 offline_dt; 0 1];

for i = 1 : 1 : n
  X_vector = [X(i);  offline_force_matrix(1,7,i)];
  Y_vector = [Y(i);  offline_force_matrix(2,7,i)];  

  X_vector = F * X_vector;
  Y_vector = F * Y_vector;
  
 
  X(i)= X_vector(1);
  Xdot(i) = X_vector(2);
  
  
  Y(i)= Y_vector(1);
  Ydot(i) = Y_vector(2);
end

  assignin('base', 'X_offline', X);
  assignin('base', 'Y_offline', Y);
  assignin('base', 'Xdot_offline', Xdot);
  assignin('base', 'Ydot_offline', Ydot);
  
  deneme = 18