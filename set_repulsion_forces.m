  inside_outside_array  = evalin('base', 'inside_outside_array');
  
  X  = evalin('base', 'X');
  Y  = evalin('base', 'Y');
  
  Xdot  = evalin('base', 'Xdot');
  Ydot  = evalin('base', 'Ydot');
  
  formation_x = evalin('base', 'formation_x');
  formation_y = evalin('base', 'formation_y');
  real_time_scale = evalin('base', 'real_time_scale');
  
  array_length = length(formation_x);
  
  force_matrix = evalin('base', 'force_matrix');
  
  kr = evalin('base', 'kr');
 
  n = evalin('base', 'n');
  agents_radius = evalin('base', 'agents_radius');

  force_matrix(:,2,:) = 0 ; % repulsive force sutununu sifirlayalim
  for i = 1 : 1 : n
    if(inside_outside_array(i) == 1) %eger agent, shape disarisinda degilse hesaplansin
      for j = 1 : 1 : array_length
        distance_to_point = norm([(formation_x(j) - X(i))  (formation_y(j) - Y(i))]) * real_time_scale;
        force_matrix(1,2,i) = force_matrix(1,2,i) + (((X(i) - formation_x(j)) / (distance_to_point)) / (distance_to_point - real_time_scale * agents_radius(i))^2);
        force_matrix(2,2,i) = force_matrix(2,2,i) + (((Y(i) - formation_y(j)) / (distance_to_point)) / (distance_to_point - real_time_scale * agents_radius(i))^2);
      end
        force_matrix(1,2,i) = force_matrix(1,2,i) * kr;
        force_matrix(2,2,i) = force_matrix(2,2,i) * kr;
        
        F_rep = [force_matrix(1,2,i) force_matrix(2,2,i)];
        Vel   = [Xdot(i) Ydot(i)];
        
        if(norm(Vel) > 0.2)
        u_frep = F_rep / (norm(F_rep));
        u_vel  = Vel   / norm(Vel);
        
        f = u_frep - u_vel;
        f = f .* norm(F_rep);
        f = f .* (norm(Vel)/1.5);
        
        force_matrix(1,2,i) = f(1);
        force_matrix(2,2,i) = f(2);
        end
    end
  end
  
 assignin('base', 'force_matrix', force_matrix);

