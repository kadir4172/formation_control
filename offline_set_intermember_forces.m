  X  = evalin('base', 'X_offline');
  Y  = evalin('base', 'Y_offline');
  
  agents_radius = evalin('base', 'agents_radius');
  real_time_scale = evalin('base', 'real_time_scale');
  offline_inside_outside_array  = evalin('base', 'offline_inside_outside_array');
  
 %==========================%
  %dist_to_agents matrisini alalim
  %dist_to_agents = evalin('base', 'dist_to_agents');
  offline_dist_to_agents = [];
for i = 1 : 1 : n
    base_agent_X = X(i);
    base_agent_Y = Y(i);
    for j = 1 : 1 : n
      offline_dist_to_agents(i,j) = ((base_agent_X - X(j))^2 + (base_agent_Y - Y(j))^2) ^0.5;
    end
end
  %==========================%
  
  
  offline_force_matrix = evalin('base', 'offline_force_matrix');
  
  offline_km  = evalin('base', 'offline_km');
 
  n = evalin('base', 'n');
  

  offline_force_matrix(:,3,:) = 0 ; % intermember force sutununu sifirlayalim
  for i = 1 : 1 : n
        if(offline_inside_outside_array(i) ~= 1) %eger agent shape icerisinde degilse hesaplansin
          km_to_use = offline_km;
      else
          km_to_use = offline_km / 16;
      end
    for j = 1 : 1 : n
      if(i~=j)
        zone = agents_radius(i) + agents_radius(j);  
        dummy  = (offline_dist_to_agents(i,j) - zone) * real_time_scale;
          if(dummy < 0)
            dummy = 0.0001;
        end
      
        if(offline_dist_to_agents(i,j) == 0)
            offline_dist_to_agents(i,j) == 0.001;
        end
        offline_force_matrix(1,3,i) = offline_force_matrix(1,3,i) + ((X(i) - X(j)) / offline_dist_to_agents(i,j) / real_time_scale) / (dummy^2) ;
        offline_force_matrix(2,3,i) = offline_force_matrix(2,3,i) + ((Y(i) - Y(j)) / offline_dist_to_agents(i,j) / real_time_scale) / (dummy^2) ;
      end
    end
    offline_force_matrix(1,3,i) = offline_force_matrix(1,3,i) * km_to_use;
    offline_force_matrix(2,3,i) = offline_force_matrix(2,3,i) * km_to_use;
  end
  
 assignin('base', 'offline_force_matrix', offline_force_matrix);
 
 

