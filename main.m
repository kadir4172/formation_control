clc
clear all

real_time_scale = 4;

%seri portu acalým
s = serial('COM10', 'BaudRate', 9600, 'DataBits', 8 , 'StopBits', 1, 'Parity', 'none')
fopen(s);
%seri portu acalým
kill_active = 0;
start_cam_module;
cam_data = zeros(20,1);
%cam_receive ile kalkacak
test_module = 1;
%cam_receive ile kalkacak

%cam calibration variables
left_trim = 35;
right_trim = 40;
up_trim = 30;
down_trim = 15;
area_size = 0;
%cam calibration variables


%loop periodlari(saniye cinsinden)
est_propogate_period = 0.5;
est_update_period    = 5;

%n tane agent i ve state lerini generate edelim
n = 5; % n bes kalsin
x_max = 1;
y_max = 0.75;
[X, Y]  = generate_MAS(n);
X_real = X;
Y_real = Y;
Xdot    = zeros(n,1);
Ydot    = zeros(n,1);
Xdotdot = zeros(n,1);
Ydotdot = zeros(n,1);
Xdot_real    = zeros(n,1);
Ydot_real    = zeros(n,1);
Xdotdot_real = zeros(n,1);
Ydotdot_real = zeros(n,1);
heading_robots = zeros(n,1);
feedback_matrix = [];
dt = 0;
use_real_positions = 0;

%agent sayisinin %10 u kadar PA ayarla
PA_number = round(n/5);
PA_index  = round(rand(PA_number,1) * n);


%test_module
%X = X_real;
%Y = Y_real;
%Xdot = Xdot_real;
%Ydot = Ydot_real;
%Xdotdot = Xdotdot_real;
%Ydotdot = Ydotdot_real;
%X = (0 : 1 : n-1)'./5;
%Y = (0 : 1 : n-1)'./5;
%Xdot = 0;
%Ydot = 0;
%Xdotdot = 0;
%Ydotdot = 0;
%test_module

radius1 = 0.075;
radius2 = 0.10;
radius3 = 0.125;
agents_radius = [radius3 radius2 radius2 radius1 radius1];
farthest_agent_index = zeros(2,1);
conversion_index = 360; % [matlab] / [cm]
agents_radius_matlab = conversion_index .* agents_radius;
agents_zone_matlab = pi .* (agents_radius_matlab.^2);
agents_zone = pi .* (agents_radius.^2);
total_agent_volume = sum(agents_zone);
total_agent_inside_volume = 0;
%rank increment
rank_increment = 1;

%agent_no/rank/zone kolonlari ile route_table olusturalim
route_table = ones(n,3);

%distance to all agents matrix
dist_to_agents = zeros(n,n);

%neighborhood matrisi olusturalim
neighbor_matrix = zeros(n,n+2);


%lost_agent_matrix tanimi
lost_agent_matrix = zeros(n,2);

%agent_covarage tanimlayalim
agent_coverage = 20;



% indeksi 0 olanlarin indeksini bir arttir
ind = find(~PA_index);
PA_index(ind) = PA_index(ind) + 1;

%ayni olan beacon indekslerini sil
PA_index = unique(PA_index);
PA_number = length(PA_index);

%artan sirayla indeksleri sirala
PA_index = sort(PA_index);

%scatter plot variables
scale = zeros(n,1);
color = zeros(n,1);

%formation data yaratalim
formation_x = 0;
formation_y = 0;


%formation a iliskin datalar
formation_length = 0;
formation_center = 0;
formation_area   = 0;
formation_density = 0;
desired_density = 0.250;
desired_density_min = 0.15;
formation_sendto_gazebo = 0 ;
%formation noktalari arasindaki mesafe
pen_length = 0.01;

%obstacle verileri
get_new_obstacles = 0;
obstacle_1_x = 0;
obstacle_1_y = 0;
obstacle_2_x = 0;
obstacle_2_y = 0;
obstacle_3_x = 0;
obstacle_3_y = 0;
obstacle_number = 0;
obstacle_global = 0;
shape_buffer = 0.03;
offline_shape_buffer = 0.08;
grid_map = [];
search_step = 0.064;
set_obstacles;

%formation bilgisini bir kez alalim TODO:daha sonra surekli dinamik
%yapilmali
pen;

%P matrix for state estimation
P = zeros(2,2,n);

%Artificial forces for individual members
calculate_forces_flag = 0;
x_swarm_flag = 0;
force_matrix = zeros(2,7,n);
inside_outside_array = zeros(n,1);


ka = 0;
kr = 0.00001;
kf = 0;
km = 400 ;
ko = 0;
ka2 = 0;
kgoal1 = 700;
kgoal2 = 1100;
max_force = 100;
max_goal_state_force = 2.5;
%Artificial forces for individual members


%mrec variable definitions
mrec_mean = zeros(2,1);
mrec_E1 = [0 1 ; 1 0 ];
mrec_E2 = [1 0 ; 0 -1];
mrec_E3 = [0 -1; 1 0 ];
mrec_R  = zeros(2,2);
mrec_theta = 0;
mrec_s1 = 0;
mrec_s2 = 0;
mrec_active = 0;
mrec_theta_dot = 0;
mrec_mean_dot  = 0;
mrec_s_dot     = 0;
mrec_theta_dif = 0;
mrec_s_dif     = 0;
mrec_mean_dif  = 0;
%mrec variable definitions

%offlline formation datalari
X_offline = X;
Y_offline = Y;
Xdot_offline = X .*0;
Ydot_offline = Y .*0;

offline_ka = 10000;
offline_kr = 12.0;
offline_km =  1300;
offline_ko =  0;
offline_ka2 = 90000;

offline_force_matrix = zeros(2,7,n);
offline_inside_outside_array = zeros(n,1);

offline_dt = 0;
GoalStatePos1= 0;
GoalStatePos2= 0;
GoalStatePos3= 0;

cam_receive
propogate_states

formation_ok = 0;
%==========================%
%zone tanimlamalari
field1 = 'matrix';  value1 = 0;
field2 = 'sayac';   value2 = 1;

  for(i = 1 : 1 : PA_number)
    zone(i) = struct(field1,value1,field2,value2);
  end
%==========================%

%==========================%
%propogate_states_loop timer ini baslatalim
propogate_states_loop;

%update_states_loop timer ini baslatalim
update_states_loop;
%==========================%

%==========================%
%scatter plot ile zone lar renk ve rank lar boyut olacak sekilde cizelim
scale = route_table(:,2).^3 * 5;
color = route_table(:,3);
figure
%h = scatter(X, Y,scale, color, 'fill');
%h = scatter(X, Y);

%agent indexleri gosterecek text object leri yaratalim
%for i = 1 : 1 : n
 % g(i) = text(X(i),Y(i), int2str(i));
%end

%for i = 1 : 1 : n
 % m(i) = text(X_real(i),Y_real(i),int2str(i),'color','r');
%end

axis([-1*x_max,x_max,-1*y_max,y_max])
hold on
%set(h,'XDataSource','X');
%set(h,'YDataSource','Y');
%set(h,'CDataSource','color');
%==========================%



%==========================%
%Agentlari agent zone lari ile plot edelim (estimated pozisyonlar)
if(use_real_positions == 0)
  k = scatter(X, Y, agents_zone_matlab);
  set(k,'XDataSource','X');
  set(k,'YDataSource','Y');
end
%==========================%

%==========================%
%Agentlari agent zone lari ile plot edelim (gercek pozisyonlar)
if(use_real_positions == 1)
l = scatter(X_real, Y_real, agents_zone_matlab,'r');
set(l,'XDataSource','X_real');
set(l,'YDataSource','Y_real');
end
%==========================%



%==========================%
%formation seklini plot edelim
%figure
j = plot(formation_x, formation_y);
set(j,'XDataSource','formation_x');
set(j,'YDataSource','formation_y');
axis([-1*x_max,x_max,-1*y_max,y_max])
%==========================%

%==========================%
%obstacle lari plot edelim

%figure
%plot(obstacle_1_x, obstacle_1_y, 'g');
%plot(obstacle_2_x, obstacle_2_y, 'g');
%plot(obstacle_3_x, obstacle_3_y, 'g');
%==========================%

%comment in to figure the startup offline formation order

b = scatter(X_offline, Y_offline, agents_zone_matlab,'r');
set(b,'XDataSource','X_offline');
set(b,'YDataSource','Y_offline');
%{
m = plot(formation_x, formation_y);
set(m,'XDataSource','formation_x');
set(m,'YDataSource','formation_y');
%}
%comment in to figure the startup offline formation order



linkdata on
%tum agentler in ilk konumunu ciz ve linkdata enable et
%h = plot(X,Y,'o')
%set(h,'XDataSource','X');
%set(h,'YDataSource','Y');
%linkdata on



