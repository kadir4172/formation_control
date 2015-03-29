%iki nokta arasi sabit mesafe degeri
pen_length = evalin('base', 'pen_length');

%ham formation_x/y verilerini alalim
formation_x = evalin('base', 'formation_x');
formation_y = evalin('base', 'formation_y');


%formation_x/y genliklerini +/-100 arasina tasiyalim
formation_x = formation_x * 200 - 100;
formation_y = formation_y * 200 - 100;


array_length = length(formation_x);
distance = norm ([(formation_x(1) - formation_x(array_length)) (formation_y(1) - formation_y(array_length))]);
max_distance = pen_length * 100;

%ilk ve son noktalar arasindaki mesafe belirledigimiz sabit iki nokta arasi
%mesafeden buyukse araya sanal noktalar dolduralim
if(distance > max_distance)
extra_dot_number = floor(distance / max_distance);
  for i = 1 : 1 : extra_dot_number
     formation_x(array_length + i) = formation_x(array_length) + (((formation_x(1) - formation_x(array_length)) * (pen_length * i * 100)) / distance);
     formation_y(array_length + i) = formation_y(array_length) + (((formation_y(1) - formation_y(array_length)) * (pen_length * i * 100)) / distance);
  end
end

formation_gain = 0.35;
formation_x = formation_x * formation_gain;
formation_y = formation_y * formation_gain;


assignin('base', 'formation_x', formation_x);
assignin('base', 'formation_y', formation_y);

get_formation_center  %cizilen ve islenen formationin merkezini bulalim
get_formation_length  %cizilen ve islenen formationin uzunlugunu bulalim
get_formation_area    %cizilen ve islenen formationin alanini bulalim


run_offline_formation

formation_sendto_gazebo = 1;
assignin('base', 'formation_sendto_gazebo', formation_sendto_gazebo);




calculate_forces_flag  = 1;
assignin('base', 'calculate_forces_flag', calculate_forces_flag);


