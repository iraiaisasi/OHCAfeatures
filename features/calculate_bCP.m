function bCP = calculate_bCP(signal,fs)

% Parameter from:
%
% "A high-temporal resolution algorithm to discriminate shockable
% from nonshockable rhythms in adults and children", Irusta U. et al.
%
% INPUT:
% - signal: preprocessed ecg [mV]
% - fs: sampling frequency [sample/s]
%
% OUTPUT:
% - slope domain feature, bCP
%
% original code by Unai Irusta and Unai Ayala (unai.irusta@ehu.es)

signal = signal(:);
L_w    = 2*fs;   %%% window size

valC   = 0.0150;
%%% Slope domain feature
slope = diff(signal);
slope = slope.^2; slope(end+1)=slope(end);

n_w = floor(length(slope)/L_w);
for i=1:n_w
    slp_w = slope((i-1)*L_w+1:i*L_w);
    bCP(i) = sum(slp_w < valC*max(slp_w))/L_w;
end
bCP = min(bCP);

