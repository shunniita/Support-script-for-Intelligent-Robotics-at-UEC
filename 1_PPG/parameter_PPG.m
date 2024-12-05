% 「フィードバックゲインの設定」の部分を以下のように改変する。
% (元の部分はコメントアウトしておくとよい)

gain_data = load("gain.dat");
Th_P = gain_data(1);
Th_D = gain_data(2);
delta_P = gain_data(3);
delta_D = gain_data(4);
