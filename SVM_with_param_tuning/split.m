function [xapp, yapp, xtest, ytest] = split(x, y, ratio)
%  S. CANU - scanu@insa-rouen.fr

classcode = unique(y);

xapp = [];
yapp= [];
xtest = [];
ytest = [];

for numclass = 1:length(classcode)
	indclass = find(y==classcode(numclass));
	Ni  = length(indclass);
	aux = randperm(Ni);
	auxapp = aux(1: ceil(ratio*Ni));
	auxtest = aux(ceil(ratio*Ni)+1:end);
	xapp = [xapp; x(indclass(auxapp),:)];
	yapp = [yapp; y(indclass(auxapp))];

	xtest = [xtest; x(indclass(auxtest),:)];
	ytest = [ytest; y(indclass(auxtest))];
end
