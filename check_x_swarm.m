%this script serves for checking of the X-swarmness of the swarm
format long
dist_to_agents  = evalin('base', 'dist_to_agents');
mean = evalin('base', 'mrec_mean');
X = evalin('base', 'X');
Y = evalin('base', 'Y');
n = evalin('base', 'n');
ka = evalin('base', 'ka');
km = evalin('base', 'km');
formation_length = evalin('base', 'formation_length');
dist_to_agents = evalin('base', 'dist_to_agents');
formation_x = evalin('base', 'formation_x');
z = [X';Y'];

%rates to increase to get internal stability
km_rate = 10;
ka_rate = 2;


for i = 1 : 1 : n
  bias = (n.* z(:,i) - mean .* n) / (n * (n-1));
  sw = (z(:,i) - mean + bias)  ./ (z(:,i) - mean);
  X_sw(i) = norm(sw);
end

X_SW = max(X_sw);
minimum_distance = min(dist_to_agents(find(dist_to_agents > 0)));

sigma = minimum_distance / (X_SW) ^(1/3);
delta = minimum_distance - sigma;

if ((sigma > 0) & (delta > 0)) % X_Swarm condition is achieved then we will check for decreasing energy(Theorem 2)
  x_swarm_flag = 1;
  ratio = (n-1) / (sigma ^ 3 * formation_length);
  value = ka/(length(formation_x) * km);
  if(ratio > value)           %Theorem 2 does not hold 
    %ka = ka + ka_rate;       %TODO add some logical thing to provide theory
  end
else                           % X_Swarm condition cannot be achieved, so increase km to give more distances between agents
  x_swarm_flag = 0;
  %km = km + km_rate
end
assignin('base', 'x_swarm_flag', x_swarm_flag);
assignin('base', 'km', km);
assignin('base', 'ka', ka);

format short