  offline_inside_outside_array  = evalin('base', 'offline_inside_outside_array');
  
  X  = evalin('base', 'X_offline');
  Y  = evalin('base', 'Y_offline');
  
  Xdot  = evalin('base', 'Xdot_offline');
  Ydot  = evalin('base', 'Ydot_offline');
  
  formation_x = evalin('base', 'formation_x');
  formation_y = evalin('base', 'formation_y');
  
  array_length = length(formation_x);
  
  offline_force_matrix = evalin('base', 'offline_force_matrix');
  
  offline_kr = evalin('base', 'offline_kr');
 
  n = evalin('base', 'n');
  agents_radius = evalin('base', 'agents_radius');

  offline_force_matrix(:,2,:) = 0 ; % repulsive force sutununu sifirlayalim
  for i = 1 : 1 : n
    if(offline_inside_outside_array(i) ~= 0) %eger agent, shape disarisinda degilse hesaplansin
      for j = 1 : 1 : array_length
        distance_to_point = norm([(formation_x(j) - X(i))  (formation_y(j) - Y(i))]);
        offline_force_matrix(1,2,i) = offline_force_matrix(1,2,i) + (((X(i) - formation_x(j)) / (distance_to_point)) / (distance_to_point - agents_radius(i))^2);
        offline_force_matrix(2,2,i) = offline_force_matrix(2,2,i) + (((Y(i) - formation_y(j)) / (distance_to_point)) / (distance_to_point - agents_radius(i))^2);
      end
        offline_force_matrix(1,2,i) = offline_force_matrix(1,2,i) * offline_kr;
        offline_force_matrix(2,2,i) = offline_force_matrix(2,2,i) * offline_kr;
        
        F_rep = [offline_force_matrix(1,2,i) offline_force_matrix(2,2,i)];
        Vel   = [Xdot_offline(i) Ydot_offline(i)];
        
        if(norm(Vel) > 0.2)
        u_frep = F_rep / (norm(F_rep));
        u_vel  = Vel   / norm(Vel);
        
        f = u_frep - u_vel;
        f = f .* norm(F_rep);
        f = f .* (norm(Vel)/1.5);
        
        offline_force_matrix(1,2,i) = f(1);
        offline_force_matrix(2,2,i) = f(2);
        end
    end
  end
  
 assignin('base', 'offline_force_matrix', offline_force_matrix);

