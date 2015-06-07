function  grid_map  = test_inside_outside( formation_x, formation_y, grid_map_in, x_max, y_max)
  %free map bolgesinde ise yani verilen seklin icersinde degilse 1 icindeyse 0 dondururu grid_map matrisinde  
    search_step = evalin('base', 'search_step');
    if(length(grid_map_in) == 0)
        grid_map_in = ones(length(-1*x_max:search_step:x_max), length(-1*y_max:search_step:y_max));
    end
    
    %grid_map = ones(length(-35:search_step:35), length(-35:search_step:35));
    offline_shape_buffer = evalin('base', 'offline_shape_buffer');
    
    xp = formation_x;
    yp = formation_y;

    array_length = length(xp);
    xp(array_length + 1) = xp(1);
    yp(array_length + 1) = yp(1);

    z = [xp' yp'];
    
 k_counter = 1;
 for k = -1*x_max:search_step:x_max
     j_counter = 1;
     for j = -1*y_max:search_step:y_max
        nokta = complex(k,j);
        real_inside = 0;
        imag_inside= 0;
        dot_on_the_line = 0;
       for i = 1 : 1 : array_length
          z_i = complex(z(i+1,1),z(i+1,2));
          denum = nokta - z_i;
          if (norm(denum) < offline_shape_buffer)
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
        grid_map(k_counter,j_counter) = 0 ; %agent on the line
      elseif(imag_inside < -0.5)
        grid_map(k_counter,j_counter) = 0; %agent in the shape
      elseif(imag_inside > -0.5)
        grid_map(k_counter,j_counter) = 1 * grid_map_in(k_counter,j_counter); %agent out of shape
      else 
        grid_map(k_counter,j_counter) = 1 * grid_map_in(k_counter,j_counter); %agent out of shape
      end
     j_counter = j_counter + 1;
    end
   k_counter = k_counter + 1;
end %for k = 1 : 1 : n

end

