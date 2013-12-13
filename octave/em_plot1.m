%
% em_plot.m
%
% Plot of engine model with zero torque and no
% control.  x axis is in ticks (not time).
%

clear;

T = 1;  % time step
Gz = engine_model(T);

u = [0.65*ones(1,100)];
[y, t, x] = lsim(Gz, u);

figure;
subplot(2,1,1);

stairs(t, u);
grid on;
axis([t(1) t(end)]);
title('Input Signal');
ylabel('control');

subplot(2,1,2);
stairs(t, y);
grid on;
axis([t(1) t(end)]);
title('Output Response');
ylabel('rpm');
xlabel('ticks');

print('em_plot1.eps', '-depsc2');
