clear all
close all

px = [.2 .3 .2 .1 .1 .5 .7 1.1 1.4 1.6];
py = [-.4 .1 1.1 1.1 .9 .7 .9 1.1 1.3 1.5];
ti = linspace(0, 1, length(px));

paramCrit = [];
nbPoints = 100;
tiCrit = [];
JBest = +inf;
bestTi = 0; bestParams = 0;

for j = 1:200
	[foundParam, crit] = estimate_params_MS(ti', px', py');
	paramCrit = [paramCrit; crit];


	for k = 1:length(ti)
		[newti, JNew] = geneticAlgo(foundParam, px(k), py(k));
		ti(k) = newti;
	end

	tiCrit = [tiCrit; JNew];

	if tiCrit(end) < JBest
		JBest = tiCrit(end);
		bestTi = sort(ti);
		bestTi = (bestTi - bestTi(1)) ./ (bestTi(end) - bestTi(1));
		bestParams = foundParam;
	end
end

figure
plot(paramCrit);
title('Couts de l''optimisation des paramètres')

figure
plot(tiCrit);
title('Couts de l''optimisation des ti')

figure
plot(px, py, 'or');
hold on;
m = computeM(foundParam, ti);
plot(m(1, :), m(2, :), 'x')

t = linspace(0, 1, 10 * length(px))';
m = computeM(foundParam, t');
plot(m(1, :), m(2, :))
title('Optimisation of the parameters')
