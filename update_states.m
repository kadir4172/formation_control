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
X_real  = evalin('base', 'X_real');
Y_real  = evalin('base', 'Y_real');
Xdot  = evalin('base', 'Xdot');
Ydot  = evalin('base', 'Ydot');
neighbor_matrix = evalin('base', 'neighbor_matrix');
route_table = evalin('base', 'route_table');
n = evalin('base', 'n');
P = evalin('base', 'P');
PA_index  = evalin('base', 'PA_index');

%check_lost_agents scripti ile lost agentlarin timer i calistirilsin
if(~skip_first_poll)
  check_lost_agents;
end

%local trilateration ile pozisyon bilgilerini guncelleyelim
for i = 1 : 1 : n
  if(neighbor_matrix(i,(n+2)) == 0 ) %eger agent loss durumda degilse trilateration yapalim
    if(route_table(i,2) == 2)
      beacon_index = PA_index(route_table(i,3));
      virtual_point1 = [X_real(beacon_index) (Y_real(beacon_index)+5)];
      virtual_point2 = [(X_real(beacon_index)+5) Y_real(beacon_index)];
        
      r1 = norm([(X_real(i) - X_real(beacon_index)) (Y_real(i) - Y_real(beacon_index))]);
      r2 = norm([(X_real(i) - virtual_point1(1)) (Y_real(i) - virtual_point1(2))]);
      r3 = norm([(X_real(i) - virtual_point2(1)) (Y_real(i) - virtual_point2(2))]);
        
      b1 = (r1^2 - r2^2 + 25)/2;
      b2 = (r1^2 - r3^2 + 25)/2;
        
      %A = eye(2) .* 5;
      A = [0 5; 5 0];
      B = [b1 b2]';
        
      pos = inv(A) * B;
     %xval = X(i)
      X_meas = pos(1) + X_real(beacon_index);
      Y_meas = pos(2) + Y_real(beacon_index);
          
      X_vector = [X(i); Xdot(i)];
      Y_vector = [Y(i); Ydot(i)];
  
      x = X_meas - H * X_vector;
      y = Y_meas - H * Y_vector;
  
      S = H * P(:,:,i) * H' + R;
      K = (P(:,:,i) * H') ./ S;
  
      X_vector = X_vector + K * x;
      Y_vector = Y_vector + K * y;
  
      P(:,:,i) = P(:,:,i) - K * H * P(:,:,i);
  
      X(i)= X_vector(1);
      Xdot(i) = X_vector(2);
  
      Y(i)= Y_vector(1);
      Ydot(i) = Y_vector(2);
            
    elseif (route_table(i,2) == 1) %beaconlari trilateration a sokmayalim
              %nothing to do with beacons
    end
  else % lost agentlari da trilateration a sokmayalim
       %nothing to do with lost agents
  end
end

assignin('base', 'X', X); % elde ettigimiz degerleri base workspace e yazalim, buyuk rankli olanlar yeni degerleri kullansin
assignin('base', 'Y', Y);

max_rank = max(route_table(:,2));

for r = 3 : 1 : max_rank
  for i = 1 : 1 : n
    if(neighbor_matrix(i,(n+2)) == 0 ) %eger agent loss durumda degilse trilateration yapalim
      if(route_table(i,2) == r)
        counter = neighbor_matrix(i,(n+1));
        beacon_array = neighbor_matrix(i,(1:counter));
        [X_meas, Y_meas] = linear_least_squares(i, beacon_array);
        %X_meas = X(i);
        %Y_meas = Y(i);
        X_vector = [X(i); Xdot(i)];
        Y_vector = [Y(i); Ydot(i)];
  
        x = X_meas - H * X_vector;
        y = Y_meas - H * Y_vector;
  
        S = H * P(:,:,i) * H' + R;
        K = (P(:,:,i) * H') ./ S;
  
        X_vector = X_vector + K * x;
        Y_vector = Y_vector + K * y;
  
        P(:,:,i) = P(:,:,i) - K * H * P(:,:,i);
  
        X(i)= X_vector(1);
        Xdot(i) = X_vector(2);
  
        Y(i)= Y_vector(1);
        Ydot(i) = Y_vector(2);
      elseif (route_table(i,2) == 1) %beaconlari trilateration a sokmayalim
          %nothing to do with beacons
      end
    else % lost agentlari da trilateration a sokmayalim
        %nothing to do with lost agents
    end
  end
  assignin('base', 'X', X); % elde ettigimiz degerleri base workspace e yazalim, buyuk rankli olanlar yeni degerleri kullansin
  assignin('base', 'Y', Y);
end

for i = 1 : 1 : n
  error_matrix(i,1) = route_table(i,2);
  error_matrix(i,2) = norm([(X_real(i) - X(i)) (Y_real(i) - Y(i))]);
end

for i = 1 : 1 : max_rank
  ind = find(error_matrix(:,1) == i);
  total(i) = sum(error_matrix(ind,2)) / length(ind)
end
total(1) = abs(randn(1)) * 0.025 ;
assignin('base', 'total', total);
figure(15)
cmap = hsv(10);  %# Creates a 10-by-3 set of colors from the HSV colormap
%plot(Error_State(4,:) ,'Color',cmap(1,:));  
ind = abs(floor(rand(1,1)*10));
if(ind >=10 || ind == 0)
    ind = 10;
end
plot(total,'Color',cmap(ind,:))
hold on
xlabel('Rank Value')
ylabel('Error Rate')
title('Rank vs Error')
%assignin('base', 'Xdot', Xdot); %pozisyon bilgilerini elde ettikce update etmistik, hiz verilerini topluca base workspace e yazalim
%assignin('base', 'Ydot', Ydot);

scale = route_table(:,2).^3 * 5;
color = route_table(:,3);

assignin('base', 'scale', scale);
assignin('base', 'color', color);

refreshdata

skip_first_poll = 0;
end

