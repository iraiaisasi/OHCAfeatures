function [MeanRate, StdRate] = calculate_MeanRate_StdRate(signal,fs)

% parameter from:
%
% - "ECG-based pulse detection during cardiac arrest using random forest classifier", A. Elola et al.
% - "Quantitative investigation of QRS detection rules using the MIT/BIH arrnytmia database", P. S. Hamilton et al.
%
% INPUT:
% - signal : preprocessed ECG [mV]
% - fs: Sampling frequency [sample/s] 
%
% OUTPUT:
% 
% - The mean and the standard deviation of the heart rate: MeanRate and
% StdRate
%
% implemented by Unai irusta (unai.irusta@ehu.eus) and Andoni Elola (andoni.elola@ehu.eus)

bP = ones(1,round(125*fs/1000));

ecg_signal = signal/std(signal);

d1 = diff(ecg_signal);

d2 = d1.^2;
d_ecg = filter(bP,1,d2);

p_prom = 0.5*prctile(d_ecg,97.5);
[~, pks,~, ~] = findpeaks(d_ecg, 'MinPeakProminence', p_prom, 'MinPeakDistance', round(0.300*fs), 'MinPeakWidth', round(0.05*fs));

%%% Patch for very fast cases
if mean(diff(pks)/fs) < 0.75
    [~, pks2, ~, ~] = findpeaks(d_ecg, 'MinPeakProminence', p_prom, 'MinPeakDistance', round(0.240*fs), 'MinPeakWidth', round(0.05*fs));
    CV1 = std(diff(pks))/mean(diff(pks));
    CV2 = std(diff(pks2))/mean(diff(pks2));
    if CV2 < CV1
        pks = pks2;
    end
end

pks = pks - round(length(bP)/2);
if length(pks) > 2
    MeanRate = mean(diff(pks)/fs); %Mean rate
    StdRate  = std(diff(pks)/fs); %Std rat
else
    MeanRate  = -2; %Mean rate
    StdRate   = -2; %Std rat
end

end