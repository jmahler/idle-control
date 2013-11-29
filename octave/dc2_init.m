% 
% dc1_init.m
%
% Convert a delta input to a steady state output.
%
% Simplified System.
%

T = 1;  % time step

sys = tf([1 0], [1 -1], T, 'inname', 'u1', 'outname', 'y1');
