function VFleak = calculate_VFLEAK(signal)

% VF LEAK parameter from:
%
% 1) "Computer detection of ventricular fibrillation"
%    S. Kuo, D. Dillman, Computers in Cardiology, 1978, 2747-2750.
%
% 2) "Reliability of old and new ventricular fibrillation detection 
%    algorithms for automated external defibrillators"
%    A. Amann, R. Tratning, and K. Unterkofler,
%    Biomed Eng Online, 4(60), 2005.
%
% INPUT:
% - signal: preprocessed ECG [mv]
%
% OUTPUT
% - vfleak parameter
%
% by Felipe Alonso-Atienza (felipe.alonso@urjc.es)
% www.tsc.urjc.es/~felipe.alonso
% Available:
% " Machine learning techniques for the detection of shockable rhythms in automated external defibrillators"
% https://github.com/FelipeURJC/ohca-vs-public-dbs/blob/master/ecg%20parameters%20computation/parameters/calculate_VFLEAK.m

num = sum (abs(signal(2:end)));
den = sum (abs( signal(2:end) - signal(1:end-1) ));

N = floor ( ( pi*(num)/(den) ) + 1/2 );

num = sum( abs( signal(N+1:end) + signal(1:end-N)) );
den = sum( abs(signal(N+1:end)) + abs(signal(1:end-N)));

VFleak = num/den;


