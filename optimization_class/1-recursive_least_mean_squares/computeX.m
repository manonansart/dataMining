%% computeX: function description
function [X] = computeX(Z, second, modelId)
    if modelId == 1
        firstCoeff = ones(size(Z)) ./ (1 + (Z.^2)/2);
        secondCoeff = log(1+abs(Z)) ./ (1 + (Z.^2)/2);

        X = [firstCoeff secondCoeff];
    else
        secondCoeff = log(1+abs(Z));
        thirdCoeff = -Z.*Z.*second;
        X = [ones(size(Z)) secondCoeff thirdCoeff];
    end

