%% computeM: function description
function [m] = computeM(param, t)
	% param : a1 b1 c1 d1
	% 		  a2 b2 c2 d2
	%
	[a, b, c, d] = unwrapParams(param);
	m = a * t.^3 + b * t.^2 + c * t + d * ones(size(t));