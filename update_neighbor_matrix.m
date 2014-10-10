function [] = update_neighbor_matrix( )

%agent sayisi
n = evalin('base', 'n');

%agent_covarage
agent_coverage = evalin('base', 'agent_coverage');

%agent larin guncel pozisyonlari
X  = evalin('base', 'X');
Y  = evalin('base', 'Y');
neighbor_matrix = evalin('base', 'neighbor_matrix');
neighbor_distance = evalin('base', 'neighbor_distance');

%route_table listesi
route_table = evalin('base', 'route_table');

%sirali beacon listesi
PA_index = evalin('base', 'PA_index');

%dist_to_beacon matrisini alalim
dist_to_beacon = evalin('base', 'dist_to_beacon');

%dist_to_agents matrisini alalim
dist_to_agents = evalin('base', 'dist_to_agents');


%her agent icin en yakin uc komsuyu ve mesafelerini bulalim
for i = 1 : 1 : n
    [sorted_array, ind] = sort(dist_to_agents(i,:));
    
    if(max([dist_to_agents(i,ind(2)) dist_to_agents(i,ind(3)) dist_to_agents(i,ind(4))]) < agent_coverage)
        %agent rank 2 ise en yakin komususu beacon olmali 
        if(route_table(i,2) == 2 && PA_index(route_table(i,3)) ~= ind(2))
          neighbor_matrix(i,:) = [PA_index(route_table(i,3)) ind(2) ind(3) 0];
          neighbor_distance(i,:) = [dist_to_beacon(i,route_table(i,3)) sorted_array(2) sorted_array(3)];
        else
        neighbor_matrix(i,:) = [ind(2) ind(3) ind(4) 0];
        neighbor_distance(i,:) = [sorted_array(2) sorted_array(3) sorted_array(4)];
        end
    else
        neighbor_matrix(i,:) = [0 0 0 1];
        neighbor_distance(i,:) = [0 0 0];
    end

end

assignin('base', 'neighbor_matrix'  , neighbor_matrix)  ;
assignin('base', 'neighbor_distance', neighbor_distance);

end

