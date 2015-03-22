function [total_shape_x, total_shape_y] = calc_minkowski_sum( obstacle_x, obstacle_y, robot_radius)

theta = 270;
for i = 1 : 1 : 4
  robot_x(i) = robot_radius * cosd(theta);
  robot_y(i) = robot_radius * sind(theta);
  theta = theta + 90 ;
end


n = length(obstacle_x);
m = length(robot_x);

k = 1;
for i = 1 : 1 : n
    for j = 1 : 1 : m
       total_shape_x(k) = obstacle_x(i) + robot_x(j);
       total_shape_y(k) = obstacle_y(i) + robot_y(j);
       k = k + 1;
    end
end
%{
while((i < n + 1) | (j < m + 1))
       k = k + 1;
       minkowski_shape_x(k) = obstacle_x(i) + agent_x(j);
       minkowski_shape_y(k) = obstacle_y(i) + agent_y(j);
       i
       j
       m
       n
       vector_obstacle_x = obstacle_x(i+1) - obstacle_x(i);
       vector_obstacle_y = obstacle_y(i+1) - obstacle_y(i);
       angle_obstacle = atan2(vector_obstacle_y,vector_obstacle_x) * 180 / pi;
       angle_obstacle = angle_obstacle + 360;
       angle_obstacle = mod(angle_obstacle, 360);
       
       
       vector_agent_x = agent_x(j+1) - agent_x(j);
       vector_agent_y = agent_y(j+1) - agent_y(j);
       angle_agent = atan2(vector_agent_y,vector_agent_x) * 180 / pi;
       angle_agent = angle_agent + 360;
       angle_agent = mod(angle_agent, 360);
     
       if(angle_obstacle < angle_agent)
           if(i < n + 1)
             i = i + 1;
           end
       elseif(angle_obstacle > angle_agent)
           if(j < m + 1)
             j = j + 1;
           end
       else
           if(j < m + 1)
             j = j + 1;
           end
           if(i < n + 1)
             i = i + 1;
           end
       end
     
end
  plot(minkowski_shape_x,minkowski_shape_y,'o')

%}
end

