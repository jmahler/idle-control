% initialization for the Linear Engine Model
% 'linear_engine_model.mdl'

idle_rpm = 700;  % (RPM)
num_cyl = 8;
% frequency of ignition impulses
% In two crankshaft rotations all cylinders will fire
% for a 4-stroke engine.
idle_rps = 700/60;  % minute -> second
ign_freq = num_cyl*idle_rps*0.5;  % (Hz)

% engine model time step
Tm = 1/ign_freq;  % (sec)

% control time step
Tc = 0.5;  % (sec)
