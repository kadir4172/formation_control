function [x y] = linear_least_squares(agent_index,beacon_array)
X_real = evalin('base', 'X_real');
Y_real = evalin('base', 'Y_real');
X = evalin('base', 'X');
Y = evalin('base', 'Y');

r1 = norm([(X_real(agent_index) - X_real(beacon_array(1))) (Y_real(agent_index) - Y_real(beacon_array(1)))]);
for i = 2 : 1 : length(beacon_array)
  A((i-1),1) = X(beacon_array(i)) - X(beacon_array(1));  % A matrisinin elemanlari X-Y degerleri ile hesaplandi, gercek degerler ile degil
  A((i-1),2) = Y(beacon_array(i)) - Y(beacon_array(1));
  r      = norm([(X_real(agent_index) - X_real(beacon_array(i))) (Y_real(agent_index) - Y_real(beacon_array(i)))]);
  d      = norm([(X_real(beacon_array(1)) - X_real(beacon_array(i))) (Y_real(beacon_array(1)) - Y_real(beacon_array(i)))]);
  B(i-1)   = (r1^2 - r^2 + d^2) / 2;
end

if(rank(A) == 2) % A is full column rank matrix, direct solution or minimum norm solution is available
  if(length(beacon_array) == 3) % A is full column 2*2 matrix, direct solution available
    pos = inv(A) * B';
    %pos = pinv((A') * A) * A' * B'; 
    pos(1) = pos(1) + X_real(beacon_array(1));
    pos(2) = pos(2) + Y_real(beacon_array(1));
    x = pos(1);
    y = pos(2);
  else % A is full column and a unique minimum norm solution is available
    pos = pinv((A') * A) * A' * B'; 
    pos(1) = pos(1) + X_real(beacon_array(1));
    pos(2) = pos(2) + Y_real(beacon_array(1));
    x = pos(1);
    y = pos(2);
  end
elseif(rank(A) == 1) % columns of A is linear dependent and minimum norm solution will be derived with non linear least squares
    pos = pinv((A') * A) * A' * B';
    pos(1) = pos(1) + X_real(beacon_array(1));
    pos(2) = pos(2) + Y_real(beacon_array(1));
    x = pos(1);
    y = pos(2);
    theta = [x y]';
    nonlinear_method_called = 1
    [x y] = nonlinear_least_squares(agent_index, theta, beacon_array);    
end

end


