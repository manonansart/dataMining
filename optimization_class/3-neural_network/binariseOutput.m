% [Ybinary] = binariseOutput(Y)
% Input:
% - Y: N by 1 vector of labels, wich are numbers between 1 and the number of classes (nbClasses)
% Output:
% - Ybinary: N by nbClasses matrix such that Ybinary(i, j) = 1 if the example i is of classe number j, 0 otherwise
function [Ybinary] = binariseOutput(Y)
    Yunique = unique(Y);
    Ybinary = zeros(length(Y), length(Yunique));
    for i = 1:length(Yunique)
        Ybinary(find(Y == Yunique(i)), i) = 1;
    end
end
