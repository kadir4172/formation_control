
n = evalin('base', 'n');
agents_radius = [0.18 0.36 0.6]; % 20 20 10 
for  i = 1 : 1 :n
    if(i < 21)
agents_zone(i) = agents_radius(1);
    elseif(i<41)
        agents_zone(i) = agents_radius(2);
    else
        agents_zone(i) = agents_radius(3);
    end

end

conversion_index = 13.641; % [matlab] / [cm]
agents_radius_matlab = conversion_index .* agents_zone;
length(agents_radius_matlab)
agents_zone_matlab = pi .* (agents_radius_matlab.^2);

figure
axis([-35,35,-35,35])
hold on
X = [GoalStatePos1(:,1); GoalStatePos2(:,1); GoalStatePos3(:,1)];
Y = [GoalStatePos1(:,2); GoalStatePos2(:,2); GoalStatePos3(:,2)];
k = scatter(X, Y, agents_zone_matlab);
plot(formation_x, formation_y,'r')
title('Formation Filled with Potential Fields')


figure
axis([-35,35,-35,35])
hold on
X = [GoalStateFractalPos1(:,1); GoalStateFractalPos2(:,1); GoalStateFractalPos3(:,1)];
Y = [GoalStateFractalPos1(:,2); GoalStateFractalPos2(:,2); GoalStateFractalPos3(:,2)];
k = scatter(X, Y, agents_zone_matlab,'r');
plot(formation_x, formation_y)
title('Formation Filled with Fractals')