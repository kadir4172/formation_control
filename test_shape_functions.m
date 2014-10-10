%This test procedure works with data from
%base workspace (formation_x/y) draws them
%calculates the length of the shape, center
%of the shape and plots dots inside/outside of the
%shape with different colors
xp = formation_x;
yp = formation_y;

array_length = length(xp);
xp(array_length + 1) = xp(1);
yp(array_length + 1) = yp(1);

z = [xp' yp'];

shape_buffer = evalin('base', 'shape_buffer');
plot(formation_x, formation_y)
hold on

%Uzunluk Bulma
length_shape = 0;
for i = 1 : 1 : array_length
    delta_x = (z((i+1),1) - z(i,1));
    delta_y = (z((i+1),2) - z(i,2));
  length_shape = length_shape + norm([delta_x delta_y]);
end
length_shape

%Merkez Bulma
shape_center_real = 0;
shape_center_imag = 0;
for i = 1 : 1 : array_length
   shape_center_real = shape_center_real + z(i,1);
   shape_center_imag = shape_center_imag + z(i,2);
end
shape_center_real = shape_center_real / array_length
shape_center_imag = shape_center_imag / array_length


%Iceride / Disarida

%while(1)   %open this block to take mouse input to calculate
            %inside/outside
%[x_dot,y_dot] = ginput(1) %get mouse click input
%nokta = complex(x_dot,y_dot);

shape_buffer = 1.5;  %buffer zone for shape boundary

for k = linspace(-100,100,200)
  for l = linspace(-100,100,200)
    nokta = complex(k,l);
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
          plot(k,l,'k*');
          %dot_on_the_line = 0;
      elseif(imag_inside < -0.5)
          plot(k,l,'go');
      elseif(imag_inside > -0.5)
          plot(k,l,'rx');
      end
      hold on
%real_inside
%imag_inside
  end %l = linspace(-50,50,200)
end%k = linspace(-50,50.200)




%end %while(1)

