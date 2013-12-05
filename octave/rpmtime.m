function [ts] = rpmtime(rpm, ncyl)
% RPMTIME Calculate the cummulative time (in seconds) between
%  ignition events at a given rpm.
%
%  [ts] = rpmtime(rpm, ncyl);
%  [ts  = rpmtime(400, 8);
%

%ncyl;				% number of cylinders
%rpm;				% rpm
ign_rev = ncyl/2;	% igntion points per revolution
min_sec = 1/60;		% 1 minute per 60 seconds
%ts	;				% seconds per ignition event

ts = zeros(0,length(rpm));  % initial empty vector
for i = 1:length(rpm)
	x = (rpm(i)*min_sec*ign_rev);

	if (0 == x)
		ts(i) = inf;
	else
		ts(i) = 1/x;
	endif
endfor

ts = cumsum(ts);

endfunction
