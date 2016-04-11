function [tinew, JNew] = oneStepGaussNewton(param, tiold, px, py)
	% param : a1 b1 c1 d1
	% 		  a2 b2 c2 d2
	%
	a = param(:, 1);
	b = param(:, 2);
	c = param(:, 3);
	d = param(:, 4);

	p = [px; py];

	% Do the gradient step
	m = computeM(param, tiold);
	mGrad = 3 * a * tiold .^2 + 2 * b * tiold + c * ones(size(tiold));
	mH = 6 * a * tiold + 2 * b * ones(size(tiold));

	% Compute the Hessian for the step
	H = 2 * (mH' * (m - p) + mGrad' *  mGrad);

	direction = diag(2 * mGrad' * (m - p));
	tinew = tiold - (inv(H) * direction)';

	% Check the cost to see if it improves
	Jold = (m - p)' * (m - p);

	mNew = computeM(param, tinew);
	JNew = (mNew - p)' * (mNew - p);
