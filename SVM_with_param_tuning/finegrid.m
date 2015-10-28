% Compute fine grids of nbRun values to test for C and sigma, SVM paramters.
% The grids are computed based on two coarse grid of values, CList and sigmaList,
% and the indices of the best parameters found for those two coarse grids, bestCInd, bestSigmaInd.

function [CList, sigmaList] = finegrid(CList, sigmaList, bestCInd, bestSigmaInd, nbRun);

	Cmin = CList(max(bestCInd - 2, 1));
	Cmax = CList(min(bestCInd + 2, length(CList)));
	CList = linspace(Cmin, Cmax, nbRun);

	sigmaMin = sigmaList(max(bestSigmaInd - 2, 1));
	sigmaMax = sigmaList(min(bestSigmaInd + 2, length(sigmaList)));
	sigmaList = linspace(sigmaMin, sigmaMax, nbRun);
end
