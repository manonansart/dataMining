function [] = printErrors(name, YEstim, YTrue)
    err = (YTrue - YEstim)'*(YTrue - YEstim);
    relativeErrorVec = (YEstim - YTrue) ./ YTrue;
    relativeError = sum(relativeErrorVec.^2)*100;
    fprintf('For %s: err %.3f - relative %.3f%%\n', name, err, relativeError)
