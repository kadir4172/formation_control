clc
clear all
close all

animation_real_time = 20;
animation_time_step = 0.5;

load formation1
formation{1}.formation_x = formation_x;
formation{1}.formation_y = formation_y;

clear formation_x
clear formation_y

load formation_mutant11
formation{2}.formation_x = formation_x;
formation{2}.formation_y = formation_y;

clear formation_x
clear formation_y

load formation_mutant12
formation{3}.formation_x = formation_x;
formation{3}.formation_y = formation_y;

%%
counter = 1;
time_array = 0 : animation_time_step : animation_real_time;
for i = 1 : 1 : size(formation,2) - 1   
    for k = 1 : 1 : length(time_array)
      formation_animation{counter}.formation_x = (formation{i+1}.formation_x - formation{i}.formation_x) / length(time_array) * k + formation{i}.formation_x;
      formation_animation{counter}.formation_y = (formation{i+1}.formation_y - formation{i}.formation_y) / length(time_array) * k + formation{i}.formation_y;
      counter = counter + 1;
    end
end
%%



figure
title('real time animation')
for l = 1 : 1 : size(formation_animation,2)
  plot(formation_animation{l}.formation_x, formation_animation{l}.formation_y)
  pause(0.5)
end