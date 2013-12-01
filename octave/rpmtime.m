function [tign] = rpmtime(rpm, ncyl)
% RPMTIME Calculate the time (in seconds) between ignition
%  events at a given rpm.
%
%  rpmtime(rpm, ncyl);
%  rpmtime(400, 8);
%

	%ncyl;				% number of cylinders
	%rpm;				% rpm
	ign_rev = ncyl/2;	% igntion points per revolution
	min_sec = 1/60;		% 1 minute per 60 seconds
	%tign;				% seconds per ignition event

	tign = zeros(0,length(rpm));
	for i = 1:length(rpm)
		x = (rpm(i)*min_sec*ign_rev);
		if (0 == x)
			tign(i) = inf;
		else
			tign(i) = 1/x;
		endif
	endfor

endfunction
