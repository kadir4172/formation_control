function [ crossing ] = check_intersection( x1, y1 , x2 ,y2 , x3, y3, x4 ,y4)

     V1 = [(x2 - x1) (y2 - y1) 0];
     V2 = [(x3 - x1) (y3 - y1) 0];
     V3 = [(x4 - x1) (y4 - y1) 0];

     product_vect_1 = cross(V2,V1);
     product_vect_2 = cross(V3,V1);
     
     if((product_vect_1(3) * product_vect_2(3)) >= 0)
         crossing = 0;
     else
         V1 = [(x3 - x4) (y3 - y4) 0];
         V2 = [(x1 - x4) (y1 - y4) 0];
         V3 = [(x2 - x4) (y2 - y4) 0];
         product_vect_1 = cross(V2,V1);
         product_vect_2 = cross(V3,V1);
         if((product_vect_1(3) * product_vect_2(3)) >= 0)
             crossing = 0;
         else
             crossing = 1;
     end

end

