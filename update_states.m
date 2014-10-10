function [ output_args ] = update_states( input_args )
persistent H;
persistent R;
persistent S;
persistent skip_first_poll;

if isempty(skip_first_poll)
  skip_first_poll = 1;
end

if isempty(H)
    H = [1 0];
end

%R degeri trilateration process indeki hata oranidir
if isempty(R)
    R = 3 ; 
end

if isempty(S)
    S = zeros(2,2);
end

%route table i agentlarin guncel pozisyonu icin guncelleyelim
update_route_table( );

%update_neighbor_matrix matrisini guncelleyelim
update_neighbor_matrix();


X  = evalin('base', 'X');
Y  = evalin('base', 'Y');
Xdot  = evalin('base', 'Xdot');
Ydot  = evalin('base', 'Ydot');
neighbor_matrix = evalin('base', 'neighbor_matrix');
neighbor_distance = evalin('base', 'neighbor_distance');
route_table = evalin('base', 'route_table');
n = evalin('base', 'n');
P = evalin('base', 'P');

%check_lost_agents scripti ile lost agentlarin timer i calistirilsin
if(~skip_first_poll)
  check_lost_agents;
end
%local trilateration ile pozisyon bilgilerini guncelleyelim
max_rank = max(route_table(:,2));

for r = 2 : 1 : max_rank
  for i = 1 : 1 : n
    %eger agent loss durumda degilse trilateration yapalim
    if(neighbor_matrix(i,4) == 0 )
        if(route_table(i,2) == r)
        %X_old = X(i)
        %Y_old = Y(i)
        [X_meas(i), Y_meas(i)] = linear_least_squares([X(neighbor_matrix(i,1)) Y(neighbor_matrix(i,1))], [X(neighbor_matrix(i,2)) Y(neighbor_matrix(i,2))], [X(neighbor_matrix(i,3)) Y(neighbor_matrix(i,3))], neighbor_distance(i,1),neighbor_distance(i,2),neighbor_distance(i,3));
        
        [X_meas(i), Y_meas(i)] = nonlinear_least_squares([X(neighbor_matrix(i,1)) Y(neighbor_matrix(i,1))], [X(neighbor_matrix(i,2)) Y(neighbor_matrix(i,2))], [X(neighbor_matrix(i,3)) Y(neighbor_matrix(i,3))], neighbor_distance(i,1),neighbor_distance(i,2),neighbor_distance(i,3), [X_meas(i); Y_meas(i)]);
        %X_yeni = X(i)
        %Y_yeni = Y(i)
        elseif (route_table(i,2) == 1) %beaconlari trilateration a sokmayalim
        X_meas(i) = X(i);
        Y_meas(i) = Y(i);       
        end
    else % lost agentlari da trilateration a sokmayalim
        X_meas(i) = X(i);
        Y_meas(i) = Y(i);
    end
  end
end

%local trilateration ile elde ettigimiz pozisyon bilgilerini state
%estimation a sokalim
for i = 1 : 1 : n
  X_vector = [X(i); Xdot(i)];
  Y_vector = [Y(i); Ydot(i)];
  
  x = X_meas(i) - H * X_vector;
  y = Y_meas(i) - H * Y_vector;
  
  S = H * P(:,:,i) * H' + R;
  K = (P(:,:,i) * H') ./ S;
  
  X_vector = X_vector + K * x;
  Y_vector = Y_vector + K * y;
  
  P(:,:,i) = P(:,:,i) - K * H * P(:,:,i);
  
  X(i)= X_vector(1);
  Xdot(i) = X_vector(2);
  
  Y(i)= Y_vector(1);
  Ydot(i) = Y_vector(2);
end

scale = route_table(:,2).^3 * 5;
color = route_table(:,3);


assignin('base', 'X', X);
assignin('base', 'Y', Y);

assignin('base', 'scale', scale);
assignin('base', 'color', color);

refreshdata

skip_first_poll = 0;
end

