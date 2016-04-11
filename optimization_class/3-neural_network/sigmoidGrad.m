function g = sigmoidGrad(z)
%SIGMOID Compute sigmoid functoon
%   J = sigmoidGrad(z) computes the gradient of the sigmoid of z.

	g = exp(-z) ./ (1.0 + exp(-z));
end