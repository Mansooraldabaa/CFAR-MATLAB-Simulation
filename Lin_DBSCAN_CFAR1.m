function [T, iCFARwin] = Lin_DBSCAN_CFAR1(Pfa, N, nGuardCell, signal, a)
% Lin_DBSCAN_CFAR1 - Log-domain DBSCAN CFAR
% This method uses DBSCAN after applying a logarithmic transform to reduce
% dynamic range, and estimates noise in log domain then converts back.
%
% INPUTS:
% Pfa - Desired probability of false alarm
% N - Number of reference cells
% nGuardCell - Number of guard cells on each side
% signal - Power signal (matrix)
% a - Threshold multiplier
%
% OUTPUTS:
% T - Threshold values
% iCFARwin - Valid CUT indices

nTrial = size(signal, 1);
iCUT = N/2 + nGuardCell + 1;
T = zeros(nTrial, 1);

eps = 2;
MinPts = 4;

for idx = 1:nTrial
    refCells = [signal(idx, iCUT - nGuardCell - N/2 : iCUT - nGuardCell - 1), ...
                signal(idx, iCUT + nGuardCell + 1 : iCUT + nGuardCell + N/2)];
    logRef = log(refCells + eps);
    labels = dbscan(logRef(:), eps, MinPts);

    valid = labels ~= -1;
    if any(valid)
        uniqueLabels = unique(labels(valid));
        labelCounts = histc(labels, uniqueLabels);
        [~, maxIdx] = max(labelCounts);
        cluster = logRef(labels == uniqueLabels(maxIdx));
        noisePower = exp(mean(cluster));
    else
        noisePower = exp(mean(logRef));
    end

    T(idx) = a * noisePower;
end

iCFARwin = find(T > 0);
end
