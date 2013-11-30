% 
% delta_engine_model.m
%
% Linear engine model with delta inputs/outputs.
%

T = 1;  % time step

D1 = tf([1.699], [1], T, 'inname', 'delta_control', 'outname', 'y1');
S1 = sumblk('e1 = y1 - y3');
D2 = tf([8.5683], [1 -0.9025 0], T, 'inname', 'e1', 'outname', 'y2');
S2 = sumblk('e2 = y2 - delta_torque');
D3 = tf([2.98], [1 -0.9534], T, 'inname', 'e2', 'outname', 'delta_rpm');
D4 = tf([0.000093], [1], T, 'inname', 'delta_rpm', 'outname', 'y3');

delta_engine_model_sys = connect(D1, D2, D3, D4, S1, S2, {'delta_control', 'delta_torque'}, 'delta_rpm');

t_end = 100;
Nt = t_end + 1 ;
t = linspace(0, t_end, Nt);
m = 2;
%u = ones(Nt, m);  % step on all inputs
u = [0*ones(Nt,1) 0*ones(Nt,1)];
u(1,2) = 1;
u(2,2) = 1;
u(3,2) = 1;
u(4,2) = 1;

[y,t,x] = lsim(delta_engine_model_sys, u, t);

plot(t,y);
