%
% cd_plot2.m
%

clear;

T = 1;  % time step

sys = tf([1 -1], [1 0], T, 'InputName', 'y1', 'OutputName', 'u1');

u = [1 1 1 -3 -3 2 5 0];
t = 0:(size(u,2)-1);  % start at zero

figure;
subplot(2,1,1);
stairs(t,u);
grid on;
axis auto;
title('Input Signal');
ylabel('u');

subplot(2,1,2);
lsim(sys, u);
grid on;
axis auto;

print('cd_plot2.eps', '-depsc2');
