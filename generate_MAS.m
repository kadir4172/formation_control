function [ X, Y ] = generate_MAS(n)

MU = [0 0]';
COV = [500 0; 0 500];
%COV2 = [0.4 0;0 2];
%COV3 = [3 0;0 0.3];
%COV4 = [0.9 0.5; 0.5 0.8];

R = mvnrnd(MU, COV, n);

X = R(:,1);
Y = R(:,2);


end

