function [Hmb,Hcmp] = calculate_Hmb_Hcmp(signal)

% Parameters from:
%
% "Monitoring a skipped heartbeat: a real-time premature ventricular 
%contraction (PVC) monitor", Gonzalez L. et al.
%
% INPUT:
% - signal: preprocessed ecg [mV]
%
% OUTPUT:
% - Hmb, Hcmp: Hjorth mobility and complexity measures
%
% - original code by Morteza Zabihi (morteza.zabihi@tuni.fi)

d0 = var(signal);  d1 = sqrt(var(diff(signal))/d0); d2 = sqrt(var(diff(diff(signal)))/d0)/d1;
Hmb = d1; 
Hcmp = d2; 

end


