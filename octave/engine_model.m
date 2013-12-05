function [sys] = engine_model(T);
%  ENGINE_MODEL
%
% Linear engine model with zero torque.
%

%T = 1;  % time step

K = tf([1.699], [1], T);
D1= tf([8.5683], [1 -0.9025 0], T);
D2= tf([2.98], [1 -0.9354], T);
G = D1*D2;
D = tf([0.00093], [1], T);

H = K*G/(1 + D*G);

sys = minreal(H);  % cancel common roots

endfunction
