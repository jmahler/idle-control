% 
% dc1_init.m
%
% Convert a delta input to a steady state output.
%
% Full System.
%

T = 1;  % time step

D1 = tf([1], [1 0], T, 'inname', 'y1', 'outname', 'r1');
S1 = sumblk('y1 = u1 + r1');
sys = connect(D1, S1, 'u1', 'y1');
