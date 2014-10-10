function [  ] = update_route_table( )


X  = evalin('base', 'X');
Y  = evalin('base', 'Y');
PA_index = evalin('base', 'PA_index');
PA_number = evalin('base', 'PA_number');
n = evalin('base', 'n');
zone = evalin('base','zone');
agent_coverage = evalin('base', 'agent_coverage');
  %dist_to_beacon matrisini olusturalim
  for i = 1 : 1 : n
     for j = 1 : 1 : PA_number
       dist_to_beacon(i,j) = norm([(X(i) - X(PA_index(j))) (Y(i) - Y(PA_index(j)))]);
     end
  end
  
  %agent lari zone lara ayiralim ve beaconlara en yakin olanlarin rankini
  %'2' yapalim
  for i = 1 : 1 : n
     [val,ind] = min(dist_to_beacon(i,:));
     zone(ind).matrix(zone(ind).sayac,1) = i;
      
     if(val < agent_coverage)
       zone(ind).matrix(zone(ind).sayac,2) = 2;
     end
     zone(ind).sayac = zone(ind).sayac + 1;
  end
  
  
  %beacon larin rankini '1' yapalim
  for i = 1 : 1 : PA_number
   ind = find(zone(i).matrix(:,1) == PA_index(i));
   zone(i).matrix(ind,2)  = 1;
  end
  
  
  %tum agent larin rank ini bulmaya calisalim, bulamadiklarimiz '0' kalsin
  for i = 1 : 1 : PA_number
    zone_old = zone(i);
    zone_old.matrix(:,2) = 0;
    continue_flag = 1;
    
    while(continue_flag)
      continue_flag = 0;
      max_rank = max(zone(i).matrix(:,2));
      ind = find(zone(i).matrix(:,2) == max_rank);
      max_rank_number = length(ind);
      
 
      for j = 1 : 1 : (zone(i).sayac - 1)
        if(zone(i).matrix(j,2) == 0)
          posx = X(zone(i).matrix(j,1));
          posy = Y(zone(i).matrix(j,1));
        
          for(k = 1 : 1 : max_rank_number)
            tarx = X(zone(i).matrix(ind(k),1));
            tary = Y(zone(i).matrix(ind(k),1));
            dist_vector(k) = norm([(posx-tarx) (posy-tary)]);
          end
        
          min_val = min(dist_vector);
          if(min_val < agent_coverage )
            zone(i).matrix(j,2) = max_rank + 1;
            continue_flag = 1;
          end
        
        end
      end
    end
  
  end
  
  %create route_table with agent_no/rank/zone columns
  route_table = double.empty(1,0);
  for i = 1 : 1 : PA_number
    zone_id_column = i * ones((zone(i).sayac-1),1);
    route_table = [route_table ; zone(i).matrix zone_id_column];
  end
  route_table = sortrows(route_table);
  
  %rank i '0' olan agentlarin rank ini maksimum yapalim
  zoneless_agents_index = find(~route_table(:,2));
  for (i = 1 : 1 : length(zoneless_agents_index))
    route_table(zoneless_agents_index(i),2) = max_rank + 1;
  end
  
  
  %elde ettigimiz route_table i base workspace e tekrar atalim
  assignin('base', 'route_table', route_table);
  assignin('base', 'dist_to_beacon', dist_to_beacon);
end

