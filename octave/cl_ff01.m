%
% cl_ff01.m
%
% Control Law with full feedback.
%

clear;
clf;

T = 1;  % time step
Tend = 100;
ncyl = 8;  % number of cylinders
rpm = 700;  % idle rpm

Gz = engine_model(T);
Gzx = Gz - rpm;
% XXX - Gzx should output zero at rpm, but it doesn't
% A control input of 47/1450.1 results in 700 rpm. Why?
[Phi,Gamma,H,G] = ssdata(Gzx);
% XXX - is this the right H?

n = length(Phi);  % order

% Find K
% roots
%z1 = [0.9 0.9 0];
%z1 = [0.5 0.5 0];
z1 = [(0.9 + 0.05i) (0.9 - 0.5i) 0];
%z1 = [(0.5 + 0.05i) (0.5 - 0.5i) 0];
%z1 = [0.9 0.9 0.9 0.9];
K1 = myacker(Phi, Gamma, z1);
% create a gain of K using D and zeroing others
K1z = ss(zeros(1,1), zeros(1,n), zeros(1,1), K1, T);

% Find Predictor Estimator (Lp)
%H = [1 0 0];  % filter
% roots
z2 = z1*0.84;
%z2 = [(0.4 + 0.4i) (0.4 - 0.4i) 0];
%Lp = place(Phi', H', z2)';
Lp = myacker(Phi', H', z2)';
Pz = ss((Phi - Gamma*K1 - Lp*H), Lp, eye(n), zeros(n,1), T);

% Build System
% upper branch
set(Gz, 'inname', 'gu', 'outname', 'gy');
sum1 = sumblk('y = gy - rpm');
Gzs = connect(Gz, sum1, {'gu', 'rpm'}, {'y'});
% lower feedback branch
K1Pz = series(Pz, K1);
set(K1Pz, 'inname', 'u1', 'outname', 'y1');
% full system
sysX = feedback(Gzs, K1Pz, [1], [1], -1);
sysX = sminreal(sysX);

% Simulate
x0 = [1; zeros(5,1)];
u1 = 0*ones([Tend/T 1]);
u2 = -rpm*ones([Tend/T 1]);  % XXX - shouldn't be negative!
u = [u1 u2];
[y1,t1] = lsim1(sysX, u, [], x0);
%y1 = y1 + rpm;

yX = y1(5:end);
rt = rpmtime(yX, ncyl);

figure(1);
[ts1,ys1] = stairs(rt,yX);
plot(ts1,ys1);
grid on;
axis tight;
title('Control Law, Predictor Estimator');
xlabel('time (sec)');
ylabel('rpm');

%print('cl_ff01.eps', '-depsc2');
