function [] = propogate_states(  )
%ivme olcumleri bu fonksiyonun argumani olacaktir(TODO).

persistent Q;
persistent F;
persistent B;

%Q matrisleri icin gerekli bilesenler
dt = evalin('base', 'est_propogate_period');
accel_noise = 2;
n = evalin('base', 'n');
%g = evalin('base', 'g');
%m = evalin('base', 'm');

mrec_active = evalin('base', 'mrec_active');
 
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
X_real  = evalin('base', 'X_real');
Y_real  = evalin('base', 'Y_real');
Xdot_real  = evalin('base', 'Xdot_real');
Ydot_real  = evalin('base', 'Ydot_real');
P = evalin('base','P');
PA_index = evalin('base','PA_index');

force_matrix = evalin('base','force_matrix');

%gercek uygulamada arguman olarak gelen ivme degerleri gelecek(TODO)
%X_accelmeas = rand(n,1) * 0.5  -0.25 ;
%Y_accelmeas = rand(n,1) * 0.5  -0.25 ;

if(mrec_active == 1)
  X_accelmeas = zeros(n,1);
  Y_accelmeas = zeros(n,1);
  X_accelmeas_noisy = zeros(n,1);
  Y_accelmeas_noisy = zeros(n,1);
else
  X_accelmeas = force_matrix(1,7,:) /10000;
  Y_accelmeas = force_matrix(2,7,:) /10000;
  X_accelmeas_noisy(1,1,:) = rand(n,1) * 0.050 - 0.0250;
  X_accelmeas_noisy(1,1,PA_index) = 0;              % PA larin ivmeleri gurultusuz olsun
  %X_accelmeas_noisy(1,1,:) = zeros(n,1);
  X_accelmeas_noisy = X_accelmeas_noisy + force_matrix(1,7,:) /10000;
  Y_accelmeas_noisy(1,1,:) = rand(n,1) * 0.050 - 0.0250;
  Y_accelmeas_noisy(1,1,PA_index) = 0;              % PA larin ivmeleri gurultusuz olsun
  %Y_accelmeas_noisy(1,1,:) = zeros(n,1);
  Y_accelmeas_noisy = Y_accelmeas_noisy + force_matrix(2,7,:) /10000;
end

for i = 1 : 1 : n
  X_vector_old = [X(i); Xdot(i)];
  Y_vector_old = [Y(i); Ydot(i)];  

  X_vector = F * X_vector_old + B * X_accelmeas_noisy(i);
  Y_vector = F * Y_vector_old + B * Y_accelmeas_noisy(i);
  
  P(:,:,i) = F * P(:,:,i) * F' + Q;

  X(i)= X_vector(1);
  Xdot(i) = X_vector(2);
  
  
  Y(i)= Y_vector(1);
  Ydot(i) = Y_vector(2);
    
end

for i = 1 : 1 : n
  X_real_vector_old = [X_real(i); Xdot_real(i)];
  Y_real_vector_old = [Y_real(i); Ydot_real(i)];  

  X_real_vector = F * X_real_vector_old + B * X_accelmeas(i);
  Y_real_vector = F * Y_real_vector_old + B * Y_accelmeas(i);
  
  X_real(i)    = X_real_vector(1);
  Xdot_real(i) = X_real_vector(2);
  
  
  Y_real(i)    = Y_real_vector(1);
  Ydot_real(i) = Y_real_vector(2);
    
end

assignin('base', 'X', X);
assignin('base', 'Y', Y);
assignin('base', 'Xdot', Xdot);
assignin('base', 'Ydot', Ydot);
assignin('base', 'Xdotdot', X_accelmeas_noisy);
assignin('base', 'Ydotdot', Y_accelmeas_noisy);
assignin('base', 'X_real', X_real);
assignin('base', 'Y_real', Y_real);
assignin('base', 'Xdot_real', Xdot_real);
assignin('base', 'Ydot_real', Ydot_real);
assignin('base', 'Xdotdot_real', X_accelmeas);
assignin('base', 'Ydotdot_real', Y_accelmeas);
assignin('base', 'P', P);

  %for i = 1 : 1 :n
    %set(g(i),'Position',[X(i),Y(i),0]);
  %end
  
  %for i = 1 : 1 :n
    %set(m(i),'Position',[X_real(i),Y_real(i),0]);
  %end
  
%update center mass of the swarm
  pos_array = [X' ; Y'];
  mean  = sum(pos_array,2) ./ n;
  assignin('base', 'mrec_mean', mean);
%update center mass of the swarm
  
  
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
    check_x_swarm          %X_swarm kosullari saglaniyor mu diye bakalim
    check_density          %sekil icerisine giren agentlarin total volume larini bulalim
    set_attraction_forces  %seklin disindayken cekici kuvvetleri hesapla
    set_attraction2_forces %sinirdan gecemeyen agentlar icin aktif hale gelecek ekstra force
    set_repulsion_forces   %seklin icindeyken itici kuvvetleri hesapla
    set_intermember_forces %memberlarin kendi aralarinda olusturdugu itki kuvvetlerini hesapla
    set_friction_forces    %agentlar icin surtunme kuvvetlerini hesapla
    set_obstacle_forces    %agentlar icin obstacle lar tarafindan uretilen sanal kuvvetleri hesapla
    set_total_force        %tum force bilesenlerini toplayalim
    
    
    mrec_update
    mrec_propogate
  end
end

