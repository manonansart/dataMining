% Train a SVM using the provided kernel and kerneloption,
% on the learning dataset (Xlearn, Ylearn)
% This function uses the method monqp developed by S. Canu

function [alphas, b, pos] = train(Xlearn, Ylearn, C, kernel, kerneloption)
	% Create the n x n matrix for the kernel
	K = svmkernel(Xlearn, kernel, kerneloption, Xlearn);
	G = (Ylearn * Ylearn').* K ;

	% Learning with monqp
	lambda = eps^.5;
	[n, p] = size(Xlearn);
	e = ones(n, 1);
	[alphas, b, pos] = monqp(G, e, Ylearn, 0, C, lambda, 0);
end
