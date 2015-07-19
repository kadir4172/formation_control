n  = evalin('base', 'n');
formation_x = evalin('base', 'formation_x');
formation_y = evalin('base', 'formation_y');
    
xp = formation_x;
yp = formation_y;

array_length = length(xp);
xp(array_length + 1) = xp(1);
yp(array_length + 1) = yp(1);

z = [xp' yp'];
 
part1    = 0;
part2    = 0;
for i = 1 : 1 : array_length
  delta_x = (z((i+1),1) - z(i,1));
  delta_y = (z((i+1),2) - z(i,2));

  part1 = part1 + (z(i,1) * delta_y);
  part2 = part2 + (z(i,2) * delta_x);
end

formation_area = abs((part1 - part2) / 2);
assignin('base', 'formation_area', formation_area);