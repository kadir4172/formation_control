%This test procedure works to simulate the generated total
%forces for a single agent(only for attractive and repulsive)
%user can input the position of the agent by clicking on the
%plot and user can input the velocity of that agent manually

  
  X  = evalin('base', 'X');
  Y  = evalin('base', 'Y');
  
xp = formation_x;
yp = formation_y;
plot(formation_x, formation_y);
hold on;

array_length = length(xp);
xp(array_length + 1) = xp(1);
yp(array_length + 1) = yp(1);

%manual hiz tanimlamalari
vel_x = 5;
vel_y = 3;
%manual hiz tanimlamalari

z = [xp' yp'];

kr = evalin('base', 'kr');
ka = evalin('base', 'ka');

shape_buffer = evalin('base', 'shape_buffer');

while(1)   %open this block to take mouse input to calculate
            %inside/outside
[x_dot,y_dot] = ginput(1) %get mouse click input
nokta = complex(x_dot,y_dot);

%inside outside test

    
    real_inside = 0;
    imag_inside= 0;
    dot_on_the_line = 0;
    for i = 1 : 1 : array_length
      z_i = complex(z(i+1,1),z(i+1,2));
      denum = nokta - z_i;
      if (norm(denum) < shape_buffer)
        dot_on_the_line = 1;
      break
      end
    
      delta_x = (z((i+1),1) - z(i,1));
      delta_y = (z((i+1),2) - z(i,2));
    
      f = 1 / denum;
      u = real(f);
      v = imag(f);
    
      real_part = u * delta_x - v * delta_y;
      imag_part = u * delta_y + v * delta_x;
    
      real_inside = real_inside + real_part;
      imag_inside = imag_inside + imag_part;
      
   
    end %i = 1 : 1 : array_length
   if(dot_on_the_line == 1)
   inside_outside = 2; %agent on the line
 elseif(imag_inside < -3)
   inside_outside = 1; %agent in the shape
 elseif(imag_inside > -1)
   inside_outside = 0; %agent out of shape
 else
   inside_outside = 0; %agent out of shape
 end
    
  %inside outside test

  
  %repulsion forces
   force_rep_x = 0;
          force_rep_y = 0;
          
      if(inside_outside ~= 0) %eger agent, shape disarisinda degilse hesaplansin
         
      for j = 1 : 1 : array_length
        distance_to_point = norm([(formation_x(j) - x_dot)  (formation_y(j) - y_dot)]);
        force_rep_x = force_rep_x + ((x_dot - formation_x(j)) / (distance_to_point)^3);
        force_rep_y = force_rep_y + ((y_dot - formation_y(j)) / (distance_to_point)^3);
      end
        force_rep_x = force_rep_x * kr;
        force_rep_y = force_rep_y * kr;
        
        F_rep = [force_rep_x force_rep_y];
        Vel   = [vel_x vel_y];
        
        u_frep = F_rep / (norm(F_rep));
        u_vel  = Vel   / norm(Vel);
        
        f = u_frep - u_vel;
        f = f .* norm(F_rep);
        
        force_rep_x = f(1);
        force_rep_y = f(2);
      end
    
  %repulsion forces
  
  %attractive forces
       force_att_x = 0;
       force_att_y = 0;
     if(inside_outside ~= 1) %eger agent shape icerisinde degilse hesaplansin

      for j = 1 : 1 : array_length
        force_att_x = force_att_x + (formation_x(j) - x_dot);
        force_att_y = force_att_y + (formation_y(j) - y_dot);
      end
        force_att_x = force_att_x * ka;
        force_att_y = force_att_y * ka;
        
        
     end
    
   %attractive forces
   
   total_force_x = (force_rep_x + force_att_x) / 100;
   total_force_y = (force_rep_y + force_att_y) / 100;
   
   plot([x_dot x_dot+total_force_x], [y_dot y_dot+total_force_y])
end