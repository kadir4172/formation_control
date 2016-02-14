clc
clear all
close all

clc
animation_real_time = 20;
animation_time_step = 0.5;
%load formation which you want to create a mutant of
load formation_mutant11

formation_start_x = formation_x;
formation_start_y = formation_y;
clear formation_x;
clear formation_y;
m = figure

dot_count = length(formation_start_x)
for i = 1 : 1 : length(formation_start_x)
  text(formation_start_x(i),formation_start_y(i),num2str(i))
  genio(i).h = impoint(gca,formation_start_x(i),formation_start_y(i)); 
end

grid minor

prompt = 'End Shape is ready for animation(Y/N)? ';
str = input(prompt,'s')

%%

for i = 1 : 1 : length(formation_start_x)
 formation_new(i,:) = getPosition(genio(i).h);
end
formation_new_x = formation_new(:,1)';
formation_new_y = formation_new(:,2)';

time_array = 0 : animation_time_step : animation_real_time;
for k = 1 : 1 : length(time_array)
  formation_animation{k}.formation_start_x = (formation_new_x - formation_start_x) / length(time_array) * k + formation_start_x;
  formation_animation{k}.formation_start_y = (formation_new_y - formation_start_y) / length(time_array) * k + formation_start_y;
end


figure
title('real time animation')
for l = 1 : 1 : size(formation_animation,2)
  plot(formation_animation{1,l}.formation_start_x, formation_animation{1,l}.formation_start_y)
  pause(0.5)
end

