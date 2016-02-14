X  = evalin('base', 'X');
Y  = evalin('base', 'Y');
FORMATIONS  = evalin('base', 'FORMATIONS');
formation_x = evalin('base', 'formation_x');
formation_y = evalin('base', 'formation_y');

X_positions = evalin('base', 'X_positions');
Y_positions = evalin('base', 'Y_positions');
trace_steps = 0.01;
if(isempty(X_positions))
 X_positions = X';
 Y_positions = Y';
else
 delta = sqrt((X_positions(end, :) - X').^2 + (Y_positions(end, :) - Y').^2) ;
 [val,ind] = find(abs(delta) > trace_steps);
 
 new_line = X_positions(end, :);
 new_line(ind) = X(ind);
 X_positions = [X_positions; new_line];
 
 new_line = Y_positions(end, :);
 new_line(ind) = Y(ind);
 Y_positions = [Y_positions; new_line];
  
end
formation_tmp.formation_x = formation_x;
formation_tmp.formation_y = formation_y;
FORMATIONS = [FORMATIONS formation_tmp];
  assignin('base', 'X_positions', X_positions);
  assignin('base', 'Y_positions', Y_positions);
  assignin('base', 'FORMATIONS', FORMATIONS);
  