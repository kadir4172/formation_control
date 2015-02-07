ts1 = 1.950;  %hiz icin oturma suresi[sec]
ts2 = 0.01;  %hiz hatasi integrali icin oturma suresi[sec]
x1max = 1.6; %hiz icin beklenen maksimum deger[m/s]
x2max = 4;   %hiz hatasi integrali icin beklenen maksimum deger[m]

u1max = 3;%kontrol isareti icin beklenen maksimum deger [newton]

param = 0.01 ; %parameter to tradeoff regulation versus control effort
q1 = 1/ (ts1 * x1max^2);
q2 = 1/ (ts2 * x2max^2);
r1 = 1/(u1max^2);
Q = [q1 0;0 q2];
M = [sqrt(q1) 0 ; 0 sqrt(q2)];
R = param * r1;

b= 0.2; % linear friction for all models [kg/s]
%model 1
m = 1.5; %mass of the model1 [kg]
A = [-b/m 0; 1 0];
B = [1/m 0]';
C = [1 0;0 1];
D = [0];


system = ss(A,B,C,D);
Ob = obsv(A,M);
unob = length(A) - rank(Ob);
if (unob == 0)
    disp('A_M is Observable')
else
    disp('A_M is not Observable')
end

Co = ctrb(A,B);
uncon = length(A) - rank(Co);
if(uncon == 0)
    disp('A_B is Controllable')
else
    disp('A_B is not Controllable')
end

if(all(eig(R) > 0))
    disp('R is positive definite')
else
    disp('R is not positive definite')
end

[K,S,e] = lqr(system,Q,R)

