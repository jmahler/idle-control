function [ts] = zerotime(tx);
% ZEROTIME - Given a vector of incrementing times
%  recalculate the times so that it starts at zero.
%

ts = zeros(1,length(tx));
for (i = 2:length(tx))
	ts(i) = (tx(i) - tx(i-1)) + ts(i-1);
end

endfunction
