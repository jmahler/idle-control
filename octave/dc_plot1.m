%
% dc_plot.m
%
% Digital to steady state transfer function.
%

clear;

T = 1;  % time step

D1 = tf([1], [1 0], T, 'inname', 'y1', 'outname', 'r1');
S1 = sumblk('y1 = u1 + r1');
sys = connect(D1, S1, 'u1', 'y1');

u = [1 0 0 -4 0 5 3 3];
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

print('dc_plot1.eps', '-depsc2');
