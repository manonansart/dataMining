% Apply a Gaussian SVM on a dataset, using a validation set to tune the SVM parameters C and sigma

clear all;
close all;

% Read the learning dataset
[Xlearn, Ylearn] = read_libsvm('splice.a');
% Read the test dataset
[Xtestval, Ytestval] = read_libsvm('splice.t');
% Split the test dataset between validation and test
[Xtest, Ytest, Xval, Yval] = split(Xtestval, Ytestval, 0.5);
clear Xtestval
clear Ytestval

% Number of values to test for each grid
nbValuesPerGrid = 10;

% Kernel type
kernel = 'gaussian';

%% Coarse grid
CList = logspace(-0.5, 2, nbValuesPerGrid);
sigmaList = logspace(0.5, 1, nbValuesPerGrid);
[bestCInd, bestSigmaInd] = tune(Xlearn, Ylearn, Xtest, Ytest, Xval, Yval, kernel, CList, sigmaList);

%% Finer grid
[CList, sigmaList] = finegrid(CList, sigmaList, bestCInd, bestSigmaInd, round(nbValuesPerGrid / 2));
[bestCInd, bestSigmaInd] = tune(Xlearn, Ylearn, Xtest, Ytest, Xval, Yval, kernel, CList, sigmaList);

%% Display best parameters
CList(bestCInd)
sigmaList(bestSigmaInd)
