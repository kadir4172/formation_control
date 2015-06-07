n = evalin('base', 'n');
stop(update_states_timer);
stop(pos_loop);
%fclose(y);
%fclose(u);
  for i = 1 : 1 : n
    force_matrix(1,7,i) = 0;
    force_matrix(2,7,i) = 0;
  end
  
assignin('base', 'force_matrix', force_matrix);  % gercek dunyadaki hiz referanslarini sifirlayalim
uart_send

fclose(s);
close all;
clear all;
%clc;