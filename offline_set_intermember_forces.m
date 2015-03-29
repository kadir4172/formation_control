  X  = evalin('base', 'X_offline');
  Y  = evalin('base', 'Y_offline');
  
  agents_radius = evalin('base', 'agents_radius');
  
 %==========================%
  %dist_to_agents matrisini alalim
  %dist_to_agents = evalin('base', 'dist_to_agents');
  offline_dist_to_agents = [];
for i = 1 : 1 : n
    base_agent_X = X(i);
    base_agent_Y = Y(i);
    for j = 1 : 1 : n
      offline_dist_to_agents(i,j) = norm ([(base_agent_X - X(j)) (base_agent_Y - Y(j))]);
    end
end
  %==========================%
  
  
  offline_force_matrix = evalin('base', 'offline_force_matrix');
  
  offline_km  = evalin('base', 'offline_km');
 
  n = evalin('base', 'n');
  

  offline_force_matrix(:,3,:) = 0 ; % intermember force sutununu sifirlayalim
  for i = 1 : 1 : n
    for j = 1 : 1 : n
      if(i~=j)
        zone = agents_radius(i) + agents_radius(j);  
        %force_matrix(1,3,i) = force_matrix(1,3,i) + ((X(i) - X(j)) / (dist_to_agents(i,j))^3);
        %force_matrix(2,3,i) = force_matrix(2,3,i) + ((Y(i) - Y(j)) / (dist_to_agents(i,j))^3);
        offline_force_matrix(1,3,i) = offline_force_matrix(1,3,i) + ((X(i) - X(j)) / offline_dist_to_agents(i,j)) / ((offline_dist_to_agents(i,j) - zone)^2) ;
        offline_force_matrix(2,3,i) = offline_force_matrix(2,3,i) + ((Y(i) - Y(j)) / offline_dist_to_agents(i,j)) / ((offline_dist_to_agents(i,j) - zone)^2) ;
      end
    end
    offline_force_matrix(1,3,i) = offline_force_matrix(1,3,i) * offline_km;
    offline_force_matrix(2,3,i) = offline_force_matrix(2,3,i) * offline_km;
  end
  
 assignin('base', 'offline_force_matrix', offline_force_matrix);
 
 

