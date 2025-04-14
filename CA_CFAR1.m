function [T, iCFARwin] = CA_CFAR1(Pfa, N, nGuardCell, signal, a)
% CA_CFAR1 - Cell-Averaging CFAR
% Computes the threshold T for a signal using the CA-CFAR algorithm.
%
% INPUTS:
% Pfa - Desired Probability of False Alarm
% N - Total number of reference cells (even number)
% nGuardCell - Number of guard cells on each side of CUT
% signal - Power signal matrix (rows: trials, columns: cells)
% a - Threshold multiplier (usually N * (Pfa^(-1/N) - 1))
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
    noise = mean(ref);
    T(idx) = a * noise;
end

iCFARwin = find(T > 0);
end
