clear all
close all

px = [.2 .3 .2 .1 .1 .5 .7 1.1 1.4 1.6];
py = [-.4 .1 1.1 1.1 .9 .7 .9 1.1 1.3 1.5];
ti = linspace(0, 1, length(px));

[ti, foundParam, tiCrit, paramCrit] = simpleCombination(ti, px, py);

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

%% With random data
nbEx = 10;
param = rand([2, 4]);

ti = rand([1, nbEx]);
ti = sort(ti);
ti = (ti - ti(1)) ./ (ti(end) - ti(1));

[ti, foundParam, tiCrit, paramCrit] = simpleCombination(ti, px, py);

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

tiCrit(end)
paramCrit(end)

% Parfois avec l'initialisation aléatoire on a de bons résultats, parfois non. C'est parce qu'on a un minimum local.

%% With random data and a better combination
nbEx = 10;
param = rand([2, 4]);

ti = rand([1, nbEx]);
ti = sort(ti);
ti = (ti - ti(1)) ./ (ti(end) - ti(1));

[ti, foundParam, tiCrit, paramCrit] = betterCombination(ti, px, py);

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

tiCrit(end)
paramCrit(end)
