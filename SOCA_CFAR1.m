function [T, iCFARwin] = SOCA_CFAR1(Pfa, N, nGuardCell, signal, a)
% SOCA_CFAR1 - Smallest-Of Cell-Averaging CFAR
%
% Uses the smaller of the two reference window means to calculate threshold.
%
% INPUTS: (same as GOCA_CFAR1)
% OUTPUTS: (same as GOCA_CFAR1)

nTrial = size(signal,1);
iCUT = N/2 + nGuardCell + 1;
T = zeros(nTrial,1);

for idx = 1:nTrial
    lag = signal(idx, iCUT - nGuardCell - N/2 : iCUT - nGuardCell - 1);
    lead = signal(idx, iCUT + nGuardCell + 1 : iCUT + nGuardCell + N/2);
    noise = min(mean(lead), mean(lag));
    T(idx) = a * noise;
end

iCFARwin = find(T > 0);
end
