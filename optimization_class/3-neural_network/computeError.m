% [err] = computeError(Y, yPred)
% Compute the difference rate between two vectors Y and ypred

function [err] = computeError(Y, yPred)
    err = sum(diag((yPred - Y)' * (yPred - Y))) / sum(diag(Y' * Y));
end
