
formation_sari_x = evalin('base', 'formation_sari_x');
formation_sari_y = evalin('base', 'formation_sari_y');    

formation_kirmizi_x = evalin('base', 'formation_kirmizi_x');
formation_kirmizi_y = evalin('base', 'formation_kirmizi_y');    

formation_yesil_x = evalin('base', 'formation_yesil_x');
formation_yesil_y = evalin('base', 'formation_yesil_y');    

formation_mavi_x = evalin('base', 'formation_mavi_x');
formation_mavi_y = evalin('base', 'formation_mavi_y');    

formation_pembe_x = evalin('base', 'formation_pembe_x');
formation_pembe_y = evalin('base', 'formation_pembe_y');    


formation_x = evalin('base', 'formation_x');
formation_y = evalin('base', 'formation_y');   

formation_sari_x_edit    = formation_sari_x    * 1.5 - 0.75;
formation_sari_y_edit    = formation_sari_y    * 1.5 - 0.75;
formation_kirmizi_x_edit = formation_kirmizi_x * 1.5 - 0.75;
formation_kirmizi_y_edit = formation_kirmizi_y * 1.5 - 0.75;
formation_yesil_x_edit   = formation_yesil_x   * 1.5 - 0.75;
formation_yesil_y_edit   = formation_yesil_y   * 1.5 - 0.75;
formation_mavi_x_edit    = formation_mavi_x    * 1.5 - 0.75;
formation_mavi_y_edit    = formation_mavi_y    * 1.5 - 0.75;
formation_pembe_x_edit   = formation_pembe_x   * 1.5 - 0.75;
formation_pembe_y_edit   = formation_pembe_y   * 1.5 - 0.75;
figure
plot(formation_sari_x_edit, formation_sari_y_edit)
hold on
plot(formation_kirmizi_x_edit, formation_kirmizi_y_edit)
plot(formation_yesil_x_edit, formation_yesil_y_edit)
plot(formation_mavi_x_edit, formation_mavi_y_edit)
plot(formation_pembe_x_edit, formation_pembe_y_edit)

agents_radius = [1.6 2.4 2 2 1.6];
    conversion_index = 10.641; % [matlab] / [cm]
    agents_radius_matlab = conversion_index .* agents_radius;
    agents_zone_matlab = pi .* (agents_radius_matlab.^2);
    X_real = [formation_sari_x(end) formation_kirmizi_x(end) formation_yesil_x(end) formation_mavi_x(end) formation_pembe_x(end)];
    Y_real = [formation_sari_y(end) formation_kirmizi_y(end) formation_yesil_y(end) formation_mavi_y(end) formation_pembe_y(end)];
    myColors = zeros(5, 3); % List of rgb colors for every data point.
    myColors(1,:) = [1 0.9 0];
    myColors(2,:) = [1 0 0];
    myColors(3,:) = [0 1 0];
    myColors(4,:) = [0 0 1];
    myColors(5,:) = [1 0.5 0.5];
    l = scatter(X_real.*1.5-0.75, Y_real.*1.5-0.75, agents_zone_matlab,myColors, 'filled');
axis([-0.75,0.75,-0.75,0.75])
    grid on
    plot(formation_x.*1.5-0.75, formation_y.*1.5-0.75, 'ok')
    