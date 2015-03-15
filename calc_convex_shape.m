function [conv_shape_x conv_shape_y] = calc_convex_shape(shape_x, shape_y)
[val,ind] = sort(shape_x);
list_x = val;
list_y = shape_y(ind);

n = length(list_x);

L_upper_ind = [1 2];
for i = 3 : 1 : n
  go_on_flag = 1;
  L_upper_ind = [L_upper_ind i];
  while (go_on_flag)
    go_on_flag = 0;
    if((length(L_upper_ind) > 2))
      check_turn_ind = L_upper_ind((end-2):end);
      
      point_1_x = list_x(check_turn_ind(1));
      point_1_y = list_y(check_turn_ind(1));
  
      point_2_x = list_x(check_turn_ind(2));
      point_2_y = list_y(check_turn_ind(2));
  
      point_3_x = list_x(check_turn_ind(3));
      point_3_y = list_y(check_turn_ind(3));
  
     V1 = [(point_2_x - point_1_x) (point_2_y - point_1_y) 0];
     V2 = [(point_3_x - point_1_x) (point_3_y - point_1_y) 0];

      product_vect = cross(V2,V1);
      if(product_vect(3)<=0)
        L_upper_ind = L_upper_ind(L_upper_ind ~= check_turn_ind(2));
        go_on_flag = 1;
      end
    end
  end
end

L_lower_ind = [n n-1];
for i = (n-2) : -1 : 1
  go_on_flag = 1;
  L_lower_ind = [L_lower_ind i];
  while (go_on_flag)
    go_on_flag = 0;
    if((length(L_lower_ind) > 2))
      check_turn_ind = L_lower_ind((end-2):end);
      
      point_1_x = list_x(check_turn_ind(1));
      point_1_y = list_y(check_turn_ind(1));
  
      point_2_x = list_x(check_turn_ind(2));
      point_2_y = list_y(check_turn_ind(2));
  
      point_3_x = list_x(check_turn_ind(3));
      point_3_y = list_y(check_turn_ind(3));
  
      V1 = [(point_2_x - point_1_x) (point_2_y - point_1_y) 0];
      V2 = [(point_3_x - point_1_x) (point_3_y - point_1_y) 0];
     
      product_vect = cross(V2,V1);
      if(product_vect(3)<=0)
        L_lower_ind = L_lower_ind(L_lower_ind ~= check_turn_ind(2));
        go_on_flag = 1;
      end
    end
  end
end


L_lower_ind = L_lower_ind(2:(end -1));
general_ind = [L_upper_ind L_lower_ind];
conv_shape_x = list_x(general_ind);
conv_shape_y = list_y(general_ind);
%{
figure
plot(list_x,list_y,'o')
figure
plot(list_x(L_upper_ind),list_y(L_upper_ind))
hold on
plot(list_x(L_lower_ind),list_y(L_lower_ind))
%}
%plot(conv_shape_x, conv_shape_y, 'o')
end % function
