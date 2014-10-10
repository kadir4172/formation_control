function [ output_args ] = linear_least_squares( input_args )
clc
clear


b1 = [1 5]; %komsu 1
b2 = [3 7]; %komsu 2
b3 = [5 6]; %komsu 3
t  = [3 6]; %gercek nokta

error = rand(3,1) / 2 - 0.25 ; %error between +/- 0.25

r1 = norm([(t(1)-b1(1)) (t(2)-b1(2))]) + error(1);
r2 = norm([(t(1)-b2(1)) (t(2)-b2(2))]) + error(2);
r3 = norm([(t(1)-b3(1)) (t(2)-b3(2))]) + error(3);

d21 = norm([(b2(1)-b1(1)) (b2(2)-b1(2))]);
d31 = norm([(b3(1)-b1(1)) (b3(2)-b1(2))]);

b21 = (r1^2 - r2^2 + d21^2) / 2;
b31 = (r1^2 - r3^2 + d31^2) / 2;

A = [(b2(1)-b1(1)) (b2(2)-b1(2)); (b3(1)-b1(1)) (b3(2)-b1(2))];
B = [b21;b31];

x = pinv(A' * A) * A'*B;
x = x + b1'

end


