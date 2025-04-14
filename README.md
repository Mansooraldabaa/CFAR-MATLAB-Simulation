This project aims to simulate various CFAR (Constant False Alarm Rate) algorithms used in radar signal processing. The project is implemented in MATLAB and includes simulations of CA-CFAR, OS-CFAR, GO-CFAR, SO-CFAR, DBSCAN-CFAR, and LIN-DBSCAN-CFAR algorithms. The project also includes data generation and the computation of Pd (Probability of Detection) and Pfa (Probability of False Alarm) in multiple environments using SNR (Signal-to-Noise Ratio).

The primary focus is to apply these CFAR algorithms in radar signal environments and test their performance through Monte Carlo simulations. Additionally, it calculates the experimental false alarm probability based on the generated noise signal.

File Descriptions:
1. CA_CFAR1.m
Description: This function implements the Cell-Averaging CFAR (CA-CFAR) algorithm. It computes the threshold for detection based on the average of reference cells.

Inputs:

Pfa: Desired Probability of False Alarm

N: Number of reference cells

nGuardCell: Number of guard cells

signal: The received signal (matrix of trials and range bins)

a: Threshold multiplier

Outputs:

T: Threshold for detection

iCFARwin: Indices of valid CUT (Cell Under Test)

2. OS_CFAR1.m
Description: This function implements the Ordered Statistics CFAR (OS-CFAR) algorithm. It uses the k-th ranked reference cell to calculate the threshold.

Inputs: Same as CA-CFAR, but with the additional k parameter.

Outputs:

T: Threshold for detection

iCFARwin: Indices of valid CUTs

3. GOCA_CFAR1.m
Description: This function implements the Greatest-Of Cell-Averaging CFAR (GOCA-CFAR) algorithm. It computes the threshold based on the greatest of the average reference cells.

Inputs: Same as CA-CFAR.

Outputs:

T: Threshold for detection

iCFARwin: Indices of valid CUTs

4. SOCA_CFAR1.m
Description: This function implements the Smallest-Of Cell-Averaging CFAR (SOCA-CFAR) algorithm. It computes the threshold based on the smallest of the average reference cells.

Inputs: Same as CA-CFAR.

Outputs:

T: Threshold for detection

iCFARwin: Indices of valid CUTs

5. DBSCAN_CFAR1.m
Description: This function implements the DBSCAN CFAR algorithm. It uses DBSCAN clustering to estimate the noise level from the most dominant cluster of reference cells, excluding outliers.

Inputs:

Pfa: Desired probability of false alarm

N: Number of reference cells

nGuardCell: Number of guard cells

signal: Power signal matrix

a: Threshold multiplier

Outputs:

T: Threshold for detection

iCFARwin: Indices of valid CUTs

6. Lin_DBSCAN_CFAR1.m
Description: This function implements the Log-domain DBSCAN CFAR algorithm. It applies a logarithmic transformation to the reference cells and then uses DBSCAN to estimate the noise power.

Inputs: Same as DBSCAN-CFAR.

Outputs:

T: Threshold for detection

iCFARwin: Indices of valid CUTs

7. monteCarloFalseAlarm.m
Description: This function uses Monte Carlo simulations to calculate the experimental false alarm probability based on the generated noise signal.

Inputs:

T: Threshold array

noisePower: Power of the noise used in Monte Carlo simulation

Outputs:

expPfa: Experimental probability of false alarm

8. simRangeData.m
Description: This function generates simulated range data for CFAR simulations, producing a matrix of simulated signal power with shape [nTrial, nWindow].

Inputs:

N: Number of reference cells

noisePower: Power of the noise

nTrial: Number of trials

nWindow: Number of range bins

Outputs:

pwrSignal: Simulated signal matrix with power values

9. main.m
Description: This is the entry point script for the simulation. It initializes the simulation parameters and calls the required CFAR algorithms, simulating radar performance in various SNR environments.

