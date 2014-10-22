  X  = evalin('base', 'X');
  Y  = evalin('base', 'Y');
  
  agents_zone = evalin('base', 'agents_zone');
  
  %dist_to_agents matrisini alalim
  dist_to_agents = evalin('base', 'dist_to_agents');

  force_matrix = evalin('base', 'force_matrix');
  
  km  = evalin('base', 'km');
 
  n = evalin('base', 'n');
  

  force_matrix(:,3,:) = 0 ; % intermember force sutununu sifirlayalim
  for i = 1 : 1 : n
    for j = 1 : 1 : n
      if(i~=j)
        zone = agents_zone(i) + agents_zone(j);  
        %force_matrix(1,3,i) = force_matrix(1,3,i) + ((X(i) - X(j)) / (dist_to_agents(i,j))^3);
        %force_matrix(2,3,i) = force_matrix(2,3,i) + ((Y(i) - Y(j)) / (dist_to_agents(i,j))^3);
        force_matrix(1,3,i) = force_matrix(1,3,i) + ((X(i) - X(j)) / dist_to_agents(i,j)) / ((dist_to_agents(i,j) - zone)^2) ;
        force_matrix(2,3,i) = force_matrix(2,3,i) + ((Y(i) - Y(j)) / dist_to_agents(i,j)) / ((dist_to_agents(i,j) - zone)^2) ;
      end
    end
    force_matrix(1,3,i) = force_matrix(1,3,i) * km;
    force_matrix(2,3,i) = force_matrix(2,3,i) * km;
  end
  
 assignin('base', 'force_matrix', force_matrix);

