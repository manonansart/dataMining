clear all
close all

px = [.2 .3 .2 .1 .1 .5 .7 1.1 1.4 1.6]';
py = [-.4 .1 1.1 1.1 .9 .7 .9 1.1 1.3 1.5]';
ti = linspace(0, 1, length(px))';

[foundParam, crit] = estimate_params_MS(ti, px, py);

plot(px, py, 'or');
hold on;
m = computeM(foundParam, ti');
plot(m(1, :), m(2, :), 'x')

t = linspace(0, 1, 10 * length(px))';
m = computeM(foundParam, t');
plot(m(1, :), m(2, :))
title('Optimisation of the parameters')