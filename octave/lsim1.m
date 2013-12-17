function [y, t, x, i] = lsim1(Hz, u, t=[], x0=false);
% LSIM1 - Just like lsim excpt small values are removed.
%
% "small" means less than or equal to 10.
%

[y, t, x] = lsim(Hz, u, t, x0);

% Find the first valid value
for i = 1:length(y) 
	x = abs(y(i));
	if (x > 10)
		break;
	end
endfor

% adjust for removed values
y = y(i:end);
u = u(i:end);
t = t(i:end);

i = i - 1;
