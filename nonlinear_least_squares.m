function [x y] = nonlinear_least_squares( b1,b2,b3,r1,r2,r3, theta )

%[theta,r1,r2,r3,x1,y1,x2,y2,x3,y3] = linear_least_squares();

x1 = b1(1);
y1 = b1(2);

x2 = b2(1);
y2 = b2(2);

x3 = b3(1);
y3 = b3(2);


theta_ilk = theta;

R = [r1 r2 r3];
X = [x1 x2 x3];
Y = [y1 y2 y3];

f1 = norm([(theta(1)-X(1)) (theta(2)-Y(1))]) -R(1);
f2 = norm([(theta(1)-X(2)) (theta(2)-Y(2))]) -R(2);
f3 = norm([(theta(1)-X(3)) (theta(2)-Y(3))]) -R(3);
F = [f1 f2 f3];

for j = 1:1:30
B = zeros(2,2);
A = zeros(2,1);
  for i = 1:1:3
    B(1,1) = B(1,1) + ((theta(1) - X(i))^2) / ((F(i) + R(i))^2);
    B(1,2) = B(1,2) + ((theta(1) - X(i)) * (theta(2) - Y(i))) / ((F(i) + R(i)) ^2);
    B(2,1) = B(2,1) + ((theta(1) - X(i)) * (theta(2) - Y(i))) / ((F(i) + R(i)) ^2);
    B(2,2) = B(2,2) + ((theta(2) - Y(i))^2) / ((F(i) + R(i))^2);
    
    A(1,1) = A(1,1) + ((theta(1) - X(i)) * F(i)) / (F(i) + R(i));
    A(2,1) = A(2,1) + ((theta(2) - Y(i)) * F(i)) / (F(i) + R(i));
  end

  theta = theta - pinv(B) * A;
  
f1 = norm([(theta(1)-X(1)) (theta(2)-Y(1))]) -R(1);
f2 = norm([(theta(1)-X(2)) (theta(2)-Y(2))]) -R(2);
f3 = norm([(theta(1)-X(3)) (theta(2)-Y(3))]) -R(3);
F = [f1 f2 f3];
end
x = theta(1);
y = theta(2);
theta_son = theta;
end

