%
% norm_engine_model_plot.m
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
subplot(2,1,1);

stairs(rt, u);
grid on;
axis ([rt(1), rt(end)]);
title('Input Signal');
ylabel('control');

subplot(2,1,2);
stairs(rt, yn);
ylabel('Normalized RPM');
grid on;
axis ([rt(1), rt(end)]);
title('Output Response');
xlabel('time (sec)');

print('norm_engine_model_plot.eps', '-deps');
