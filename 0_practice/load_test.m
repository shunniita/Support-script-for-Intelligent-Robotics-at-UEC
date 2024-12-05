%% load
data = load("load_test.dat","-ascii");

disp(data);

%% read
x = data(:,1);
y = data(:,2);
z = data(:,3);

disp(x);
disp(y);
disp(z);
