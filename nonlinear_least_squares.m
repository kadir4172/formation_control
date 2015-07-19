function [x y] = nonlinear_least_squares( agent_index, theta, beacon_array )


for i = 1 : 1 : length(beacon_array)
  X(i) = X(beacon_array(i));
  Y(i) = Y(beacon_array(i));
  R(i) = norm([(X_real(agent_index) - X_real(beacon_array(i))) (Y_real(agent_index) - Y_real(beacon_array(i)))]);
  F(i) = norm([(theta(1) - X(i)) (theta(2) - Y(i))]);
end    

theta_ilk = theta;
for j = 1:1:30
B = zeros(2,2);
A = zeros(2,1);
  for i = 1:1:length(beacon_array)
    B(1,1) = B(1,1) + ((theta(1) - X(i))^2) / ((F(i) + R(i))^2);
    B(1,2) = B(1,2) + ((theta(1) - X(i)) * (theta(2) - Y(i))) / ((F(i) + R(i)) ^2);
    B(2,1) = B(2,1) + ((theta(1) - X(i)) * (theta(2) - Y(i))) / ((F(i) + R(i)) ^2);
    B(2,2) = B(2,2) + ((theta(2) - Y(i))^2) / ((F(i) + R(i))^2);
    
    A(1,1) = A(1,1) + ((theta(1) - X(i)) * F(i)) / (F(i) + R(i));
    A(2,1) = A(2,1) + ((theta(2) - Y(i)) * F(i)) / (F(i) + R(i));
  end

  theta = theta - pinv(B) * A;
 
  for i = 1 : 1 : length(beacon_array)
    F(i) = norm([(theta(1) - X(i)) (theta(2) - Y(i))]);
  end    

end
x = theta(1);
y = theta(2);
theta_son = theta;
end

