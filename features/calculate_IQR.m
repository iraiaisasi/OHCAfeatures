function IQR = calculate_IQR(signal)

% Parameter from:
%
% " ECG based classification of resuscitation cardiac rhythms for retrospective data analysis", A.B. Rad. et al.
%
% INPUT:
% - signal: preprocessed ECG [mV]
%
% OUTPUT:
% - IQR: interquartile ranges
%
% -Implemented by Unai Irusta (unai.irusta@ehu.eus) and Iraia Isasi (iraia.isasi@ehu.eus)

IQR = diff(prctile(signal,[25 75]));

end



