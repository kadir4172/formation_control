n = evalin('base', 'n');
dt = 0.5;

Xold  = evalin('base', 'X_real');
Yold  = evalin('base', 'Y_real');
X_real  = evalin('base', 'X_real');
Y_real  = evalin('base', 'Y_real');
Xdot_real  = evalin('base', 'Xdot_real');
Ydot_real  = evalin('base', 'Ydot_real');

process_cam_data;

cam_data = evalin('base', 'cam_data')
if (length(cam_data == 20))
for i = 1 : 1 : n
    index = 4 * (i -1);

    X_real(i)  = (double(cam_data(index + 3)) - double(cam_data(index + 1))) / 2 + double(cam_data(index + 1));
    Y_real(i)  = (double(cam_data(index + 4)) - double(cam_data(index + 2))) / 2 + double(cam_data(index + 2));
    heading_robots(i) = atan2((double(cam_data(index + 4)) - double(cam_data(index + 2))), (double(cam_data(index + 3)) - double(cam_data(index + 1)))) * 180 /pi + 90;
    
    heading_robots(i) = mod(heading_robots(i) , 360);
    Xdot_real(i) = (X_real(i) - Xold(i)) / dt;
    Ydot_real(i) = (Y_real(i) - Yold(i)) / dt;
end

assignin('base', 'X_real', X_real);
assignin('base', 'Y_real', Y_real);
assignin('base', 'Xdot_real', Xdot_real);
assignin('base', 'Ydot_real', Ydot_real);
assignin('base', 'heading_robots', heading_robots);
end

