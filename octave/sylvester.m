function [E] = sylvester(A, B)
% SYLVESTER Construct a Sylvester matrix of the two vectors.
%
% Given two vectors, the largest order is determined.
% Then a Sylvester matrix is constructed for that order.
%

	nA = max(size(A));
	nB = max(size(B));

	n = max(nA, nB) - 1;  % order

	% First create a matrix of zeros
	E = zeros((n)*2, (n)*2);
	
	% Then assign specific values for A and B

	% A
	for (col = 1:n)
		for (i = 1:nA)
			row = (nA - i) + col;
			E(row, col) = A(i);
		end
	end

	% B
	for (col = (n+1):n*2)
		for (i = 1:nB)
			row = (nB - i) + (col - n);
			E(row, col) = B(i);
		end
	end
endfunction
