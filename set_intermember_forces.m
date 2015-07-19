  X  = evalin('base', 'X');
  Y  = evalin('base', 'Y');
  inside_outside_array  = evalin('base', 'inside_outside_array');
  
  agents_radius = evalin('base', 'agents_radius');
  
  %dist_to_agents matrisini alalim
  dist_to_agents = evalin('base', 'dist_to_agents');

  force_matrix = evalin('base', 'force_matrix');
  
  km  = evalin('base', 'km');
 
  n = evalin('base', 'n');
  

  force_matrix(:,3,:) = 0 ; % intermember force sutununu sifirlayalim
  for i = 1 : 1 : n
       if(inside_outside_array(i) ~= 1) %eger agent shape icerisinde degilse hesaplansin
          km_to_use = km;
      else
          km_to_use = km / 16;
      end
    for j = 1 : 1 : n
      if(i~=j)
        zone = agents_radius(i) + agents_radius(j);  
        force_matrix(1,3,i) = force_matrix(1,3,i) + ((X(i) - X(j)) / dist_to_agents(i,j)) / ((dist_to_agents(i,j) - zone)^2) ;
        force_matrix(2,3,i) = force_matrix(2,3,i) + ((Y(i) - Y(j)) / dist_to_agents(i,j)) / ((dist_to_agents(i,j) - zone)^2) ;
      end
    end
    force_matrix(1,3,i) = force_matrix(1,3,i) * km_to_use;
    force_matrix(2,3,i) = force_matrix(2,3,i) * km_to_use;
  end
  
 assignin('base', 'force_matrix', force_matrix);

