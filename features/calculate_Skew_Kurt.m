function [Skew, Kurt] = calculate_Skew_Kurt(signal)
%
% Parameters from:
%
% "Machine learning techniques for the detection of shockable rhythms in
% automated external defibrillators", C. Figuera et al.
%
% INPUT:
% - signal: preprocessed ECG [mV]
%
%
% OUTPUT:
% - Skew, Kurt: Skewness and Kustosis
%
% - Unai Irusta (unai.irusta@ehu.eus) and Iraia Isasi (iraia.isasi@ehu.eus)

Skew = skewness(signal);
Kurt = kurtosis(signal);

end