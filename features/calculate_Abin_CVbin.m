function [Abin, CVbin] = calculate_Abin_CVbin(signal,fs)

%Parameters from:
%
% 1) "Shock advisory tool: detection of life-threatening cardiac
%    arrhyrhmias and shock success prediction by means of a common
%    parameter set"
%    I. Jekova, Biomed. Sig. Proc. Control, 2:25-33, 2007
% 
% 2) "Ventricular Fibrillation and Tachycardia Classification uning a
%    Machine Learning Approach", 
%    Q. Li, C. Rajagopalan and G.D. Clifford,
%    IEEE Trans. Biomed. Eng. (In Press)
%
% INPUT:
% - signal: preprocessed ECG [mV]
% - fs: sample frequency [sample/s]
%
% OUTPUT
% - Area parameter: Abin and Covariance parameter: CVbin
%
% by Felipe Alonso-Atienza (felipe.alonso@urjc.es) and
%    Eduardo Morgado (eduardo.morgado@urjc.es)
% Available:
% " Machine learning techniques for the detection of shockable rhythms in automated external defibrillators"
%https://github.com/FelipeURJC/ohca-vs-public-dbs/blob/master/ecg%20parameters%20computation/parameters/calculate_CM_JEKOVA.m

%--- Binary signal
wL = length(signal)/fs;

n = length(signal);
s = zeros(1,n);

xi = signal - mean(signal);

xmax = max(xi); 
xmin = min(xi);

Pc = length(find( 0 < xi < 0.1*xmax ) );
Nc = length(find( 0.1*xmin < xi < 0 ) );

if (Pc+Nc)<0.4*n
    th = 0;
elseif Pc < Nc
    th = 0.2*xmax;
else
    th = 0.2*xmin;
end

s(xi>=th) = 1;

% Convariance calculation
CVbin = var(s);

% Area calculation
N = sum(s);
Abin = max(N,fs*wL-N);





