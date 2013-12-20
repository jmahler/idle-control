function [Phi, Gamma, H, J] = ss_engine_model(T);
%  SS_ENGINE_MODEL
%
% State Space linear engine model with zero torque.
%

%T = 1;  % time step

% For some reason Matlab doesn't convert from
% the z-domain to the s-domain properly.
% So here we just use what Octave generated.
Phi = [0 0 -0.00237;
	  -1 0 0.08442
	   0 -10 1.83790];
Gamma = [-4.33815; 0; 0];
H = [0 0 -1];
J = 0;
