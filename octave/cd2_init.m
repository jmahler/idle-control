% 
% cd2_init.m
%
% Convert a steady state input to a delta output.
%
% Simplified System.
%

T = 1;  % time step

sys = tf([1 -1], [1 0], T, 'inname', 'y1', 'outname', 'u1');
