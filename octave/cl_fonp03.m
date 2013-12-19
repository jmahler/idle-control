%
% cl_fonp03.m
%
% Control Law, Full Order, No Prediction
%

clear;

T = 1;  % time step
ncyl = 8;  % number of cylinders
% stabilizes at rpm_lo then steps to rpm_hi
rpm_hi = 700;  % idle rpm
rpm_lo = 200;

% Engine Model
Gy = engine_model(T);
[Phi, Gamma, H, J] = ssdata(Gy);
n = length(Phi);  % order
% engine model that outputs x instead of y
Gx = ss(Phi, Gamma, eye(n), zeros(n,1), T);

% Rz converts rpm to control (0-1)
Rz = ss(0, 0, 0, [1/1450.1], T);

% Hz gain, y = H*x
Hz = ss(0, zeros(1,n), 0, H, T);

% Find K
% roots (arbitrary)
%z1 = [(0.9 + 0.05i) (0.9 - 0.5i) 0];
z1 = [(0.9 + 0.05i) (0.9 - 0.05i) 0.01];
%z1 = [0.5 0.4 0];
%z1 = [0.05 0.04 0];
K1 = place(Phi, Gamma, z1);
% create a gain of -K using D and zeroing others
K1z = ss(zeros(1,1), zeros(1,n), zeros(1,1), -K1, T);

% Build System
% uncompensated feedback loop
sum1 = sumblk('x2 = x1 - rpm1');
sum2 = sumblk('x2b = x1b - rpm1b');
sum3 = sumblk('x2c = x1c - rpm1c');
set(Gx, 'inname', 'e1', 'outname', {'x1', 'x1b', 'x1c'});
sys1 = connect(sum1, sum2, sum3, Gx, {'e1', 'rpm1', 'rpm1b', 'rpm1c'}, {'x2', 'x2b', 'x2c'});
sys2 = feedback(sys1, K1z, [1], [1 2 3], +1);
set(sys2, 'inname', {'u2', 'rpm1', 'rpm1b', 'rpm1c'}, 'outname', {'x2', 'x2b', 'x2c'});
set(Rz, 'inname', {'u1'}, 'outname', {'u2'});
sys3 = connect(sys2, Rz, {'u1', 'rpm1', 'rpm1b', 'rpm1c'}, {'x2', 'x2b', 'x2c'});
% add y = H*x
sys4 = series(sys3, Hz);
sys4 = sminreal(sys4);

% Input signal, rpm_lo then steps to rpm_hi
Tend = 140;  % end in ticks
c1 = Tend/T;
sc = c1/2;  % point at which step occurs
u1 = rpm_lo*ones([sc 1]);
u2 = rpm_hi*ones([sc 1]);
ux = [u1; u2];
u = [ux ux ux ux];

% Simulate
% initial x0
x0 = rpm_lo*H;
[y1,t1] = lsim1(sys4, u, [], x0);

% be sure to avoid zeros, rpmtime doesn't handle them
yX = y1;
%yX = y2(10:end);  % all data, except first zeros (approx)
%yX = y2((stepc+1):end);  % data after step
rt = rpmtime(yX, ncyl);
rt = zerotime(rt);

% Plot
clf;
figure(1);
[ts1,ys1] = stairs(rt,yX);
plot(ts1,ys1);
grid on;
axis tight;
title('Control Law, Full Feedback, No Prediction');
xlabel('time (sec)');
ylabel('rpm');

print('cl_fonp02.eps', '-depsc2');
