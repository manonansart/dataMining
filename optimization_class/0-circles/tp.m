clear all
close all

points = [0 1;
    1 0;
    0 -1;
    -1 0;
    sqrt(2)/2 sqrt(2)/2];

Y = points(:, 1).^2 + points(:, 2).^2;
X = [2*points(:, 1) 2*points(:, 2) ones(size(points, 1), 1)];
theta = (X'*X)\(X'*Y);

circleCenterX = theta(1);
circleCenterY = theta(2);
radius = sqrt(circleCenterX^2+circleCenterY^2+theta(3));

plot(points(:, 1)', points(:, 2)', '*b');
hold on
circle(circleCenterX, circleCenterY, radius);
