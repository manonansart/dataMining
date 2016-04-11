%% handleNewObservation: function description
function [Pn, thetaN] = handleNewObservation(thetaNMoins1, PnMoins1, zn, yn, action)
    xn = [1 log(1+abs(zn)) -zn*zn*yn]';
    if strcmp(action, 'add')
        kn = PnMoins1*xn*inv(1+xn'*PnMoins1*xn);
    else
        kn = PnMoins1*xn*inv(-1+xn'*PnMoins1*xn);
    end
    Pn = PnMoins1 - kn * xn'*PnMoins1;
    thetaN = thetaNMoins1 + kn*(yn-xn'*thetaNMoins1);
