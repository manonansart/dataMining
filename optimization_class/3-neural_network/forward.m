% [a1, a2, z2, z3, a3] = forward(X, W1, W2)
% Compute the propagation of the input toward the output in a neural network with one hidden layer
% Input:
% - X: examples to learn from
% - W1: weights for the hidden layer
% - W2: weights for the second layer
% Output
% - a1: input X to which we added a column of ones to represent the biais
% - a2: output of the hidden layer to which we added a column of ones to represent the biais
% - z2: output of the hidden layer before going through the activation function
% - z3: output of the output layer before going through the activation function
% - a3: final output of the output layer

function [a1, a2, z2, z3, a3] = forward(X, W1, W2)
    % Input layer
    m = size(X, 1);
    a1 = [ones(m, 1) X]; % Add 1

    % Hidden layer
    z2 = a1 * W1';
    a2 = sigmoid(z2);
    a2 = [ones(size(a2, 1), 1) a2]; % Add 1

    % Output layer
    z3 = a2 * W2';
    a3 = softmax(z3')'; % This is H_theta
end
