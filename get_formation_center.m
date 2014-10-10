formation_x = evalin('base', 'formation_x');
formation_y = evalin('base', 'formation_y');


array_length = length(formation_x);
formation_x(array_length + 1) = formation_x(1);
formation_y(array_length + 1) = formation_y(1);

z = [formation_x' formation_y'];

formation_center_real = 0;
formation_center_imag = 0;
for i = 1 : 1 : array_length
   formation_center_real = formation_center_real + z(i,1);
   formation_center_imag = formation_center_imag + z(i,2);
end
formation_center_real = formation_center_real / array_length;
formation_center_imag = formation_center_imag / array_length;

formation_center = complex(formation_center_real, formation_center_imag);
assignin('base', 'formation_center', formation_center);
