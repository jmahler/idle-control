%
% dd_plot2.m
%
% Plot of solution using direct design compared to no control.
%

clear;

T = 1;
ncyl = 8;

% input signal
u_lo = 600;		% rpm before step
u_hi = 1000;	% rpm after step
% different systems take longer to stabilize (time lo)
n1_lo = 30;		% nth tick to step from lo to hi
n2_lo = 100;
n_hi = 30;		% ticks after step
u1 = [u_lo*ones(1,n1_lo) u_hi*ones(1,n_hi)];
% convert to control values (without control)
u2 = [(u_lo/1450.1)*ones(1,n2_lo) (u_hi/1450.1)*ones(1,n_hi)];

% Build a controller, and the resulting system.
Gz1 = engine_model(T);
% These roots are guess, taken from some other example.
roots = [(0.6 + 0.4i) (0.6 - 0.4i) 0 0 0];
order = 3;
[Hz1, Dz1, K1] = direct_design(Gz1, roots, order);

% System with no control.
Gz2 = engine_model(T);

% output response
[y1, t1, x, i1] = lsim1(Hz1, u1);
[y2, t2, x, i2] = lsim1(Gz2, u2);  % no control
% adjust the step point for any removed from the beginning
i = max([i1 i2]);

% convert rpm to time
rt1 = rpmtime(y1, ncyl);
rt2 = rpmtime(y2, ncyl);

% remove data before step is applied
p1_start = (length(rt1) - n_hi) + 1;
rt1 = rt1(p1_start:end);
y1 = y1(p1_start:end);

p2_start = (length(rt2) - n_hi) + 1;
rt2 = rt2(p2_start:end);
y2 = y2(p2_start:end);

% reset times to start at zero
rt1 = zerotime(rt1);
rt2 = zerotime(rt2);

% plot

clf;
figure(1);

[xs1, ys1] = stairs(rt1, y1);
[xs2, ys2] = stairs(rt2, y2);
plot(xs2, ys2, xs1, ys1);

grid on;
title(sprintf('Output Response, step: %d - %d rpm', u_lo, u_hi));
ylabel('rpm');
xlabel('time (sec)');
legend('no control', 'direct design');

print('dd_plot2.eps', '-color', '-deps2');
