% フィードバックゲイン入力
% V : 速度(+:前)
% alpha : 迎角...進行方向に対する機体の角度(+:右回り)
% dot theta : ピッチ角速度(+:左回り)
% theta : ピッチ角...水平方向に対する機体の角度(+:左回り)
% z : 高度(+:上)

% 推力に関連する項(+:加速)

thrust_data = load("thrust.dat");
f_11=thrust_data(1);
f_12=thrust_data(2);
f_13=thrust_data(3);
f_14=thrust_data(4);
f_15=thrust_data(5);

% エレベータに関連する項(+:下げる)

elevator_data = load("elevator.dat");
f_21=elevator_data(1);
f_22=elevator_data(2);
f_23=elevator_data(3);
f_24=elevator_data(4);
f_25=elevator_data(5);
