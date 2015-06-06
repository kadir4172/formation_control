  GoalStatePos1  = evalin('base', 'GoalStatePos1');
  GoalStatePos2  = evalin('base', 'GoalStatePos2');
  GoalStatePos3  = evalin('base', 'GoalStatePos3');
  
  kgoal1  = evalin('base', 'kgoal1');
  kgoal2  = evalin('base', 'kgoal2');
  max_goal_state_force = evalin('base', ' max_goal_state_force');
  max_force = evalin('base', ' max_force');
    
  n = evalin('base', 'n');
  
  radius1 = evalin('base', 'radius1');
  radius2 = evalin('base', 'radius2');
  radius3 = evalin('base', 'radius3');
  
  
  X  = evalin('base', 'X');
  Y  = evalin('base', 'Y');
  agents_radius = evalin('base','agents_radius');
  
  force_matrix = evalin('base', 'force_matrix');
  inside_outside_array  = evalin('base', 'inside_outside_array');
  
  GoalStateCost1 = [];
  GoalStateCost2 = [];
  GoalStateCost3 = [];
  
  GoalStateAgentId1 = [];
  GoalStateAgentId2 = [];
  GoalStateAgentId3 = [];
  
  
    for i = 1 : 1 : n
    if(agents_radius(i) == radius1)
        cost_vector = (X(i)-GoalStatePos1(:,1)).^2 + (Y(i) - GoalStatePos1(:,2)).^2;
        cost_vector = cost_vector .^ 0.5;
        GoalStateCost1 = [GoalStateCost1; cost_vector'];
        GoalStateAgentId1 = [GoalStateAgentId1 i];
    elseif(agents_radius(i) == radius2)
        cost_vector = (X(i)-GoalStatePos2(:,1)).^2 + (Y(i) - GoalStatePos2(:,2)).^2;
        cost_vector = cost_vector .^ 0.5;
        GoalStateCost2 = [GoalStateCost2; cost_vector'];
        GoalStateAgentId2 = [GoalStateAgentId2 i];
    else
        cost_vector = (X(i)-GoalStatePos3(:,1)).^2 + (Y(i) - GoalStatePos3(:,2)).^2;
        cost_vector = cost_vector .^ 0.5;
        GoalStateCost3 = [GoalStateCost3; cost_vector'];
        GoalStateAgentId3 = [GoalStateAgentId3 i];
    end
    end
   
    [assignment1,cost] = Hungarian(GoalStateCost1);
    [assignment2,cost] = Hungarian(GoalStateCost2);
    [assignment3,cost] = Hungarian(GoalStateCost3);
    
    GoalStatesForces = [];
    
    for (m = 1 : 1 : length(assignment1))
        GoalStatesForces(GoalStateAgentId1(m),1) = X(GoalStateAgentId1(m)) - GoalStatePos1(m,1);
        GoalStatesForces(GoalStateAgentId1(m),2) = Y(GoalStateAgentId1(m)) - GoalStatePos1(m,2);
    end
    
    for (m = 1 : 1 : length(assignment2))
        GoalStatesForces(GoalStateAgentId2(m),1) = X(GoalStateAgentId2(m)) - GoalStatePos2(m,1);
        GoalStatesForces(GoalStateAgentId2(m),2) = Y(GoalStateAgentId2(m)) - GoalStatePos2(m,2);
    end
    
    for (m = 1 : 1 : length(assignment3))
        GoalStatesForces(GoalStateAgentId3(m),1) = X(GoalStateAgentId3(m)) - GoalStatePos3(m,1);
        GoalStatesForces(GoalStateAgentId3(m),2) = Y(GoalStateAgentId3(m)) - GoalStatePos3(m,2);
    end
      
    %GoalStatesForces
    
    

    for i = 1 : 1 : n
        amplitude = GoalStatesForces(i,1)^2 + GoalStatesForces(i,2)^2 ;
        amplitude = amplitude^0.5;
        gain = 1;
        if(amplitude > max_goal_state_force)
            gain = max_goal_state_force / amplitude;
        end
    if(inside_outside_array(i) ~= 1) %eger agent shape icerisinde degilse hesaplansin
       
        force_matrix(1,7,i) = force_matrix(1,7,i) - kgoal1 * GoalStatesForces(i,1) * gain ;
        force_matrix(2,7,i) = force_matrix(2,7,i) - kgoal1 * GoalStatesForces(i,2) * gain ;        
    else
        force_matrix(1,7,i) = force_matrix(1,7,i) - kgoal2 * GoalStatesForces(i,1) * gain ;
        force_matrix(2,7,i) = force_matrix(2,7,i) - kgoal2 * GoalStatesForces(i,2) * gain ;      
    end
    end
  

     if (abs(force_matrix(1,7,i)) > max_force)
      force_matrix(1,7,i) = max_force * (force_matrix(1,7,i)/abs(force_matrix(1,7,i)));
    end
    
    if (abs(force_matrix(2,7,i)) > max_force)
      force_matrix(2,7,i) = max_force * (force_matrix(2,7,i)/abs(force_matrix(2,7,i)));
    end
  
 assignin('base', 'force_matrix', force_matrix);
    
    
    