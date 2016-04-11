clear all
close all

Z = [-2.5 -2 0 .5 1 5 6]';
YTrue = [-1.6 -1.8 3 0.15 -1.3 -.9 -.7]';

% Question 1 & 2
X = computeX(Z, YTrue, 1);
theta = (X'*X)\(X'*YTrue);
YEstim = X*theta;
printErrors('Q1', YEstim, YTrue)

 % Question 2
aCoeffs = ones(size(Z))./ (1 + Z.^2 / 2) ./ YTrue;
bCoeffs = log(1 + abs(Z)) ./ (1 + Z.^2 / 2) ./ YTrue;
X2 = [aCoeffs bCoeffs];
% Estimation
theta = (X2'*X2)\(X2'*ones(size(YTrue)));
YEstim = X * theta;
printErrors('Q2', YEstim, YTrue)

% Question 4 & 5
X = computeX(Z, YTrue, 2);
theta = (X'*X)\(X'*YTrue);
YEstim = X*theta;
printErrors('Q4 and Q5 J''', YEstim, YTrue)

YEstim = (theta(1)+theta(2)*log(1+abs(Z))) ./ (1 + theta(3)*Z.^2);
printErrors('Q4 and Q5 J', YEstim, YTrue)

% Question 6
zn = 8; yn = -.46;
[Pn, thetaN] = handleNewObservation((X'*X)\(X'*YTrue), inv(X'*X), zn, yn, 'add');
Z = [Z; zn]; YTrue = [YTrue; yn];
X = computeX(Z, YTrue, 2);
YEstim = X*thetaN;
printErrors('Q6 J''', YEstim, YTrue)

YEstim = (thetaN(1)+thetaN(2)*log(1+abs(Z))) ./ (1 + thetaN(3)*Z.^2);
printErrors('Q6 J', YEstim, YTrue)

% Question 7
[~, thetaN] = handleNewObservation(thetaN, Pn, Z(1), YTrue(1), 'remove');
Z = Z(2:end); YTrue = YTrue(2:end);
X = computeX(Z, YTrue, 2);
(X'*X)\(X'*YTrue)
thetaN

YEstim = X*thetaN;
printErrors('Q7 J''', YEstim, YTrue)

YEstim = (thetaN(1)+thetaN(2)*log(1+abs(Z))) ./ (1 + thetaN(3)*Z.^2);
printErrors('Q7 J', YEstim, YTrue)
