clc
clear

%loop periodlari(saniye cinsinden)
est_propogate_period = 0.5;
est_update_period    = 10;

%n tane agent i random generate et
n = 100;
[X, Y]  = generate_MAS(n);
Xdot    = zeros(n,1);
Ydot    = zeros(n,1);
Xdotdot = zeros(n,1);
Ydotdot = zeros(n,1);

%rank increment
rank_increment = 1;

%agent_no/rank/zone kolonlari ile route_table olusturalim
route_table = ones(n,3);

%distance to all agents matrix
dist_to_agents = zeros(n,n);

%neighborhood matrisi olusturalim
neighbor_matrix = zeros(n,4);
neighbor_distance = zeros(n,3);

%lost_agent_matrix tanimi
lost_agent_matrix = zeros(n,2);

%agent_covarage tanimlayalim
agent_coverage = 20;

%agent sayisinin %10 u kadar PA ayarla
PA_number = round(n/10);
PA_index  = round(rand(PA_number,1) * n);

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

%formation noktalari arasindaki mesafe
pen_length = 0.01;

%formation bilgisini bir kez alalim TODO:daha sonra surekli dinamik
%yapilmali
pen;

%P matrix for state estimation
P = zeros(2,2,n);

%Artificial forces for individual members
calculate_forces_flag = 0;
force_matrix = zeros(2,5,n);
inside_outside_array = zeros(n,1);

%ka = 4* 10^(-3);
ka = 1.5;
kr = 8000;
kf = 1000;
km = 4000;

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
%update_states_loop;
%==========================%

%==========================%
%scatter plot ile zone lar renk ve rank lar boyut olacak sekilde cizelim
scale = route_table(:,2).^3 * 5;
color = route_table(:,3);
figure
%h = scatter(X, Y,scale, color, 'fill');
%h = scatter(X, Y);

%agent indexleri gosterecek text object leri yaratalim
for i = 1 : 1 : n
  g(i) = text(X(i),Y(i), int2str(i));%, 'VerticalAlignment','up','HorizontalAlignment','center');
end

axis([-100,100,-100,100])
%set(h,'XDataSource','X');
%set(h,'YDataSource','Y');
%set(h,'CDataSource','color');
%==========================%

%==========================%
%formation seklini plot edelim
figure
j = plot(formation_x, formation_y);
set(j,'XDataSource','formation_x');
set(j,'YDataSource','formation_y');
axis([-100,100,-100,100])
%==========================%


linkdata on
%tum agentler in ilk konumunu ciz ve linkdata enable et
%h = plot(X,Y,'o')
%set(h,'XDataSource','X');
%set(h,'YDataSource','Y');
%linkdata on



