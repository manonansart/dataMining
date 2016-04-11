%% simpleCombination
function [ti, foundParam, tiCrit, paramCrit] = simpleCombination(ti, px, py)
	paramCrit = [];
	tiCrit = [];

	for j = 1:200
		[foundParam, crit] = estimate_params_MS(ti', px', py');
		paramCrit = [paramCrit; crit];

		for i = 1:10
			for k = 1:length(ti)
				[newti, JNew] = oneStepGaussNewton(foundParam, ti(k), px(k), py(k));
				ti(k) = newti;
			end
		end
		ti = sort(ti);
		ti = (ti - ti(1)) ./ (ti(end) - ti(1));
		tiCrit = [tiCrit; JNew];
	end
