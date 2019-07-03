function [MeanAbs,StdAbs] = calculate_MeanAbs_StdAbs(signal)
% INPUT:
%
% - signal : preprocessed ECG [mV]
%
% OUTPUT:
%
% - MeanAbs: the mean of the absolute value of the amplitudes
% - StdAbs: the standard deviation of the absolute value of the amplitudes
%
% implemented by Unai Irusta (unai.irusta@ehu.eus) and Iraia Isasi (iraia.isasi@ehu.eus)

%normalization
ecg_signal = signal/std(signal);

MeanAbs = mean(abs(ecg_signal));
StdAbs = std(abs(ecg_signal));

end