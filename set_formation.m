function [  ] = set_formation( formation_index )

    clear formation_x;
    clear formation_y;

    str = ['formation' int2str(formation_index) '.mat']
    load(str)

     assignin('base', 'formation_x', formation_x);
     assignin('base', 'formation_y', formation_y);
     
     get_formation_center  %cizilen ve islenen formationin merkezini bulalim
get_formation_length  %cizilen ve islenen formationin uzunlugunu bulalim
get_formation_area    %cizilen ve islenen formationin alanini bulalim


run_offline_formation
use_fractals = evalin('base', 'use_fractals');

if(use_fractals==1 && formation_ok==1)
    Fractal
end
formation_sendto_gazebo = 1;
assignin('base', 'formation_sendto_gazebo', formation_sendto_gazebo);




calculate_forces_flag  = 1;
assignin('base', 'calculate_forces_flag', calculate_forces_flag);
end

