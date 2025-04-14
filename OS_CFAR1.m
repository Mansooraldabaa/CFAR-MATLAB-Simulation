function [T, iCFARwin] = OS_CFAR1(Pfa, N, k, nGuardCell, signal, a)
% OS_CFAR1 - Ordered Statistics CFAR
% Uses the k-th smallest reference cell to compute the threshold.
%
% INPUTS:
% Pfa - Desired Probability of False Alarm
% N - Number of reference cells
% k - k-th rank to use
% nGuardCell - Number of guard cells on each side
% signal - Power signal (matrix)
% a - Threshold multiplier
%
% OUTPUTS:
% T - Threshold values
% iCFARwin - Valid CUT indices

nTrial = size(signal,1);
iCUT = N/2 + nGuardCell + 1;
T = zeros(nTrial,1);

for idx = 1:nTrial
    ref = [signal(idx, iCUT - nGuardCell - N/2 : iCUT - nGuardCell - 1), ...
           signal(idx, iCUT + nGuardCell + 1 : iCUT + nGuardCell + N/2)];
    sorted_ref = sort(ref);
    T(idx) = a * sorted_ref(k);
end

iCFARwin = find(T > 0);
end
