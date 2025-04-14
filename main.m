% ============================== %
% Pd vs. SNR for Multiple CFARs %
% ============================== %

clear; clc; close all;

% Parameters
Pfa = 1e-4;
nTrial = 1e5;
SNRdB_set = 2:2.5:30;
SNR_set = 10.^(SNRdB_set / 10);

N = 64;
nGuardCell = 4;
k_OS = round(0.7 * N);
noisePwr = 1;

iMasking = [9 25 38 49 57];
iCUT = N/2 + nGuardCell + 1;
iTarget = [iMasking iCUT];

nCFAR = 6;
Pd = zeros(length(SNR_set), nCFAR);

for iSNR = 1:length(SNR_set)
    SNR = SNR_set(iSNR);
    targetPwr = noisePwr * SNR;

    signal = ones(nTrial, N + 2 * nGuardCell + 1) * noisePwr;

    for i = 1:length(iMasking)
        signal(:, iMasking(i)) = krnd(targetPwr + noisePwr, targetPwr + noisePwr, nTrial, 1);
    end

    signal(:, iCUT) = krnd(targetPwr + noisePwr, targetPwr + noisePwr, nTrial, 1);

    a = N * (Pfa^(-1/N) - 1);

    threshold_ca = CA_CFAR1(Pfa, N, nGuardCell, signal, a);
    threshold_os = OS_CFAR1(Pfa, N, k_OS, nGuardCell, signal, a);
    threshold_go = GOCA_CFAR1(Pfa, N, nGuardCell, signal, a);
    threshold_so = SOCA_CFAR1(Pfa, N, nGuardCell, signal, a);
    threshold_db = DBSCAN_CFAR1(Pfa, N, nGuardCell, signal, a);
    threshold_lin = Lin_DBSCAN_CFAR1(Pfa, N, nGuardCell, signal, a);

    Pd(iSNR,1) = sum(signal(:,iCUT) > threshold_ca) / nTrial;
    Pd(iSNR,2) = sum(signal(:,iCUT) > threshold_os) / nTrial;
    Pd(iSNR,3) = sum(signal(:,iCUT) > threshold_go) / nTrial;
    Pd(iSNR,4) = sum(signal(:,iCUT) > threshold_so) / nTrial;
    Pd(iSNR,5) = sum(signal(:,iCUT) > threshold_db) / nTrial;
    Pd(iSNR,6) = sum(signal(:,iCUT) > threshold_lin) / nTrial;
end

figure;
plot(SNRdB_set, Pd(:,1), 'k', 'LineWidth', 1.5); hold on;
plot(SNRdB_set, Pd(:,2), 'r', 'LineWidth', 1.5);
plot(SNRdB_set, Pd(:,3), 'b', 'LineWidth', 1.5);
plot(SNRdB_set, Pd(:,4), 'g', 'LineWidth', 1.5);
plot(SNRdB_set, Pd(:,5), '--m', 'LineWidth', 1.5);
plot(SNRdB_set, Pd(:,6), '--c', 'LineWidth', 1.5);

xlabel('Signal to Noise Ratio (dB)');
ylabel('Probability of Detection');

legend('CA-CFAR','OS-CFAR','GOCA-CFAR','SOCA-CFAR','DBSCAN-CFAR','LIN-DBSCAN-CFAR');
grid on;
