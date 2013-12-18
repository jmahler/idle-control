%
% cl_ff01.m
%
% Control Law with full feedback.
% Intuitive Design.
%

clear;

T = 1;  % time step
Tend = 200;  % end in ticks
ncyl = 8;  % number of cylinders
% stabilizes at rpm_lo then steps to rpm_hi
rpm_hi = 700;  % idle rpm
rpm_lo = 200;

% choose any K <= 1
% larger values increase overshoot
K = 0.01;

Gz = engine_model(T);

% Build System
% upper branch
sum1 = sumblk('e1 = u + r1');
% convert rpm to control
Rz = tf([1], [1450.1], T, 'inname', 'e1', 'outname', 'x1');
set(Gz, 'inname', 'x1', 'outname', 'x2');
sum2 = sumblk('y = x2 - r2');
sys1 = connect(sum1, Rz, Gz, sum2, {'u', 'r1', 'r2'}, {'y'});
% feedback branch
Kz = tf([-K], [1], T, 'inname', 'y', 'outname', 'u');
% full system
sysX = feedback(sys1, Kz, [1], [1], +1);
sysX = sminreal(sysX);

% Simulate
x0 = [1; zeros(length(sysX.a) - 1, 1)];
u1 = 0*ones([Tend/T 1]);
c1 = Tend/T;
stepc = c1/2;  % point at which step occurs
r1 = [rpm_lo*ones([stepc 1]); rpm_hi*ones([stepc 1])];;
r2 = r1;
u = [u1 r1 r2];
[y1,t1] = lsim1(sysX, u, [], x0);
y2 = y1 + r2;  % compensate for zero output in plot

% be sure to avoid zeros, rpmtime doesn't handle them
%yX = y2(10:end);  % all data, except first zeros (approx)
yX = y2((stepc+1):end);  % data after step
rt = rpmtime(yX, ncyl);
rt = zerotime(rt);

% Plot
clf;
figure(1);
[ts1,ys1] = stairs(rt,yX);
plot(ts1,ys1);
grid on;
axis tight;
title('Control Law, Intuitive Design');
xlabel('time (sec)');
ylabel('rpm');

print('cl_ff01.eps', '-depsc2');
