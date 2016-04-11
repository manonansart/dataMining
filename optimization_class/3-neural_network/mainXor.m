clear all
close all

nbPoints = 5000;
[X, y, yLin] = generateXor(nbPoints);
[X, ~, ~] = standardizeCols(X);

figure
plot(X(:, 1), X(:, 2), 'xb');
hold on
indPos = (y(:, 1) == 1);
plot(X(indPos, 1), X(indPos, 2), 'xr');
title('Données originales générées')


%% Séparation non linéaire
% Paramètres du réseau de neurones
nbHiddenNeurons = 2;
initalStepSize = 0.00001;
nbIterationsMax = 800;

[Xapp, Yapp, Xtest, Ytest] = splitdata(X, y, 0.5);
[Xval, Yval, Xtest, Ytest] = splitdata(Xtest, Ytest, 0.5);

Yapp = binariseOutput(Yapp);
Yval = binariseOutput(Yval);
Ytest = binariseOutput(Ytest);

% Apprentissage du réseau de neurones
[errors, w, yValPred] = runNN(Xapp, Xval, Yapp, Yval, initalStepSize, nbIterationsMax, nbHiddenNeurons);

[~, ~, ~, ~, yTestPred] = forward(Xtest, w.w1, w.w2);
Yfinal = zeros(size(yTestPred));
[~, indicesMax] = max(yTestPred, [], 2);
for i = 1:length(Yfinal)
    Yfinal(i, indicesMax(i)) = 1;
end
errorTest = sum(sum(abs(Yfinal - Ytest))) / (2 * size(Ytest, 1));

disp(strcat(strcat('Taux d''erreur en test avec 2 classes : ', num2str(errorTest * 100)), '%'));

figure
plot(errors.app)
hold on
plot(errors.val, 'r')
title('Évolution des erreurs')
legend('Erreur d''apprentissage', 'Erreur de validation')
xlabel('Nombre d''itérations')
ylabel('Erreur')

figure
plot(Xtest(:, 1), Xtest(:, 2), 'xb');
hold on
indPos = (Yfinal(:, 1) == 1);
plot(Xtest(indPos, 1), Xtest(indPos, 2), 'xr');
title('Données de test labélisées')

%% Passage à 4 classes
yLinNum = sum(yLin * diag(1:4), 2);

[Xapp, YLinappNum, Xtest, YLintestNum] = splitdata(X, yLinNum, 0.5);
[Xval, YLinvalNum, Xtest, YLintestNum] = splitdata(Xtest, YLintestNum, 0.5);

YLinapp = binariseOutput(YLinappNum);
YLinval = binariseOutput(YLinvalNum);
YLintest = binariseOutput(YLintestNum);

% Paramètres du réseau de neurones
nbHiddenNeurons = 2;
initalStepSize = 0.00001;
nbIterationsMax = 800;

[errors, w, yLinValPred] = runNN(Xapp, Xval, YLinapp, YLinval, initalStepSize, nbIterationsMax, nbHiddenNeurons);

[~, ~, ~, ~, yTestPred] = forward(Xtest, w.w1, w.w2);
YLinfinal = zeros(size(yTestPred));
[~, indicesMax] = max(yTestPred, [], 2);
for i = 1:length(YLinfinal)
    YLinfinal(i, indicesMax(i)) = 1;
end

errorRate = sum(sum(abs(sum(YLinfinal * diag(1:4), 2) - sum(YLintest * diag(1:4), 2)))) / (2 * size(YLintest, 1));

disp(strcat(strcat('Taux d''erreur avec 4 classes : ', num2str(errorRate * 100)), '%'));

figure
plot(errors.app)
hold on
plot(errors.val, 'r')
title('Évolution des erreurs')
legend('Erreur d''apprentissage', 'Erreur de validation')
xlabel('Nombre d''itérations')
ylabel('Erreur')

figure
plot(Xtest(:, 1), Xtest(:, 2), 'xb');
hold on
ind1 = (YLinfinal(:, 1) == 1);
ind2 = (YLinfinal(:, 2) == 1);
ind3 = (YLinfinal(:, 3) == 1);
plot(Xtest(ind1, 1), Xtest(ind1, 2), 'xr');
plot(Xtest(ind2, 1), Xtest(ind2, 2), 'xg');
plot(Xtest(ind3, 1), Xtest(ind3, 2), 'xy');
title('Données de test labélisées')
