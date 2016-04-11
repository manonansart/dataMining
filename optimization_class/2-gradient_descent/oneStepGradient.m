function [tinew, lambdaNew, JNew] = oneStepGradient(param, tiold, px, py, lambda)
	% param : a1 b1 c1 d1
	% 		  a2 b2 c2 d2
	%
	[a, b, c, d] = unwrapParams(param);

	p = [px; py];

	% Do the gradient step
	m = a * tiold ^3 + b * tiold^2 + c * tiold + d;
	mGrad = 3 * a * tiold ^2 + 2 * b * tiold + c;

	direction = 2 * mGrad' * (m - p);
	tinew = tiold - lambda * direction;

	% Check the cost to see if it improves
	Jold = (m - p)' * (m - p);

	mNew = a * tinew ^3 + b * tinew^2 + c * tinew + d;
	JNew = (mNew - p)' * (mNew - p);

	% Update the lambda
	if JNew > Jold
		tinew = tiold;
		lambdaNew = 0.5 * lambda;
	else
		lambdaNew = 1.5 * lambda;
	end