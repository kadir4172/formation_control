  force_matrix = evalin('base', 'force_matrix');
  update_states_timer = evalin('base', 'update_states_timer');
  pos_loop = evalin('base', 'pos_loop');
  n = evalin('base', 'n');
  
  for i = 1 : 1 : n
    force_matrix(1,7,i) = 0;
    force_matrix(2,7,i) = 0;
  end
  
assignin('base', 'force_matrix', force_matrix);
udp_send

stop(update_states_timer);
stop(pos_loop);

formation_center = evalin('base', 'formation_center');
formation_area   = evalin('base', 'formation_area')  ;

set_imaginary_agents;


