function [MeanAbs1, StdAbs1] = calculate_MeanAbs1_StdAbs1(signal)

% INPUT:
%
% - signal : preprocessed ECG [mV]
%
% OUTPUT:
%
% - MeanAbs1: the mean of the absolute value of the slopes
% - StdAbs1: the standard deviation of the absolute value of the slopes
%
% implemented by Unai Irusta (unai.irusta@ehu.eus) and Iraia Isasi (iraia.isasi@ehu.eus)

%normalization
ecg_signal = signal/std(signal);

MeanAbs1  = mean(abs(diff(ecg_signal)));
StdAbs1   = std(abs(diff(ecg_signal)));

end