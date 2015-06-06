clc

n = evalin('base', 'n');
agents_radius = evalin('base','agents_radius');
offline_check_density;
set_imaginary_agents; % offline_check_density ile sira degistirirsen formation_ok yi dogru handle et
formation_ok = evalin('base', 'formation_ok');
formation_ok

 update_states_timer = evalin('base', 'update_states_timer');
  pos_loop = evalin('base', 'pos_loop');
  stop(update_states_timer);
  stop(pos_loop);
  
   for i = 1 : 1 : n
    force_matrix(1,7,i) = 0;
    force_matrix(2,7,i) = 0;
  end
  
assignin('base', 'force_matrix', force_matrix);  % gercek dunyadaki hiz referanslarini sifirlayalim
%udp_send
  
if(formation_ok)
  
  formation_x  = evalin('base', 'formation_x');
  formation_y  = evalin('base', 'formation_y');
  %agents_zone_matlab = evalin('base','agents_zone_matlab');
 
%offline simulation isleri



%{
figure
o = scatter(X_offline, Y_offline, agents_zone_matlab);
set(o,'XDataSource','X_offline');
set(o,'YDataSource','Y_offline');
p = plot(formation_x, formation_y);
set(p,'XDataSource','formation_x');
set(p,'YDataSource','formation_y');
%axis([-35,35,-35,35])
%}

  for i = 1 : 1 : 50
   t = cputime;
   offline_set_inside_outside;
   offline_set_intermember_forces;
   offline_set_attraction_forces;
   offline_set_attraction2_forces;
   offline_set_repulsion_forces;
   offline_set_obstacle_forces;
   offline_set_total_force;
   offline_dt = (cputime - t) * 10;
   assignin('base', 'offline_dt', offline_dt);
   run_offline_dynamics;
  end
   offline_set_inside_outside; % son gelinen halde icerde disarda olanlara bakalim
   offline_inside_outside_array = evalin('base', 'offline_inside_outside_array');
   X_offline  = evalin('base', 'X_offline');
   Y_offline  = evalin('base', 'Y_offline');
   for i = 1 : 1 : n
       if(offline_inside_outside_array(i) == 0)  %% offline sim sonucunda seklin icine sokulamadiysa en yakin sinira koyalim
         distance = [];
         for k = 1 : 1 : length(formation_x)
             mesafe = sqrt ((X_offline(i) - formation_x(k))^2  + (Y_offline(i) - formation_y(k))^2);
             distance = [distance mesafe];
         end
         [val,ind] = min(distance);
         %i
         %formation_x
         %formation_y
         X_offline(i) = formation_x(ind);  % sinirin uzerine koyalim
         Y_offline(i) = formation_y(ind);        
       end
   end
   assignin('base', 'X_offline', X_offline);
   assignin('base', 'Y_offline', Y_offline);
   
   GoalStatePos1 = [];
   GoalStatePos2 = [];
   GoalStatePos3 = [];
   for i = 1 : 1 : n
    if(agents_radius(i) == 0.18)
        GoalStatePos1 = [GoalStatePos1;[X_offline(i) Y_offline(i)]];
    elseif(agents_radius(i) == 0.36)
        GoalStatePos2 = [GoalStatePos2;[X_offline(i) Y_offline(i)]];
    else
        GoalStatePos3 = [GoalStatePos3;[X_offline(i) Y_offline(i)]];
    end
   end
  assignin('base', 'GoalStatePos1', GoalStatePos1);
  assignin('base', 'GoalStatePos2', GoalStatePos2);
  assignin('base', 'GoalStatePos3', GoalStatePos3);
   
  start(update_states_timer);
  start(pos_loop);
end
%offline simulation isleri

