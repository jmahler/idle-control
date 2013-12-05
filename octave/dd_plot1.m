%
% dd_plot1.m
%
% Direct Design controller close up.
%

clear;

T = 1;

% input signal
u_lo = 600;		% rpm before step
u_hi = 1000;	% rpm after step
n_lo = 30;		% nth tick to step from lo to hi
n_hi = 30;		% ticks after step
u = [u_lo*ones(1,n_lo) u_hi*ones(1,n_hi)];

% build a controller, and the resulting system
Gz = engine_model(T);
roots = [(0.6 + 0.4i) (0.6 - 0.4i) 0 0 0];
order = 3;
limit = 1;
[Hz, Dz, K] = direct_design(Gz, roots, order, limit);

% output response
[y, t, x, i] = lsim1(Hz, u);
% adjust the step point for any removed from the beginning
n_lo -= i;

% convert rpm to time
rt = rpmtime(y, 8);

clf;
figure(1);

% reduce data to what we are interested in
%p_start = 1;  	% all data
p_start = n_lo + 1;	% at step
rt = rt(p_start:end);
y = y(p_start:end);

stairs(rt, y);
axis([rt(1), rt(end)]);
grid on;
title(sprintf('Output Response, step: %d - %d rpm', u_lo, u_hi));
ylabel('rpm');
xlabel('time (sec)');

print('dd_plot1.eps', '-color', '-deps2');
