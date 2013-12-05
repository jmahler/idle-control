function [Hz, Dz, K] = direct_design(Gz, roots, order, limit=1);
% DIRECT_DESIGN - Construct a controller using Direct Design.
%
% 'Gz' is some plant to be controlled.
% 'order' is the order of the system need for the Sylvester Matrix.
% 'roots' are the designer provided roots to achieve in the system (Hz).
%
% The entire system is returned (Hz) along with the controller (Dz)
% and the constant (K) that were used.
%

% Designer provided specifications.
%
n = order;
D = poly(roots);
if (isrow(D))
	D = transpose(D);
end
% Reverse D so Alpha and Beta are in the correct order.
D = flipud(D);

[Bz, Az, T] = tfdata(Gz, 'v');

E = sylvester(Az, Bz);

%M = E^-1*D;
M = E\D;

% Alpha = a0*z + a1
% Beta = b0*z + b1
Alpha = fliplr(transpose(M(1:n)));
Beta = fliplr(transpose(M((n+1):end)));

Dz = tf(Beta, Alpha, T);

% To find K, the limit should go to 1
% for a step input.
% (refer to the notes for a better description)
K = sum(D)/sum(conv(Bz, Alpha));
% XXX

Hz = K*Gz/(1 + Dz*Gz);

endfunction
