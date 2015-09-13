X_positions = evalin('base', 'X_positions');
Y_positions = evalin('base', 'Y_positions');

total_energy = 0;

tmp = size(X_positions);


for i = 1 : 1 : tmp(1) - 1
  delta_line = (X_positions(i+1,:) - X_positions(i,:)).^2 + (Y_positions(i+1,:) - Y_positions(i,:)).^2;
  delta_line = sqrt(delta_line);
  total_energy = total_energy + sum(delta_line);
end

total_energy
total_time = tmp(1) / 2 % seconds