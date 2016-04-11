%% unwrapParams
function [a, b, c, d] = unwrapParams(params)
	% params : a1 b1 c1 d1
	% 		  a2 b2 c2 d2
	%
	a = params(:, 1);
	b = params(:, 2);
	c = params(:, 3);
	d = params(:, 4);