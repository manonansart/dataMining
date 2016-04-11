close all
clear all

a = [4.2; 12.3];
b = [-3.2; -20.2];
c = [0.4; 9.9];
d = [0.2; -0.4];
param = [a b c d];

px = 0.1;
py = 0.9;

ti = 1;
tiGaussNewton = 1;
lambda = 0.5;

gradientPoints = [ti];
gaussNewtonPoints = [ti];

for i = 1:10
	[ti, lambda, J] = oneStepGradient(param, ti, px, py, lambda);
	[tiGaussNewton, JNew] = oneStepGaussNewton(param, tiGaussNewton, px, py);
	gradientPoints = [gradientPoints; ti];
	gaussNewtonPoints = [gaussNewtonPoints; tiGaussNewton];
end

figure(1)
subplot(1, 2, 1)
t = linspace(0, 1, 10);
m = computeM(param, t)
plot(m(1, :), m(2, :))
hold on;
mGrad = computeM(param, gradientPoints')
plot(mGrad(1, :), mGrad(2, :), '*r')
plot(px, py, '*g')
title('Gradient steps')

a = [0:10]'; b = num2str(a); c = cellstr(b);
dx = 0.02; dy = 0.1; % displacement so the text does not overlay the data points
text(mGrad(1, :)+dx, mGrad(2, :)+dy, c);

subplot(1, 2, 2)
J = computeCriteria(param, t, [px; py])
plot(t, J)
hold on
JGrad = computeCriteria(param, gradientPoints', [px; py]);
plot(gradientPoints, JGrad, '*r')
text(gradientPoints+dx, JGrad+dy, c);
title('Cost')


figure(2)
subplot(1, 2, 1)
plot(m(1, :), m(2, :))
hold on;
mGaussNewton = computeM(param, gaussNewtonPoints')
plot(mGaussNewton(1, :), mGaussNewton(2, :), '*r')
plot(px, py, '*g')
title('Gauss Newton steps')

a = [0:10]'; b = num2str(a); c = cellstr(b);
text(mGaussNewton(1, :)+dx, mGaussNewton(2, :)+dy, c);

subplot(1, 2, 2)
J = computeCriteria(param, t, [px; py])
plot(t, J)
hold on
JGrad = computeCriteria(param, gaussNewtonPoints', [px; py]);
plot(gaussNewtonPoints, JGrad, '*r')
text(gaussNewtonPoints+dx, JGrad+dy, c);
title('Cost')
