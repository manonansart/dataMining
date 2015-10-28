% Compute the test errors, given the learning dataset (Xlearn, Ylearn), the test dataset (Xtest, Ytest),
% the kernel type kernel and its kernel options,
% the potion of the support vectors pos and their coefficients alphas, and b
function error = test(Xlearn, Ylearn, Xtest, Ytest, kernel, kerneloption, alphas, pos, b)

	% Compute the predictions
	Ktest = svmkernel(Xtest, kernel, kerneloption, Xlearn(pos, :));
	ypred = Ktest * (Ylearn(pos) .* alphas) + b;

	% Compute the error
	error = sum(sign(ypred) ~= Ytest) / length(Ytest) * 100;
end
