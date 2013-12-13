%
% em_plot4.m
%
% Engine model with no control.
% Allowed to stablize before step is applied.
%

T = 1;

Gz = engine_model(T);

% input signal (control)
u_lo = 600/1450.1;
u_hi = 1000/1450.1;
n = 200;  % number of points
u = [u_lo*ones(1,n/2) u_hi*ones(1,n/2)];

% output response
[y, t, x,i] = lsim1(Gz, u);

rt = rpmtime(y, 8);

% remove data before the step
rt = rt((n/2):end);
y = y((n/2):end);

% reset start time to zero
rt = zerotime(rt);

figure(1);

stairs(rt, y);
grid on;
axis([rt(1), rt(end)]);
title('Engine Response With Control From 0.41 to 0.69');
xlabel('time (sec)');
ylabel('rpm');

print('em_plot4.eps', '-depsc2');
