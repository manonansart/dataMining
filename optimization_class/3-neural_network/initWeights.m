% w = initWeights(nbInputs, nbOutputs)
% Randomly initialise the weights for 1 layer of the neural network
function [w] = initWeights(nbInputs, nbOutputs)
    w = randn(nbOutputs, nbInputs);
    w = w / max(max(max(w)), abs(min(min(w)))); % Ensure the weight is between -1 and 1
end
