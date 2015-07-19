formation_x = evalin('base', 'formation_x');
formation_y = evalin('base', 'formation_y');


array_length = length(formation_x);
formation_x(array_length + 1) = formation_x(1);
formation_y(array_length + 1) = formation_y(1);

z = [formation_x' formation_y'];

formation_length = 0;
for i = 1 : 1 : array_length
  delta_x = (z((i+1),1) - z(i,1));
  delta_y = (z((i+1),2) - z(i,2));
  formation_length = formation_length + norm([delta_x delta_y]);
end

assignin('base', 'formation_length', formation_length);