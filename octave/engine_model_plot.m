%
% engine_model_plot.m
%

clear;

engine_model;

u = [0.65*ones(1,100)];
[y, t, x] = lsim(eng_sys, u);

figure;
subplot(2,1,1);

stairs(t, u);
grid on;
axis auto;
title('Input Signal');
ylabel('control');

subplot(2,1,2);
stairs(t, y);
grid on;
axis auto;
title('Output Response');
ylabel('rpm');

print('engine_model_plot.eps', '-deps');
