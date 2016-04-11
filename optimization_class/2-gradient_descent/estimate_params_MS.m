%% estimate_params_MS
% Returns the params as [ax bx cx dx;
%						 ay by cy dy]
% ti, px and py must be column vectors
function [param,crit] = estimate_params_MS(ti, px, py)

	X = [ti.^3 ti.^2 ti ones(size(ti))];

	thetaX = (X'*X) \ (X' * px);
	thetaY = (X'*X) \ (X' * py);

	Jx = (X * thetaX - px)' * (X * thetaX - px);
	Jy = (X * thetaY - py)' * (X * thetaY - py);

	crit = Jx + Jy;
	param = [thetaX' ; thetaY'];