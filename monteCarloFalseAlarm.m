function [expPfa] = monteCarloFalseAlarm(T, noisePower)
% monteCarloFalseAlarm - Perform Monte Carlo importance sampling for false alarm probability
%
% INPUTS:
% T - The threshold array
% noisePower - The power of noise used in Monte Carlo simulation
%
% OUTPUTS:
% expPfa - The experimental probability of false alarm based on Monte Carlo simulation

nRangeGate = length(T);
nCFAR = size(T, 2);
monteCarloPwr = noisePower * 20;

% Monte Carlo power distribution
pwrMonteCarlo = gamrnd(monteCarloPwr, 1, nRangeGate, nCFAR);

% Calculate false alarms
weight = monteCarloPwr / noisePower * exp(-(1 / noisePower - 1 / monteCarloPwr) * pwrMonteCarlo);
iFalseAlarm = T < pwrMonteCarlo;
falseAlarm = zeros(size(weight));
falseAlarm(iFalseAlarm) = weight(iFalseAlarm);

expPfa = sum(falseAlarm) / nRangeGate;
end
