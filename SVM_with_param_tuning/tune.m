% Tune the parameters C and sigma for a SVM, based on a learning set (Xlearn, Ylearn) and a validation set (Xval, Yval).
% kernel is the kernel type used for the SVM.
% CList and sigmaList are the grids of values that should be used.
% The test error is computed on (Xtest, Ytest) and displayed.

function [bestCInd, bestSigmaInd] = tune(Xlearn, Ylearn, Xtest, Ytest, Xval, Yval, kernel, CList, sigmaList)
	errors = [];
	bestError = Inf;

	tic
	% Loop over all Cs
	for i=1:length(CList)
		C = CList(i);

		% Loop over all sigmas
		for j=1:length(sigmaList)
			sigma = sigmaList(j);

			% Train the SVM with the given values of C and sigma
			[alphas, b, pos] = train(Xlearn, Ylearn, C, kernel, sigma);

			% Compute the validation error and use it to update the best parameters if necessary
			error = test(Xlearn, Ylearn, Xval, Yval, kernel, sigma, alphas, pos, b);
			errors = [errors; error];
			if (error < bestError)
				bestCInd = i;
				bestSigmaInd = j;
				bestError = error;
			end
		end
	end
	toc

	% Evaluate the error on the test set with the best parameters
	C = CList(bestCInd);
	sigma = sigmaList(bestSigmaInd);
	[alphas, b, pos] = train(Xlearn, Ylearn, C, kernel, sigma);
	error = test(Xlearn, Ylearn, Xtest, Ytest, kernel, sigma, alphas, pos, b);
	fprintf('Error on the test set: %f%% \n', error);

end
