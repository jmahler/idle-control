%
% em_plot2.m
%
% Engine model with no control and x axis in time.
%

clear;

ncyl = 8;

T = 1;  % time step
Gz = engine_model(T);

u = [0.65*ones(1,100)];
[rpm, t, x] = lsim(Gz, u);

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

figure;
subplot(2,1,1);
stairs(rt, u);
grid on;
axis([rt(1), rt(end)]);
title('Input Signal');
ylabel('control');

subplot(2,1,2);
stairs(rt, rpm);
grid on;
axis([rt(1), rt(end)]);
title('Output Response');
ylabel('rpm');
xlabel('time (sec)');

print('em_plot2.eps', '-color', '-deps2');
