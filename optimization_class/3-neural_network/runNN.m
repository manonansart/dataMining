% [errors, w, yValPred] = runNN(initalStepSize, nbIterationsMax)
% Run the 1 layer neural network by calling backprop and forward, using a gradient descent with an adaptative step size
% Input:
% - Xapp: matrix of examples to use for the forward step
% - Xval: matrix of examples to use for the back propagation
% - Yapp: N by S matrix of labels matching Xapp.
%   S is the number of classes and Yapp(i, s) = 1 if the example i is of class s, 0 otherwise
% - Yval: M by S matrix of labels matching Xval
%   S is the number of classes and Yapp(i, s) = 1 if the example i is of class s, 0 otherwise
% - initalStepSize: the inital step size that should be used for the gradient descent
% - nbIterationsMax: the maximum number of iterations that the neural network should do
% - nbHiddenNeurons: the number of neurons to put in the hidden layer
% Output:
% - errors: object containing 2 attributes
%   - errors.val: vector containing the error made on the validation set for each iteration
%   - errors.app: vector containing the error made on the learning set for each iteration
% - w: object containing 2 attributes
%   - w.w1: coefficients learn for the hidden layer
%   - w.w2: coefficients learn for the output layer
% - bestYValPred: matrix of coefficients predicted by the neural network for Xapp

function [errors, w, bestYValPred] = runNN(Xapp, Xval, Yapp, Yval, initalStepSize, nbIterationsMax, nbHiddenNeurons)
    E = size(Xapp, 2);
    S = size(Yapp, 2);

    w1 = initWeights(E + 1, nbHiddenNeurons); % We will add one column to X to represent the bias
    w2 = initWeights(nbHiddenNeurons + 1, S);

    errorsApp = [];
    errorsVal = [];
    stepSize = initalStepSize;
    finished = false;
    nbIterations = 1;
    bestErr = +inf;
    bestw1 = [];
    bestw2 = [];

    while not(finished)
        [w1New, w2New, yPred] = backprop(Xapp, Yapp, w1, w2, stepSize, stepSize);
        errorApp = computeError(Yapp, yPred);
        [~, ~, ~, ~, yValPred] = forward(Xval, w1, w2);
        errorVal = computeError(Yval, yValPred);

        if nbIterations > 1 & errorApp > errorsApp(end)
            stepSize = stepSize / 2;
            errorsApp = [errorsApp; errorApp];
            errorsVal = [errorsVal; errorVal];
        else
            nbIterations = nbIterations + 1;
            if nbIterations > 2
                stepSize = stepSize * 1.25;
            end
            errorsApp = [errorsApp; errorApp];
            errorsVal = [errorsVal; errorVal];
            w1 = w1New; w2 = w2New;
        end

        if errorVal < bestErr
            bestErr = errorVal;
            bestw1 = w1;
            bestw2 = w2;
            bestYValPred = yValPred;
        end

        if nbIterations > 50
            finished = (max(errorsVal(end-49:end)) - min(errorsVal(end-49:end))) < 10^-2;
            finished = finished | nbIterations == nbIterationsMax;
        end
    end

    errors.val = errorsVal;
    errors.app = errorsApp;

    w.w1 = bestw1;
    w.w2 = bestw2;
end
