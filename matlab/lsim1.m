function [y, t, x, i] = lsim1(Hz, u, t, x0);
% LSIM1 - Just like lsim excpt small values are removed.
%
% "small" means less than or equal to 10.
%

switch nargin
    case 2
        t = [];
        x0=false;
    case 3
        x0=false;
end

[y, t, x] = lsim(Hz, u, t, x0);

% Find the first valid value
for i = 1:length(y) 
	x = abs(y(i));
	if (x > 10)
		break;
	end
end

% adjust for removed values
y = y(i:end);
u = u(i:end);
t = t(i:end);

i = i - 1;
