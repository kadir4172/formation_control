close all
cmap = hsv(10);  %# Creates a 10-by-3 set of colors from the HSV colormap

plot(Error_State(4,:) ,'Color',cmap(1,:));  
hold on                                             
plot(Error_State(8,:) ,'Color',cmap(2,:));  
plot(Error_State(21,:) ,'Color',cmap(3,:));  
plot(Error_State(10,:),'Color',cmap(4,:));  
plot(Error_State(24,:),'Color',cmap(5,:));  
plot(Error_State(14,:),'Color',cmap(6,:));  
plot(Error_State(15,:),'Color',cmap(7,:));  
plot(Error_State(16,:),'Color',cmap(8,:));  
plot(Error_State(25,:),'Color',cmap(9,:));  
plot(Error_State(20,:),'Color',cmap(10,:));  

xlabel('Position Propogation Iterations')
ylabel('Error Norm on Position Data[m]')
title('Effect of the Position Corrections')
                                               
