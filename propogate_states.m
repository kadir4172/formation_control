function [] = propogate_states(  )
%ivme olcumleri bu fonksiyonun argumani olacaktir(TODO).

persistent Q;
persistent F;
persistent B;

%Q matrisleri icin gerekli bilesenler
dt = evalin('base', 'est_propogate_period');
accel_noise = 2;
n = evalin('base', 'n');
g = evalin('base', 'g');

if isempty(Q)
    Q = [(accel_noise*(dt^2))/2 0;0 accel_noise*dt];
end

if isempty(F)
    F = [1 dt; 0 1];
end

if isempty(B)
    B = [dt^2/2; dt];
end

X  = evalin('base', 'X');
Y  = evalin('base', 'Y');
Xdot  = evalin('base', 'Xdot');
Ydot  = evalin('base', 'Ydot');
P = evalin('base','P');

force_matrix = evalin('base','force_matrix');

%gercek uygulamada arguman olarak gelen ivme degerleri gelecek(TODO)
%X_accelmeas = rand(n,1) * 0.5  -0.25 ;
%Y_accelmeas = rand(n,1) * 0.5  -0.25 ;

X_accelmeas = force_matrix(1,5,:) /10000;
Y_accelmeas = force_matrix(2,5,:) /10000;

for i = 1 : 1 : n
  X_vector_old = [X(i); Xdot(i)];
  Y_vector_old = [Y(i); Ydot(i)];  

  %X_vector(1) = X_vector_old(1) + dt * X_vector_old(2) + ((dt^2)/2) * X_accelmeas(i);
  %X_vector(2) = X_vector_old(2) + dt * X_accelmeas(i);
  
  %Y_vector(1) = Y_vector_old(1) + dt * Y_vector_old(2) + ((dt^2)/2) * Y_accelmeas(i);
  %Y_vector(2) = Y_vector_old(2) + dt * Y_accelmeas(i);
  
  
  X_vector = F * X_vector_old + B * X_accelmeas(i);
  Y_vector = F * Y_vector_old + B * Y_accelmeas(i);
  
  P(:,:,i) = F * P(:,:,i) * F' + Q;

  X(i)= X_vector(1);
  Xdot(i) = X_vector(2);
  
  
  Y(i)= Y_vector(1);
  Ydot(i) = Y_vector(2);
  
  
end

assignin('base', 'X', X);
assignin('base', 'Y', Y);
assignin('base', 'Xdot', Xdot);
assignin('base', 'Ydot', Ydot);
assignin('base', 'Xdotdot', X_accelmeas);
assignin('base', 'Ydotdot', Y_accelmeas);
assignin('base', 'P', P);

  for i = 1 : 1 :n
    set(g(i),'Position',[X(i),Y(i),0]);
  end


%update distance to agents matrix  
dist_to_agents = zeros(n,n);
for i = 1 : 1 : n
    base_agent_X = X(i);
    base_agent_Y = Y(i);
    for j = 1 : 1 : n
      dist_to_agents(i,j) = norm ([(base_agent_X - X(j)) (base_agent_Y - Y(j))]);
    end
end
assignin('base', 'dist_to_agents', dist_to_agents);
%update distance to agents matrix  

calculate_forces_flag = evalin('base', 'calculate_forces_flag');
  if(calculate_forces_flag == 1) % eger gecerli bir formation shape varsa
  
      %pozisyon propogate bittikten sonra artificial force lari hesaplayalim
    set_inside_outside     %agentlari shape in icinde mi disindami hesaplayalim
    set_attraction_forces  %seklin disindayken cekici kuvvetleri hesapla
    set_repulsion_forces   %seklin icindeyken itici kuvvetleri hesapla
    set_intermember_forces %memberlarin kendi aralarinda olusturdugu itki kuvvetlerini hesapla
    set_friction_forces    %agentlar icin surtunme kuvvetlerini hesapla
    set_total_force        %tum force bilesenlerini toplayalim
    
  end
end

