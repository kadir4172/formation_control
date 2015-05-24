clc
RPM =  1 : 1 :15;
sec_rev = 60 ./ RPM;
sec_tick = sec_rev / 5000;
temp = sec_tick / 0.000016;
format hex
Y = 2^16 - temp*32 - 1;
motor2 = uint16(round(Y))

format long eng
%Y = 2^16 - temp*32
incremental = zeros(length(RPM), 1);
tick_count = 255-temp;
while(~isempty(find(tick_count < 0)))
ind = find(tick_count < 0);
tick_count(ind) = tick_count(ind) +255;
incremental(ind) = incremental(ind) + 1;
end

motor1 = tick_count
motor1_incremental = incremental
