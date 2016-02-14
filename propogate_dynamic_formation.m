dynamic_formation_counter = evalin('base','dynamic_formation_counter');
formation_animation = evalin('base','formation_animation');
formation_x = evalin('base','formation_x');
formation_y = evalin('base','formation_y');

dynamic_formation_counter = dynamic_formation_counter + 1;
offset_counter = dynamic_formation_counter - 35;
max_counter = size(formation_animation,2);
if(offset_counter <= 0)
    formation_x = formation_animation{1}.formation_x;
    formation_y = formation_animation{1}.formation_y;
elseif(offset_counter <= max_counter)
    formation_x = formation_animation{offset_counter}.formation_x;
    formation_y = formation_animation{offset_counter}.formation_y;
else
    formation_x = formation_animation{max_counter}.formation_x;
    formation_y = formation_animation{max_counter}.formation_y;
end

    
assignin('base','dynamic_formation_counter',dynamic_formation_counter)
assignin('base', 'formation_x', formation_x);
assignin('base', 'formation_y', formation_y);    

get_formation_data
frame_for_rest = max_counter - offset_counter