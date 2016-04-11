function [ti, crit] = geneticAlgo(param, px, py, nbPoints)
    nbPoints = 50;

    t = linspace(0, 1, nbPoints);

    Js = computeCriteria(param, t, [px; py]);

    J = min(Js);
    Jold = Inf;

    while (abs(J - Jold) > 1e-6)
        % croisement barycentrique entre des parents aléatoires, avec un barycentre aléatoire
        t = t(randperm(length(t)));
        for i = 1:2:nbPoints
            alpha = rand;
            t(end + 1) = (1 - alpha) * t(i) + alpha * t(i+1);
        end

        % réduction : on garde ceux avec le meilleur critère
        computeM(param, t);
        Js = computeCriteria(param, t, [px; py]);
        [~, is] = sort(Js);
        t = t(is(1:nbPoints));

        % mise à jour des couts
        Jold = J;
        J = min(Js);
    end

    Js = computeCriteria(param, t, [px; py]);
    [crit, ind] = min(Js);
    ti = t(ind);
end