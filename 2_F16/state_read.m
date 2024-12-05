load('state_202X.mat')

disp('A')
disp(A)

disp('B')
disp(B)

% 対角行列QとR
Q = diag([1, 1, 1, 1, 1]); % 状態変数ごとの重み
R = diag([1, 1]);          % 制御入力の重み

% ゲイン行列K
K = lqr(A, B, Q, R);

disp('K = [')
disp(K)
disp(']')

% これはできない
% [f_11, f_12, f_13, f_14, f_15] = K(1,:);
% [f_21, f_22, f_23, f_24, f_25] = K(2,:);

% 代入
for j = 1:5
    for i = 1:2
        eval(['f_',num2str(i),num2str(j), '= K(',num2str(i) ',', num2str(j) , ');']);
    end
end

% 代入確認
disp([f_11, f_12, f_13, f_14, f_15])
disp([f_21, f_22, f_23, f_24, f_25])
