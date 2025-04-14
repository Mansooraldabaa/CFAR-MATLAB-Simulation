function [T, iCFARwin] = DBSCAN_CFAR1(Pfa, N, nGuardCell, signal, a)
% DBSCAN_CFAR1 - Density-Based Spatial Clustering CFAR
% This method uses DBSCAN clustering to estimate the noise power level
% from the most dominant cluster of reference cells, excluding outliers.
%
% INPUTS:
% Pfa - Desired probability of false alarm
% N - Total number of reference cells
% nGuardCell - Number of guard cells on each side of the CUT
% signal - Power signal (matrix of trials x range bins)
% a - Threshold multiplier (e.g., a = N * (Pfa^(-1/N) - 1))
%
% OUTPUTS:
% T - Threshold vector for each trial
% iCFARwin - Valid indices for CUT

nTrial = size(signal, 1);
iCUT = N/2 + nGuardCell + 1;
T = zeros(nTrial, 1);

eps = 2;
MinPts = 4;

for idx = 1:nTrial
    refCells = [signal(idx, iCUT - nGuardCell - N/2 : iCUT - nGuardCell - 1), ...
                signal(idx, iCUT + nGuardCell + 1 : iCUT + nGuardCell + N/2)];
    refCells = refCells(:);
    labels = dbscan(refCells, eps, MinPts);

    valid = labels ~= -1;
    if any(valid)
        uniqueLabels = unique(labels(valid));
        labelCounts = histc(labels, uniqueLabels);
        [~, maxIdx] = max(labelCounts);
        cluster = refCells(labels == uniqueLabels(maxIdx));
        noisePower = mean(cluster);
    else
        noisePower = mean(refCells);
    end

    T(idx) = a * noisePower;
end

iCFARwin = find(T > 0);
end
