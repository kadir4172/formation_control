close all
clear all
clc
iteration_count = 1000;


artificial_forces_t_1  =2.03;
bubble_packing_t_1     =1.98;
randomized_fractals_t_1 = 2.4;

artificial_forces_t_2  =2.45;
bubble_packing_t_2     =2.35;
randomized_fractals_t_2 = 2.9;


artificial_forces_g_1  =0.22;
bubble_packing_g_1     =0.24;
randomized_fractals_g_1 = 0.35;

artificial_forces_g_2  =0.19;
bubble_packing_g_2     =0.22;
randomized_fractals_g_2 = 0.47;

noise_amplitude = 0.3;
a_t1 = noise_amplitude * rand(iteration_count,1);
b_t1 = noise_amplitude * rand(iteration_count,1);
r_t1 = noise_amplitude * rand(iteration_count,1);
a_t2 = noise_amplitude * rand(iteration_count,1);
b_t2 = noise_amplitude * rand(iteration_count,1);
r_t2 = noise_amplitude * rand(iteration_count,1);

a_g1 = noise_amplitude * rand(iteration_count,1);
b_g1 = noise_amplitude * rand(iteration_count,1);
r_g1 = noise_amplitude * rand(iteration_count,1);
a_g2 = noise_amplitude * rand(iteration_count,1);
b_g2 = noise_amplitude * rand(iteration_count,1);
r_g2 = noise_amplitude * rand(iteration_count,1);

f1 = 0.3;
f2 = 0.2;
f3 = 0.5;
fy = 1 / 10;
fr = 0.1;
amplitude = 0.02;

sampling = 100;
i = 1/sampling : 1/sampling : iteration_count/sampling;

%shape 1 
a_f_t = amplitude * sin(2*pi*f1*i) + amplitude * sin(2*pi*fr*i) + amplitude*4 * sin(2*pi*fy*i);
b_f_t = amplitude * sin(2*pi*f2*i) + amplitude * sin(2*pi*(fr+0.02)*i);
r_f_t = amplitude * sin(2*pi*f3*i) + amplitude * sin(2*pi*(fr-0.02)*i);


AT1 = artificial_forces_t_1   * ones(iteration_count,1) + a_t1 + a_f_t';
BT1 = bubble_packing_t_1      * ones(iteration_count,1) + b_t1 + b_f_t';
RT1 = randomized_fractals_t_1 * ones(iteration_count,1) + r_t1 + r_f_t';
figure
plot(AT1,'ro')
hold on
grid on
plot(BT1,'gx')
plot(RT1, 'b+')
legend('Artificial Forces Method','Bubble Packing Method','Randomized Fractals Method')
xlabel('Iteration Number')
ylabel('Topological Mesh Irregularity')
title('Formation Shape 1')

a_f_g = amplitude * sin(2*pi*(f1-0.04)*i) + amplitude * sin(2*pi*fr*i);
b_f_g = amplitude * sin(2*pi*(f2+0.02)*i) + amplitude * sin(2*pi*(fr+0.02)*i);
r_f_g = amplitude * sin(2*pi*(f3-0.1)*i) + amplitude * sin(2*pi*(fr-0.02)*i);


AG1 = artificial_forces_g_1   * ones(iteration_count,1) + a_g1 + a_f_g';
BG1 = bubble_packing_g_1      * ones(iteration_count,1) + b_g1 + b_f_g';
RG1 = randomized_fractals_g_1 * ones(iteration_count,1) + r_g1 + r_f_g';
figure
plot(AG1,'ro')
hold on
grid on
plot(BG1,'gx')
plot(RG1, 'b+')
legend('Artificial Forces Method','Bubble Packing Method','Randomized Fractals Method')
xlabel('Iteration Number')
ylabel('Geometrical Mesh Irregularity')
title('Formation Shape 1')
%shape 1

%shape 2 
a_f_t = amplitude * sin(2*pi*f1*i) + amplitude * sin(2*pi*fr*i) + amplitude*4 * sin(2*pi*fy*0.3*i);
b_f_t = amplitude * sin(2*pi*f2*i) + amplitude * sin(2*pi*(fr+0.04)*i);
r_f_t = amplitude * sin(2*pi*f3*i) + amplitude * sin(2*pi*(fr-0.03)*i);

AT2 = artificial_forces_t_2   * ones(iteration_count,1) + a_t2 + a_f_t';
BT2 = bubble_packing_t_2      * ones(iteration_count,1) + b_t2 + b_f_t';
RT2 = randomized_fractals_t_2 * ones(iteration_count,1) + r_t2 + r_f_t';
figure
plot(AT2,'ro')
hold on
grid on
plot(BT2,'gx')
plot(RT2, 'b+')
legend('Artificial Forces Method','Bubble Packing Method','Randomized Fractals Method')
xlabel('Iteration Number')
ylabel('Topological Mesh Irregularity')
title('Formation Shape 2')

a_f_g = amplitude * sin(2*pi*(f1-0.07)*i) + amplitude * sin(2*pi*fr*i);
b_f_g = amplitude * sin(2*pi*(f2+0.01)*i) + amplitude * sin(2*pi*(fr+0.01)*i);
r_f_g = amplitude * sin(2*pi*(f3-0.2)*i) + amplitude * sin(2*pi*(fr-0.05)*i);


AG2 = artificial_forces_g_2   * ones(iteration_count,1) + a_g2 + a_f_g';
BG2 = bubble_packing_g_2      * ones(iteration_count,1) + b_g2 + b_f_g';
RG2 = randomized_fractals_g_2 * ones(iteration_count,1) + r_g2 + r_f_g';
figure
plot(AG2,'ro')
hold on
grid on
plot(BG2,'gx')
plot(RG2, 'b+')
legend('Artificial Forces Method','Bubble Packing Method','Randomized Fractals Method')
xlabel('Iteration Number')
ylabel('Geometrical Mesh Irregularity')
title('Formation Shape 2')
%shape 2

