%% betterCombination
function [bestTi,  bestParams, tiCrit, paramCrit] = betterCombination(ti, px, py)
	paramCrit = [];
	tiCrit = [];
	JBest = +inf;
	bestTi = 0; bestParams = 0;

	for j = 1:200
		[foundParam, crit] = estimate_params_MS(ti', px', py');
		paramCrit = [paramCrit; crit];

		for i = 1:10
			for k = 1:length(ti)
				[newti, JNew] = oneStepGaussNewton(foundParam, ti(k), px(k), py(k));
				ti(k) = newti;
			end
		end
		tiCrit = [tiCrit; JNew];

		if tiCrit(end) < JBest
			JBest = tiCrit(end);
			bestTi = sort(ti);
			bestTi = (bestTi - bestTi(1)) ./ (bestTi(end) - bestTi(1));
			bestParams = foundParam;
		end

		if j > 1 & abs(tiCrit(end) - tiCrit(end-1)) < 10^-4 & abs(paramCrit(end) - paramCrit(end-1)) < 10^-4
			ti = ti .* (0.8 + 0.4 * rand(size(ti)));
		end
		
		ti = sort(ti);
		ti = (ti - ti(1)) ./ (ti(end) - ti(1));
	end
end