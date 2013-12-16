%
% cl_ff01.m
%
% Control Law with full feedback.
%

clear;
clf;

T = 1;  % time step
Tend = 10;

% roots
z1 = [0.9 0 0];
%z1 = [0.9 0.9 0];
%z2 = [(0.9 + 0.05i) (0.9 - 0.5i) 0];
%z1 = [0.9 0.9 0.9 0.9];
%z2 = [(0.9 + 0.05i) (0.9 - 0.5i) (0.8 + 0.4i) (0.8 - 0.4i)];

Gz = engine_model(T);

[A,B,C,D] = tf2ss(Gz);
sysD = ss(Gz);

n = length(A);  % order

[Phi,Gamma,H,G] = ssdata(sysD);

% can't use 'place' with identical roots
%K1 = place(Phi, Gamma, z1);
K1 = myacker(Phi, Gamma, z1);
%K2 = myacker(Phi, Gamma, z2);

% create a gain of K using D and zeroing others
sysK1 = ss(zeros(1,1), zeros(1,3), zeros(1,1), K1, T);
%sysK2 = ss(zeros(1,1), zeros(1,n), zeros(1,1), K2, T);

sysCL1 = feedback(sysD, sysK1, -1);
%sysCL2 = feedback(sysD, sysK2, -1);

% simplify, structural pole/zero cancellation
sysCL1 = sminreal(sysCL1);
%sysCL2 = sminreal(sysCL2);

%u = zeros([(Tend/T) 1]);
%[y1,t1] = lsim(sysCL1, u, [], x0);
%[y2,t2] = lsim(sysCL2, u, [], x0);

%figure(1);
%subplot(2, 1, 1);
%%plot(t2, y1);  % all
%plot(t2, y1(:,1));  % one
%grid on;
%axis tight;
%title('Regulator Response, roots: (0.9 0.9 0.9 0.9)');
%%xlabel('time (sec)');
%ylabel('y');
%
%subplot(2, 1, 2);
%%plot(t2, y2);  % all
%plot(t2, y2(:,1));  % one
%grid on;
%axis tight;
%title('Regulator Response, roots: (0.9 + 0.05i) (0.9 - 0.5i) (0.8 + 0.4i) (0.8 - 0.4i)');
%xlabel('time (sec)');
%ylabel('y');
%
%print('cl_ff01.eps', '-depsc2');
