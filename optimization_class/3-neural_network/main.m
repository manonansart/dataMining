clear all
close all

load('datasets/pendigits.mat');

X = data(:, 1:16);
Y = data(:, end);
clear data;

% Dimensions du réseau de neurones
[n, E] = size(X);
S = length(unique(Y));
nbHiddenNeurons = round((E + S)/2); % Number of neurons in the hidden layer
initalStepSize = 0.001;
nbIterationsMax = 80;

% Préparation des données
[X, ~, ~] = standardizeCols(X);

[Xapp, Yapp, Xtest, Ytest] = splitdata(X, Y, 0.5);
[Xval, Yval, Xtest, Ytest] = splitdata(Xtest, Ytest, 0.5);

Yapp = binariseOutput(Yapp);
Yval = binariseOutput(Yval);
Ytest = binariseOutput(Ytest);

% Apprentissage des poids
[errors, w, yValPred] = runNN(Xapp, Xval, Yapp, Yval, initalStepSize, nbIterationsMax, nbHiddenNeurons);

% Erreur en validation
Yfinal = zeros(size(Yval));
[~, indicesMax] = max(yValPred, [], 2);
for i = 1:length(Yfinal)
    Yfinal(i, indicesMax(i)) = 1;
end
errorValidation = sum(sum(abs(Yfinal - Yval))) / (2 * size(Yval, 1))

% Erreur en test
[~, ~, ~, ~, yTestPred] = forward(Xtest, w.w1, w.w2);
Yfinal = zeros(size(yTestPred));
[~, indicesMax] = max(yTestPred, [], 2);
for i = 1:length(Yfinal)
    Yfinal(i, indicesMax(i)) = 1;
end
errorTest = sum(sum(abs(Yfinal - Ytest))) / (2 * size(Ytest, 1))

figure
plot(errors.app)
hold on
plot(errors.val, 'r')
title('Évolution des erreurs')
legend('Erreur d''apprentissage', 'Erreur de validation')
xlabel('Nombre d''itérations')
ylabel('Erreur')
