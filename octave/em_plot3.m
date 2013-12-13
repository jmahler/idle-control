%
% em_plot3.m
%
% Plot of stable output rpm's for a given control input.
%

clear;

T = 1;
Gz = engine_model(T);

% range of inputs to try
us = linspace(0.2, 0.8, 7);

y = zeros(0, length(us));
for i = 1:length(us)
	% response for a constant input
	u = [us(i)*ones(1,100)];
	[yp, t, x] = lsim(Gz, u);

	% save the stable value
	y(i) = yp(end);	
endfor

figure(1);

plot(us, y, '-o');
grid on;
axis auto;
title('Stable Output Rpm');
xlabel('control input');
ylabel('rpm');

print('em_plot3.eps', '-depsc2');
