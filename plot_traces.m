X_positions = evalin('base', 'X_positions');
Y_positions = evalin('base', 'Y_positions');
formation_x = evalin('base', 'formation_x');
formation_y = evalin('base', 'formation_y');
n = evalin('base', 'n');
%n = 50;


cmap = hsv(n);  %# Creates a 50-by-3 set of colors from the HSV colormap
figure

for i = 1 : 1 : n
    plot(X_positions(:,i) , Y_positions(:,i),'Color',cmap(i,:));  
    hold on    
end

plot(obstacle_1_x, obstacle_1_y, 'g','LineWidth',2);
plot(obstacle_2_x, obstacle_2_y, 'g','LineWidth',2);
plot(obstacle_3_x, obstacle_3_y, 'g','LineWidth',2);
plot(formation_x , formation_y , 'r','LineWidth',2);
axis([-35,35,-35,35])
grid on
xlabel('X coordinates[m]')
ylabel('Y coordinates[m]')
title('Trajectories of the Agents towards the desired shape')
clear formation_x
clear formation_y
load formation1
hold on
plot(formation_x , formation_y , 'b','LineWidth',2);
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