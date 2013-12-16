
function [K] = myacker(A, B, z)
% MYACKER An implementation of ACKER.
%
% MYACKER is an implementation of the Matlab ACKER function.
%
% Given a feedback system it is necessary to find K such
% that the regulator will go to zero.
%
%        +--------------+
%    +-->| x' = Ax + Bu |---+
%    |   +--------------+   |
%    |                      |
%    |       +----+         |
%    +-------| -K |<--------+
%            +----+
%
% By specifying the desired roots (z) K can be found
% using Ackermann's Formula.
%
% The number of roots must match the order of the system.
% And the choice of roots determines how well the system performs.
%
% See also ACKER, PLACE.

n = size(A, 1);  % order of problem
zp = poly(z);

% Controllability Matrix
% [B AB A^2B ... A^(n-1)B]
W = ctrb(A, B);

% [0 0 ... 1]
en = zeros([1 n]);
en(n) = 1;

% alpha = A^n + z(1)*A^(n-1) + ... + z(n)*I
alpha = 0;
for i = 0:n
    if (i == n)
        % last
        alpha = alpha + zp(i+1)*eye(n);
    else
        alpha = alpha + zp(i+1)*A^(n-i);
    end
end

% z = eig(A - B*K)
K = real(en*(W\alpha));
