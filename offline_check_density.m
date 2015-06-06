%this script handles the operations to calculate the total volume of agents
%which are inside the shape

%offline_inside_outside_array = evalin('base', 'offline_inside_outside_array');
n = evalin('base', 'n');
%km = evalin('base', 'km');
%kr = evalin('base', 'kr');
agents_zone = evalin('base', 'agents_zone');
formation_area = evalin('base', 'formation_area');
desired_density = evalin('base', 'desired_density');
desired_density_min = evalin('base', 'desired_density_min');

agents_inside = 0;
total = 0;
for i = 1 : 1 : n
    total = total + agents_zone(i);
    agents_inside = agents_inside + 1;
end

density = total / formation_area


if((desired_density_min < density) && (density < desired_density))
    formation_ok = 1;
else
    formation_ok = 0;
 end
assignin('base', 'formation_ok', formation_ok);
