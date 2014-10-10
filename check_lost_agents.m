lost_agent_matrix = evalin('base','lost_agent_matrix');
%g = evalin('base', 'g');

for i  = 1 : 1 : n
 if (neighbor_matrix(i,4))
     text = 'Lost Agent';
     lost_agent_matrix(i,1) = lost_agent_matrix(i,1) + 1;
     if (lost_agent_matrix(i,1) > 3)
         lost_agent_matrix(i,2) = 1;
         text = 'Eve Don!';
     end
 %    set(g(i),'String',text);
 else
     lost_agent_matrix(i,:) = [0 0];
  %   set(g(i),'String',int2str(i));
 end
end
assignin('base','lost_agent_matrix',lost_agent_matrix);