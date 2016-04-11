% [w1, w2, yPred] = backprop(X, yTrue, w1, w2, pas1, pas2)
% Compute the back propagation of the output toward the input in a neural network with one hidden layer
% Input:
% - X: examples to learn from
% - yTrue: binary labels exepected for X
% - w1: initial weights for the hidden layer
% - w2: initial weights for the output layer
% - pas1: step size to use for the gradient descent on w1
% - pas2: step size to use for the gradient descent on w2
% Output
% - w1: found weights for the hidden layer
% - w2: found weights for the output layer
% - yPred: binary labels predicted for X

function [w1, w2, yPred] = backprop(X, yTrue, w1, w2, pas1, pas2)
    [a1, a2, z2, z3, yPred] = forward(X, w1, w2);

    % Backward
    ERRk = -(yTrue-yPred).*sigmoidGrad(z3);
    Gradw2 = a2'* ERRk ;

    ERRj = (w2(:, 2:end)' * ERRk')'.*(sigmoid(z2).*(1 - sigmoid(z2)));
    Gradw1 = a1'* ERRj ;

    w1 = w1 - pas1 * Gradw1';
    w2 = w2 - pas2 * Gradw2';
end
