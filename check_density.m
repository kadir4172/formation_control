%this script handles the operations to calculate the total volume of agents
%which are inside the shape

inside_outside_array = evalin('base', 'inside_outside_array');
n = evalin('base', 'n');
km = evalin('base', 'km');
kr = evalin('base', 'kr');
agents_zone = evalin('base', 'agents_zone');
formation_area = evalin('base', 'formation_area');
desired_density = evalin('base', 'desired_density');

agents_inside = 0;
total = 0;
for i = 1 : 1 : n
  if(inside_outside_array(i) == 1) % if the agent is inside the shape
    total = total + agents_zone(i);
    agents_inside = agents_inside + 1;
  end
end

density = total / formation_area;
%km = 6000;                     % give default value first
if(density > desired_density)  % if shape is full then increase km for better formation
  km = 750;
  kr = 1;
else
  if((agents_inside / n) > 0.9) % if shape is not full but there is no agents left, increase km harder for better formation
    km = 750;
    kr = 1;
  else
    km = 750;
    kr = 1;
  end
end

assignin('base', 'total_agent_inside_volume', total);
assignin('base', 'formation_density', density);
assignin('base', 'km', km);
assignin('base', 'kr', kr);