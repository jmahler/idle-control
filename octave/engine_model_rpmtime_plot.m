%
% engine_model_rpmtime_plot.m
%

clear;

ncyl = 8;

engine_model;

u = [0.65*ones(1,100)];
[rpm, t, x] = lsim(eng_sys, u);

% An rpm of zero makes the rpmtime huge and
% skews the results.
% Remove these initial zeros.
i = find(rpm~=0, 1, 'first');
rpm = rpm(i:end);
u = u(i:end);
t = t(i:end);

% Convert each rpm point to time instant.
% The cummulative sum is then the time it takes
% to get to that particular point.
rt = rpmtime(rpm, 8);
rt = cumsum(rt);

figure;
subplot(2,1,1);
stairs(rt, u);
grid on;
axis auto;
title('Input Signal');
ylabel('control');

subplot(2,1,2);
stairs(rt, rpm);
grid on;
axis auto;
title('Output Response');
ylabel('rpm');
xlabel('time (sec)');

print('engine_model_rpmtime_plot.eps', '-deps');
