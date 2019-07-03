function Enrg = calculate_Enrg(signal,fs)

% INPUT:
% - signal: preprocessed ECG [mV]
% - fs: sampling frequency [sample/s]
%
% OUTPUT:
% - Enrg: the relative energy content of the signal in the 4-8 Hz frequency
% band
%
% original code by Morteza Zabihi (morteza.zabihi@tuni.fi)

rng(0);

[pxx,f] = pwelch(signal, [], [], 1024, fs);

ind2 = 4<=f & f<8;

ind7 = 0.05<=f & f<125;

Enrg = sum(pxx(ind2))/ sum(pxx(ind7));

