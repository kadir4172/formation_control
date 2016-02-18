close all

X_positions = evalin('base', 'X_positions');
Y_positions = evalin('base', 'Y_positions');
%formation_x = evalin('base', 'formation_x');
%formation_y = evalin('base', 'formation_y');
FORMATIONS = evalin('base', 'FORMATIONS');
%n = evalin('base', 'n');
%n = 50;

grid_map = [];
%set_obstacles
obstacle_1_x = [-7.4715   -8.1715   -8.8494   -9.2819   -9.9811  -10.6811  -11.3811  -12.0811  -12.7811  -13.3735  -13.9751 -14.5604  -15.1990  -15.8947  -16.4639  -16.8829  -17.3271  -17.7769  -18.0157  -18.2532  -18.4187  -18.4189 -18.4189  -18.5719  -18.6247  -18.6429  -18.6510  -18.6548  -18.6581  -18.3274  -17.9460  -17.5362  -16.9045 -16.2376  -15.5441  -14.8473  -14.1473  -13.4528  -12.8392  -12.3980  -11.8706  -11.5632  -11.3482  -10.8468 -10.1732   -9.4734   -8.7734   -8.1432   -7.5637   -6.9020   -6.3930   -5.8933   -5.8160   -5.7458   -5.7204 -5.8704   -6.0880   -6.2957   -6.5942   -6.9459   -7.2361];
obstacle_1_y = [21.1805   21.1805   21.0060   20.4556   20.4228   20.4208   20.4206   20.4206   20.4206   20.7935   21.1514 21.5354   21.8221   21.8995   21.4921   20.9313   20.3903   19.8540   19.1960   18.5375   17.8573   17.1573 16.4573   15.7743   15.0762   14.3765   13.6765   12.9765   12.2765   11.6596   11.0726   10.5052   10.2036 9.9908   10.0859   10.1528   10.1622   10.2493   10.5862   11.1297   11.5899   12.2188   12.8850   13.3735 13.5638   13.5820   13.5821   13.8868   14.2794   14.5078   14.9883   15.4786   16.1743   16.8708   17.5703 18.2541   18.9194   19.5879   20.2210   20.8262   21.0218];

obstacle_2_x = [-7.6744   -8.3682   -9.0682   -9.7631  -10.4580  -11.1491  -11.7503  -12.3659  -12.9861  -13.6229  -14.2393 -14.8844  -15.5499  -16.1189  -16.5655  -16.9716  -17.4687  -18.0432  -18.6146  -19.2134  -19.7666  -20.3246 -20.5720  -20.8858  -21.3131  -21.7111  -22.0572  -22.3543  -22.5838  -22.6842  -22.9710  -23.0083  -22.9501 -22.8009  -22.6365  -22.2819  -21.9908  -21.8019  -21.5191  -21.3040  -21.1072  -20.8612  -20.7057  -20.0807 -19.3807  -18.7107  -18.0264  -17.3266  -16.6266  -15.9327  -15.2327  -14.5327  -13.8383  -13.1471  -12.4500 -11.7502  -11.0502  -10.4597   -9.9593   -9.6491   -9.3272   -8.9615   -8.9178   -8.9495   -8.9772   -8.9635 -8.9502   -8.9151   -8.8176   -8.6858   -8.5119   -8.3078   -7.9221   -7.3975   -6.9029   -6.3049   -5.7063 -5.0940   -4.5308   -4.1714   -3.8565   -3.7806   -3.7303   -3.7242   -3.7746   -3.7983   -4.2411   -4.4166 -4.8597   -5.3849   -5.9687   -6.5585   -7.1546   -7.4704];
obstacle_2_y = [-9.3960   -9.3025   -9.3021   -9.3861   -9.4703   -9.5817   -9.9403  -10.2735  -10.5980  -10.8887  -11.2204 -11.4921  -11.7094  -12.1171  -12.6561  -13.2262  -13.7191  -14.1190  -14.5234  -14.8859  -15.3148  -15.7375 -16.3923  -17.0180  -17.5725  -18.1483  -18.7568  -19.3906  -20.0519  -20.7447  -21.3832  -22.0822  -22.7798 -23.4637  -24.1441  -24.7477  -25.3843  -26.0583  -26.6986  -27.3648  -28.0365  -28.6919  -29.3744  -29.6897  -29.6913  -29.8941  -30.0414  -30.0599  -30.0641  -30.1556  -30.1593  -30.1608  -30.0722  -29.9613  -29.8976 -29.8844  -29.8807  -29.5047  -29.0152  -28.3877  -27.7661  -27.1692  -26.4706  -25.7713  -25.0719  -24.3720  -23.6721  -22.9730  -22.2798  -21.5924  -20.9143  -20.2447  -19.6605  -19.1971  -18.7017  -18.3379  -17.9750 -17.6359  -17.2202  -16.6194  -15.9943  -15.2984  -14.6003  -13.9003  -13.2021  -12.5025  -11.9604  -11.2828 -10.7408  -10.2781   -9.8918   -9.5147   -9.1478   -9.2986];

obstacle_3_x = [ 17.9464   17.5578   16.9958   16.4135   15.8200   15.2249   14.7038   14.2122   13.7100   13.2263   12.7612 12.3679   12.0039   11.6458   11.2998   10.9676   10.6893   10.5621   10.4355   10.3217   10.2394   10.1468 10.0140    9.9078    9.8146    9.6719    9.6297    9.6181    9.6464    9.7006    9.8171    9.9357   10.0567 10.1855   10.3069   10.3136   10.2679   10.2260   10.4763   10.8512   11.2520   11.8411   12.4381   13.0351 13.6331   14.2316   14.8301   15.4296   16.0292   16.6289   17.2287   17.8286   18.4285   19.0270   19.6261 20.2196   20.8176   21.4159   21.9875   22.5261   22.9224   23.2936   23.5909   23.9156   24.2401   24.5250 24.8248   25.1466   25.4783   25.8209   26.1624   26.4890   26.7833   27.0597   27.3153   27.3928   27.3377 27.2352   27.0357   26.7534   26.4522   26.1280   25.6495   25.1717   24.6845   24.2118   23.7303   23.2698 22.8079   22.4468   22.1268   21.8645   21.4704   21.0550   20.5136   19.9136   19.3137   18.7502   18.3896 18.1902   17.9908];
obstacle_3_y = [ 10.9244   11.3815   11.5915   11.4470   11.3586   11.2824   10.9850   10.6409   10.3126    9.9577    9.5785 9.1254    8.6485    8.1671    7.6769    7.1773    6.6457    6.0593    5.4728    4.8837    4.2894    3.6966 3.1115    2.5209    1.9282    1.3455    0.7470    0.1471   -0.4523   -1.0498   -1.6384   -2.2266   -2.8142 -3.4002   -3.9878   -4.5878   -5.1860   -5.7846   -6.3299   -6.7984   -7.2449   -7.3587   -7.4187   -7.4779 -7.5269   -7.5703   -7.6118   -7.6364   -7.6600   -7.6774   -7.6922   -7.7061   -7.7134   -7.6703   -7.6386 -7.5505   -7.5017   -7.4565   -7.2739   -7.0095   -6.5590   -6.0876   -5.5664   -5.0620   -4.5572   -4.0292 -3.5095   -3.0031   -2.5031   -2.0105   -1.5172   -1.0139   -0.4910    0.0415    0.5844    1.1793    1.7768 2.3680    2.9338    3.4633    3.9822    4.4871    4.8491    5.2119    5.5621    5.9317    6.2897    6.6743 7.0572    7.5365    8.0440    8.5836    9.0360    9.4689    9.7276    9.7343    9.7405    9.9467   10.4263 10.6504   10.8745];


obstacle_gain = 1.1;


obstacle_1_x = obstacle_1_x * obstacle_gain;
obstacle_1_y = obstacle_1_y * obstacle_gain;

obstacle_2_x = obstacle_2_x * obstacle_gain;
obstacle_2_y = obstacle_2_y * obstacle_gain;

obstacle_3_x = obstacle_3_x * obstacle_gain;
obstacle_3_y = obstacle_3_y * obstacle_gain;

obstacle_number = 3;

sample_to_plot = 700;

%cmap = hsv(n);  %# Creates a 50-by-3 set of colors from the HSV colormap
figure

% for i = 1 : 1 : n
%     plot(X_positions(:,i) , Y_positions(:,i),'Color',cmap(i,:));  
%     hold on    
% end

formation_x = FORMATIONS(sample_to_plot).formation_x;
formation_y = FORMATIONS(sample_to_plot).formation_y;
f = figure(1)
plot(obstacle_1_x, obstacle_1_y, 'g','LineWidth',2);
hold on
plot(obstacle_2_x, obstacle_2_y, 'g','LineWidth',2);
plot(obstacle_3_x, obstacle_3_y, 'g','LineWidth',2);
plot(formation_x , formation_y , 'r','LineWidth',2);
axis([-35,35,-35,35])
grid on
xlabel('X coordinates[m]')
ylabel('Y coordinates[m]')
title(['Formation Shape and Agents'' Positions at Time:', num2str(sample_to_plot/5)])
clear formation_x
clear formation_y
load formation1
hold on
plot(obstacle_1_x, obstacle_1_y, 'g');
plot(obstacle_2_x, obstacle_2_y, 'g');
plot(obstacle_3_x, obstacle_3_y, 'g');
%plot(X_positions(i,:) , Y_positions(i,:), 'o'); 
% for i = 1 : 1 : length(formation_start_x)
%   text(formation_start_x(i),formation_start_y(i),num2str(i))
%   genio(i).h = impoint(gca,formation_start_x(i),formation_start_y(i)); 
% end
ax = gca;
for j = 1 : 1 : length(X_positions(sample_to_plot,:))
    
   k = scatter(X_positions(sample_to_plot,j), Y_positions(sample_to_plot,j), agents_zone_matlab(j),'r');
   text(X_positions(sample_to_plot,j),Y_positions(sample_to_plot,j),num2str(j))
   %h(i).handle = impoint(gca, X_positions(i,j), Y_positions(i,j));
   genio(j).h = impoint(gca,X_positions(sample_to_plot,j),Y_positions(sample_to_plot,j)); 
end
prompt = 'Ready for plot(Y/N)? ';
str = input(prompt,'s')



formation_x = FORMATIONS(sample_to_plot).formation_x;
formation_y = FORMATIONS(sample_to_plot).formation_y;

f = figure(2)
plot(obstacle_1_x, obstacle_1_y, 'g','LineWidth',2);
hold on
plot(obstacle_2_x, obstacle_2_y, 'g','LineWidth',2);
plot(obstacle_3_x, obstacle_3_y, 'g','LineWidth',2);
plot(formation_x , formation_y , 'r','LineWidth',2);
axis([-35,35,-35,35])
grid on
xlabel('X coordinates[m]')
ylabel('Y coordinates[m]')
title(['Formation Shape and Agents'' Positions at Time:', num2str(sample_to_plot/5), ' seconds'])
clear formation_x
clear formation_y
load formation1
hold on
plot(obstacle_1_x, obstacle_1_y, 'g');
plot(obstacle_2_x, obstacle_2_y, 'g');
plot(obstacle_3_x, obstacle_3_y, 'g');
for j = 1 : 1 : length(X_positions(sample_to_plot,:))
   pos = genio(j).h.getPosition();
   k = scatter(pos(1), pos(2), agents_zone_matlab(j),'r');
end
% 
% clear formation_x
% clear formation_y
% load formation4
% hold on
% plot(formation_x , formation_y , 'm','LineWidth',2);
% 
% clear formation_x
% clear formation_y
% load formation3
% hold on
% plot(formation_x , formation_y , 'k','LineWidth',2);
% 
% clear formation_x
% clear formation_y
% load formation5
% hold on
% plot(formation_x , formation_y , 'r','LineWidth',2);
% calculate_energy_time_consumption