    n  = evalin('base', 'n');
    X  = evalin('base', 'X_offline');
    Y  = evalin('base', 'Y_offline');
    offline_inside_outside_array  = evalin('base', 'offline_inside_outside_array');
  
    formation_x = evalin('base', 'formation_x');
    formation_y = evalin('base', 'formation_y');
    
    shape_buffer = evalin('base', 'shape_buffer');
    
    xp = formation_x;
    yp = formation_y;

    array_length = length(xp);
    xp(array_length + 1) = xp(1);
    yp(array_length + 1) = yp(1);

    z = [xp' yp'];
    
   
for k = 1 : 1 : n
  nokta = complex(X(k),Y(k));
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
   offline_inside_outside_array(k) = 2; %agent on the line
 elseif(imag_inside < -0.5)
   offline_inside_outside_array(k) = 1; %agent in the shape
 elseif(imag_inside > -0.5)
   offline_inside_outside_array(k) = 0; %agent out of shape
 else
   offline_inside_outside_array(k) = 0; %agent out of shape
 end
 
%real_inside
%imag_inside
end %for k = 1 : 1 : n

assignin('base', 'offline_inside_outside_array', offline_inside_outside_array);
deneme = 14