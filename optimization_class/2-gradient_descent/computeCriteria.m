%% computeCriteria
function [J] = computeCriteria(param, t, p)
	m = computeM(param, t);
	J = diag((m - p  * ones(1, size(m, 2)))' * (m - p * ones(1, size(m, 2))));
