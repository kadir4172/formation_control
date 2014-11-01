function [] = update_neighbor_matrix( )

%agent sayisi
n = evalin('base', 'n');

%agent_covarage
agent_coverage = evalin('base', 'agent_coverage');

%agent larin guncel gercek pozisyonlari
X_real  = evalin('base', 'X_real');
Y_real  = evalin('base', 'Y_real');

neighbor_matrix = evalin('base', 'neighbor_matrix');
%neighbor_distance = evalin('base', 'neighbor_distance');

%route_table listesi
route_table = evalin('base', 'route_table');

%sirali beacon listesi
PA_index = evalin('base', 'PA_index');

%toplam beacon sayisi
PA_number = evalin('base', 'PA_number');

%dist_to_beacon_real matrisini olusturalim
for i = 1 : 1 : n
  for j = 1 : 1 : PA_number
    dist_to_beacon_real(i,j) = norm([(X_real(i) - X_real(PA_index(j))) (Y_real(i) - Y_real(PA_index(j)))]);
  end
end

%update distance to agents_real matrix  
dist_to_agents_real = zeros(n,n);
for i = 1 : 1 : n
    base_agent_X = X_real(i);
    base_agent_Y = Y_real(i);
    for j = 1 : 1 : n
      dist_to_agents_real(i,j) = norm ([(base_agent_X - X_real(j)) (base_agent_Y - Y_real(j))]);
    end
end

neighbor_matrix = zeros(n,n+2);
%her agent icin en yakin uc komsuyu ve mesafelerini bulalim
for i = 1 : 1 : n
    index = 0 ;
    sorted_array = 0;
    ind = 0 ;
    [sorted_array, ind] = sort(dist_to_agents_real(i,:));
    index = find((0 < sorted_array)  & (sorted_array < agent_coverage)); % agent in kendisi olmasin ve coverage i icerisindeki komsulari olsun
    max_index = max(index);
    neighbor_index = ind(index);
   
    if((max_index) > 4)  % agent in uc den fazla komsusu varsa (agent in kendisi ilk eleman oldugu icin)
        rank_array = route_table(neighbor_index,2);
        b = 0;
        indices = 0;
        [b, indices] = sort(rank_array);
        neighbor_index_dummy = 0;
        for l = 1 : 1 : length(rank_array)
          neighbor_index_dummy(l) = neighbor_index(indices(l)); 
        end
        neighbor_index = neighbor_index_dummy;
        rank_array = b;
        sayac = 1;
        for k = 1 : 1 : length(rank_array)
          if(route_table(i,2) > rank_array(k))  % eger agent in ranki komsusununkinden buyukse
            neighbor_matrix(i,sayac) = neighbor_index(k);
            sayac = sayac + 1;
          end
        end
        
        if(sayac < 4)                          %kucuk rankli olanlari alalim derken yeterli sayida komsu alamadiysak
          for j = sayac : 1 : 3
            neighbor_matrix(i,j) = neighbor_index(j);
          end
          sayac = 4;
        end
        neighbor_matrix(i,(n+1)) = sayac-1; 
      
    elseif ((max_index) == 4) % uc komsu varsa
        neighbor_matrix(i,1) = neighbor_index(1);
        neighbor_matrix(i,2) = neighbor_index(2);
        neighbor_matrix(i,3) = neighbor_index(3);
        neighbor_matrix(i,(n+1)) = 3;  % uc komsu oldugunu matrise yazalim 
    else
        neighbor_matrix(i,n+2) = 1 ;  %agent is lost
        
    end
end
assignin('base', 'neighbor_matrix'  , neighbor_matrix)  ;

end

