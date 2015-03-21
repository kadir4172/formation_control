function [visual_array] = visible_vertices(p,line_segment, vertice_matrix)
 dummy = size(line_segment);
 number_of_lines = dummy(1);
 
 dummy = size(vertice_matrix);
 number_of_vertices = dummy(1);
 
 visual_array = [];
 for i = 1 : 1 : number_of_vertices
   line_of_sight = 0;
   if(vertice_matrix(p,4) ~= vertice_matrix(i,4))   % secilen nokta ile test edilen nokta ayni obstacle uzerinde degilse
     line_of_sight = 1;
     for j = 1 : 1 : number_of_lines
       line_start_x = vertice_matrix(line_segment(j,2),2);
       line_start_y = vertice_matrix(line_segment(j,2),3);
       line_end_x   = vertice_matrix(line_segment(j,3),2);
       line_end_y   = vertice_matrix(line_segment(j,3),3);
       crossing = check_intersection(line_start_x, line_start_y, line_end_x, line_end_y, vertice_matrix(p,2), vertice_matrix(p,3), vertice_matrix(i,2), vertice_matrix(i,3));
       if(crossing == 1)
         line_of_sight = 0;
         break;
       end
     end
   end
   if(line_of_sight == 1)
       visual_array = [visual_array i];
   end
  end
end