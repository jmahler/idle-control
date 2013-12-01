%
% stable_rpm_plot.m
%

clear;

engine_model;

% range of inputs to try
us = linspace(0.2, 0.8, 7);

y = zeros(0, length(us));
for i = 1:length(us)
	% response for a constant input
	u = [us(i)*ones(1,100)];
	[yp, t, x] = lsim(eng_sys, u);

	% save the stable value
	y(i) = yp(end);	
endfor

figure;

plot(us, y, '-o');
grid on;
axis auto;
title('Stable Output Rpm');
xlabel('control input');
ylabel('rpm');

print('stable_rpm_plot.eps', '-deps');
