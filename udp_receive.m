n = evalin('base', 'n');
u = evalin('base', 'u');
dt = evalin('base', 'dt');
if dt == 0
    dt = 0.25;
end
Xdot_real  = evalin('base', 'Xdot_real');
Ydot_real  = evalin('base', 'Ydot_real');
X  = evalin('base', 'X');
Y  = evalin('base', 'Y');
feedback_matrix  = evalin('base', 'feedback_matrix');
PA_index = evalin('base','PA_index');
agent1_zone = 0.5;
agent2_zone = 0.3;
agent3_zone = 0.15;
fopen(u);
flushinput(u);
a = fscanf(u);
b = fscanf(u);
flushinput(u);
fclose(u);
a_space = isspace(a);
b_space = isspace(b);
counter = 0;
dump_buffer = [];
data_line = zeros(1,5);

wait_for_time = 0;
for i = 1 : 1 : length(a)
  if(a_space(i) == 0)
      dump_buffer = [dump_buffer a(i)];
  else
      if(~isempty(dump_buffer))
        if(wait_for_time == 1)
            time = str2double(dump_buffer);
            wait_for_time = 0;
        else
          if(~strcmp(dump_buffer,'Time:'))  
            counter = counter + 1;
            data_line(counter) = str2double(dump_buffer);  
          else
            wait_for_time = 1;  
          end
        end
        dump_buffer = [];
      if(counter == 7)
        feedback_matrix(data_line(6),:) = data_line;
        counter = 0;
      end
      end
  end
end


wait_for_time = 0;
for i = 1 : 1 : length(b)
  if(b_space(i) == 0)
      dump_buffer = [dump_buffer b(i)];
  else
      if(~isempty(dump_buffer))
        if(wait_for_time == 1)
            time = str2double(dump_buffer);
            wait_for_time = 0;
        else
          if(~strcmp(dump_buffer,'Time:'))  
            counter = counter + 1;
            data_line(counter) = str2double(dump_buffer);  
          else
            wait_for_time = 1;  
          end
        end
        dump_buffer = [];
      if(counter == 7)
        feedback_matrix(data_line(6),:) = data_line;
        counter = 0;
      end
      end
  end
end

feedback_matrix;
n_new = length(feedback_matrix);


X_real     = feedback_matrix(:,1);
Y_real     = feedback_matrix(:,2);
Xdot_real_old = [Xdot_real; zeros(n_new-n,1)];
Ydot_real_old = [Ydot_real; zeros(n_new-n,1)];
Xdot_real = feedback_matrix(:,4);
Ydot_real = feedback_matrix(:,5);
X_accel_meas = (Xdot_real - Xdot_real_old) / dt ;
Y_accel_meas = (Ydot_real - Ydot_real_old) / dt ;


%X_accelmeas_noisy(1,1,:) = rand(n,1) * 0.050 - 0.0250;
X_accelmeas_noisy = rand(n_new,1) * 0.050 - 0.0250;
%X_accelmeas_noisy(1,1,PA_index) = 0;              % PA larin ivmeleri gurultusuz olsun
X_accelmeas_noisy(PA_index) = 0;              % PA larin ivmeleri gurultusuz olsun
X_accelmeas_noisy = X_accelmeas_noisy + X_accel_meas;
%Y_accelmeas_noisy(1,1,:) = rand(n,1) * 0.050 - 0.0250;
Y_accelmeas_noisy = rand(n_new,1) * 0.050 - 0.0250;
%Y_accelmeas_noisy(1,1,PA_index) = 0;              % PA larin ivmeleri gurultusuz olsun
Y_accelmeas_noisy(PA_index) = 0;              % PA larin ivmeleri gurultusuz olsun
Y_accelmeas_noisy = Y_accelmeas_noisy + Y_accel_meas;
%X_accel_meas
%X_accelmeas_noisy;

dimension_array = mod(feedback_matrix(:,7),10); %10
agents_radius(find(dimension_array==1))  = 0.6;
agents_radius(find(dimension_array==2))  = 0.36;
agents_radius(find(dimension_array==3))  = 0.18;
agents_radius = agents_radius';


if(n_new ~= n)
  if(n~=5)
    P = evalin('base', 'P');
    agents_zone_matlab = evalin('base', 'agents_zone_matlab');
    agents_zone_matlab = [agents_zone_matlab; ones(n_new-n,1)];
    P = cat(3,P,zeros(2,2,(n_new-n)));
    assignin('base', 'P', P);
    X = X_real;
    Y = Y_real;
    assignin('base', 'X', X_real);
    assignin('base', 'Y', Y_real);
    assignin('base', 'Xdot', Xdot_real);
    assignin('base', 'Ydot', Ydot_real);
    %{
    k = evalin('base', 'k'); 
    close(ancestor(k, 'figure'));
    k = scatter(X_real, Y_real,agents_zone_matlab);
    set(k,'XDataSource','X');
    set(k,'YDataSource','Y');
    assignin('base', 'k', k);
    %}
  end
end
%X_accelmeas_noisy = ones(length(X_accelmeas_noisy),1) * 2;

assignin('base', 'n', n_new);
assignin('base', 'agents_radius', agents_radius);
assignin('base', 'X_real', X_real);
assignin('base', 'Y_real', Y_real);
assignin('base', 'Xdot_real', Xdot_real);
assignin('base', 'Ydot_real', Ydot_real);
assignin('base', 'Xdotdot_real', X_accel_meas);
assignin('base', 'Ydotdot_real', Y_accel_meas);
assignin('base', 'Xdotdot', X_accelmeas_noisy);
assignin('base', 'Ydotdot', Y_accelmeas_noisy);
assignin('base', 'feedback_matrix', feedback_matrix);
assignin('base', 'sim_time', time);