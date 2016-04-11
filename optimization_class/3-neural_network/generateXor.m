% [X, y] = generateXor(nbPoints)
% Generate random data for making a wor example
% Input:
% - nbPoints: number of examples we want to have
% Output:
% - X: nbPoints by 2 matrix of examples
% - y: the labels matching X

function [X, y, yLin] = generateXor(nbPoints)
    X = 0.2 + rand(nbPoints, 2);
    signs = (rand(nbPoints, 2) > 0.5) * -2 + 1;
    X = X .* signs;
    y = (signs(:, 1) + signs(:, 2)) == 0;
    yLin = zeros(nbPoints, 4);
    yLin(:, 1) = (signs(:, 1) > 0) & (signs(:, 2) > 0);
    yLin(:, 2) = (signs(:, 1) > 0) & (signs(:, 2) < 0);
    yLin(:, 3) = (signs(:, 1) < 0) & (signs(:, 2) > 0);
    yLin(:, 4) = (signs(:, 1) < 0) & (signs(:, 2) < 0);
end
