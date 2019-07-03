function main
% Function to compute all features from ECG (e_ecg.mat) after RLS filtering
% It computes features based on the SWT for the full interval 8-sec
% analysis window of the filtered ECG
%
% Implemented by Iraia Isasi(iraia.isasi@ehu.eus) and Unai Irusta (unai.irusta@ehu.eus) 

% adding paths corresponding to feature calculation and SWT functions
addpath(genpath('features'))
addpath(genpath('SWT'))

fs = 250; % sample frecuency [sample/s]

load e_ecg % 15-sec ECG segment obtained after RLS filtering

% calculation of the reconstructed signal s.rec_ecg and the detail
% coefficients s.DX
s = compute_SWT(e_ecg,fs);

% Array of features corresponding to a single ECG segment
X = computeFeatures(s,fs);

save 'X' 'X'






