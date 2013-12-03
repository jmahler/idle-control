%
% em_shift_plot2.m
%
% Engine model shifted plot close up.
%

clear;

ncyl = 8;

engine_model;
% eng_sys

% input signal (control)
u_lo = 600/1450.1;
u_hi = 1000/1450.1;
n = 200;  % number of points
u = [u_lo*ones(1,n/2) u_hi*ones(1,n/2)];

% output response
[y, t, x] = lsim(eng_sys, u);

% An rpm of zero makes the rpmtime huge and skews the results.
% Remove these initial zeros.
i = find(y~=0, 1, 'first');
y = y(i:end);
u = u(i:end);
t = t(i:end);

rt = rpmtime(y, 8);
rt = cumsum(rt);

figure(1);

stairs(rt((n/2):end), y((n/2):end));
grid on;
axis([rt(n/2), rt(end)]);
title('Engine Response With Control From 0.41 to 0.69');
xlabel('time (sec)');
ylabel('rpm');

print('em_shift_plot2.eps', '-deps');
