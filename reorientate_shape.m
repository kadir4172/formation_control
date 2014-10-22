%this script handles the reorientation of the formation shape
%if the user has entered a desired rotation 'theta' value

formation_x = evalin('base', 'formation_x');
formation_y = evalin('base', 'formation_y');
est_propogate_period = evalin('base', 'est_propogate_period');
theta_dot = evalin('base', 'mrec_theta_dot');
mean_dot = evalin('base', 'mrec_mean_dot');
s_dot = evalin('base', 'mrec_s_dot');
s1 = evalin('base', 'mrec_s1');
s2 = evalin('base', 'mrec_s2');
mean = evalin('base', 'mrec_mean');

n  = evalin('base', 'n');
formation_center  = evalin('base', 'formation_center');


if(s_dot ~= 0)
  s = s1 + s2;
  for i = 1 : 1 : length(formation_x)
    formation_x(i) = (((formation_x(i) - mean(1)) *s_dot) / (2 * s)) * est_propogate_period + formation_x(i);
    formation_y(i) = (((formation_y(i) - mean(2)) *s_dot) / (2 * s)) * est_propogate_period + formation_y(i);
  end
end

if(theta_dot ~= 0)
  for i = 1 : 1 : length(formation_x)
    angle = atan2 ((formation_y(i) - mean(2)),(formation_x(i) - mean(1)));
    angle = angle + theta_dot;
    distance = sqrt((formation_x(i) - mean(1))^2 + (formation_y(i) - mean(2))^2);
    [x_comp y_comp] = pol2cart(angle,distance);
    formation_x(i) = (mean(1) + x_comp - formation_x(i)) * est_propogate_period + formation_x(i);
    formation_y(i) = (mean(2) + y_comp - formation_y(i)) * est_propogate_period + formation_y(i);
  end
end

if(mean_dot ~= 0)
  for i = 1 : 1 : length(formation_x)
    formation_x(i) = formation_x(i) + mean_dot(1) * est_propogate_period;
    formation_y(i) = formation_y(i) + mean_dot(2) * est_propogate_period;
  end
end

  assignin('base', 'formation_x', formation_x);
  assignin('base', 'formation_y', formation_y);