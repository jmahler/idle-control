%
% norm_engine_plot_close.m
%

clear;

ncyl = 8;

engine_model;
% eng_sys

u0 = 600*1/1450.1;
u1 = 1000*1/1450.1;

% input signal
u = [u0*ones(1,100) u1*ones(1,100)];

% output response
[y, t, x] = lsim(eng_sys, u);

% An rpm of zero makes the rpmtime huge and
% skews the results.
% Remove these initial zeros.
i = find(y~=0, 1, 'first');
y = y(i:end);
u = u(i:end);
t = t(i:end);

rt = rpmtime(y, 8);
rt = cumsum(rt);

% normalized output response
yn = y*(1/400) - 3/2;


figure;

stairs(rt(100:end), yn(100:end));
grid on;
axis([rt(100), rt(end) 0 1.5]);
title('Normalized Engine Response After Step');
xlabel('time (sec)');
ylabel('normalized rpm');

print('norm_engine_plot_close.eps', '-deps');
