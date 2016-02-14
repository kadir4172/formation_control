X_positions = evalin('base', 'X_positions');
Y_positions = evalin('base', 'Y_positions');
formation_x = evalin('base', 'formation_x');
formation_y = evalin('base', 'formation_y');
FORMATIONS = evalin('base', 'FORMATIONS');
n = evalin('base', 'n');
%n = 50;

grid_map = [];
set_obstacles

sample_to_plot = 300;

%cmap = hsv(n);  %# Creates a 50-by-3 set of colors from the HSV colormap
figure

% for i = 1 : 1 : n
%     plot(X_positions(:,i) , Y_positions(:,i),'Color',cmap(i,:));  
%     hold on    
% end

formation_x = FORMATIONS(sample_to_plot).formation_x;
formation_y = FORMATIONS(sample_to_plot).formation_y;
f = figure(1)
plot(obstacle_1_x, obstacle_1_y, 'g','LineWidth',2);
hold on
plot(obstacle_2_x, obstacle_2_y, 'g','LineWidth',2);
plot(obstacle_3_x, obstacle_3_y, 'g','LineWidth',2);
plot(formation_x , formation_y , 'r','LineWidth',2);
axis([-35,35,-35,35])
grid on
xlabel('X coordinates[m]')
ylabel('Y coordinates[m]')
title(['Formation Shape and Agents'' Positions at Time:', num2str(sample_to_plot)])
clear formation_x
clear formation_y
load formation1
hold on

%plot(X_positions(i,:) , Y_positions(i,:), 'o'); 
% for i = 1 : 1 : length(formation_start_x)
%   text(formation_start_x(i),formation_start_y(i),num2str(i))
%   genio(i).h = impoint(gca,formation_start_x(i),formation_start_y(i)); 
% end
ax = gca;
for j = 1 : 1 : length(X_positions(i,:))
    
   k = scatter(X_positions(i,j), Y_positions(i,j), agents_zone_matlab(j));
   h(i).handle = impoint(gca, X_positions(i,j), Y_positions(i,j));
  % genio(j).h = impoint(gca,X_positions(i,j),Y_positions(i,j)); 
end


% 
% clear formation_x
% clear formation_y
% load formation4
% hold on
% plot(formation_x , formation_y , 'm','LineWidth',2);
% 
% clear formation_x
% clear formation_y
% load formation3
% hold on
% plot(formation_x , formation_y , 'k','LineWidth',2);
% 
% clear formation_x
% clear formation_y
% load formation5
% hold on
% plot(formation_x , formation_y , 'r','LineWidth',2);
% calculate_energy_time_consumption