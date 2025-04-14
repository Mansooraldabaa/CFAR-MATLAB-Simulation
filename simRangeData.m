function pwrSignal = simRangeData(N, noisePower, nTrial, nWindow)
% simRangeData - Generate simulated range data for CFAR simulation
%
% INPUTS:
% N - Number of reference cells
% noisePower - The power of the noise
% nTrial - Number of trials
% nWindow - Number of range bins (including guard cells and CUT)
%
% OUTPUT:
% pwrSignal - Simulated signal matrix with shape [nTrial, nWindow]

pwrSignal = gamrnd(noisePower, 1, nTrial, nWindow);
end
