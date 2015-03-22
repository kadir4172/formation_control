  n   = evalin('base', 'n');
  X   = evalin('base', 'X');
  Y   = evalin('base', 'Y');
  mrec_active   = evalin('base', 'mrec_active');
  E1  = evalin('base', 'mrec_E1');
  E2  = evalin('base', 'mrec_E2');
  E3  = evalin('base', 'mrec_E3');
  farthest_agent_index  = evalin('base', 'farthest_agent_index');
  mean  = evalin('base', 'mrec_mean');
  theta = evalin('base', 'mrec_theta');
  

  farthest_agent_index(1) = 1;
  theta = atan2 ((Y(farthest_agent_index(1)) - mean(2)),(X(farthest_agent_index(1)) - mean(1)));
  
  
  pos_array = [X' ; Y'];
  
  %mean  = sum(pos_array,2) ./ n;
  
  R = [cos(theta) -sin(theta); sin(theta) cos(theta)];
  
  H1 = eye(2) + (R^2) * E2;
  H2 = eye(2) - (R^2) * E2;
  
  s1 = 0;
  s2 = 0;
  for i = 1 : 1 : n
    s1 = s1 + ((pos_array(:,i) - mean)' * H1 * (pos_array(:,i) - mean));
    s2 = s2 + ((pos_array(:,i) - mean)' * H2 * (pos_array(:,i) - mean));
  end
  
  s1 = s1 / (2 * (n-1));
  s2 = s2 / (2 * (n-1));

   
  %s1 = 5;
  %s2 = 5;
  %R = eye(2);
  %theta = 0;

  assignin('base', 'mrec_theta', theta);
  assignin('base', 'mrec_R', R);
  assignin('base', 'mrec_s1', s1);
  assignin('base', 'mrec_s2', s2);
  assignin('base', 'farthest_agent_index', farthest_agent_index);
  
 