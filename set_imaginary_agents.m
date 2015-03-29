formation_center = evalin('base', 'formation_center');
n = evalin('base', 'n');

for i = 1 : 1 : round(n/2)
 X_offline(i) = real(formation_center) + i*0.01;
 Y_offline(i) = imag(formation_center) ;
 Xdot_offline(i) = 0;
 Ydot_offline(i) = 0;
end

for i = (round(n/2)+1) : 1 : n
 X_offline(i) = real(formation_center) - (i - round(n/2))*0.01 + 0.01*round(n/2);
 Y_offline(i) = imag(formation_center) + 0.1;
 Xdot_offline(i) = 0;
 Ydot_offline(i) = 0;
end

 assignin('base', 'X_offline', X_offline);
 assignin('base', 'Y_offline', Y_offline);
 assignin('base', 'Xdot_offline', Xdot_offline);
 assignin('base', 'Ydot_offline', Ydot_offline);
 
 deneme = 12