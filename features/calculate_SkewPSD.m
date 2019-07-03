function SkewPSD = calculate_SkewPSD(signal)

% INPUT:
% - signal: preprocessed ECG [mV]
%
% OUTPUT:
% - SkewPSD: the skewness of the amplitude spectrum of the EKG
%
% original code by Morteza Zabihi (morteza.zabihi@tuni.fi)

[acs, ~] = xcorr(signal,'coeff');

N = [];  [N, ~, ~] = histcounts(abs(fft(acs)), 20);
SkewPSD = skewness(N);



