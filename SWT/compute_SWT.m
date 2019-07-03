function s = compute_SWT(ecg_signal,fs)
% Function from:
%
% Stationay Wavelet Transform: "The stationary wavelet transform and some statistical applications", G.P Nason et al.
%
% Denoising: "Ideal spatial adaptation by wavelet shrinkage"
%
%
% INPUT:
% - ecg_signal: preprocessed ecg [mV]
% - fs: sampling frequency [sample/s]
%
% OUTPUT:
% - s: struct containing the reconstructed signal and detail coefficients
% from level 3 to 7.
%
% original code by Andoni Elola (andoni.elola@ehu.eus), Unai Irusta and Iraia Isasi (iraia.isasi@ehu.es)


% calculating the SWT in 8 seconds (L_signal) starting from the fourth sec (t_ini)
L_signal = 8*fs; 
t_ini    = 4;

% mother wavelet
wv_name  = 'db4';

% number of levels of decomposition
n_lev = 7;

% calculation of the length of the signal needed to compute SWT
n_L = 2^n_lev;
min1 = round(L_signal/n_L);
L_s = n_L*min1;
s_ecg = ecg_signal(t_ini*fs:(t_ini*fs)+L_s-1);

% initial reconstruction and decomposition coefficients
[coef_rec,coef_dec] = ini_coeff(wv_name,n_lev);

%calculation of the detail and approximation coefficients in all levels
[swa, swd]  = swt(s_ecg,n_lev,coef_dec);

% Denoising threshold
noiselev = median(abs(swd(1,:)))/0.6745;
thr = sqrt(2*log(length(s_ecg)))*noiselev;

% Soft denoising
swd_s = wthresh(swd,'s',thr);

% removing detail coefficients of level 1 and 2 and approximation coefficients
r_comp = [1 2];
for i = 1:length(r_comp)
    swd_s(r_comp(i),:) = zeros(1,size(swd_s,2));
end
swa = zeros(size(swa));

% Reconstructed signal using the detail coefficients from level 3 to level 7
r_ecg_s = iswt(swa,swd_s,coef_rec,n_lev);

d7 = swd_s(7,:);
d6 = swd_s(6,:);
d5 = swd_s(5,:);
d4 = swd_s(4,:);
d3 = swd_s(3,:);

s.D7 = d7;
s.D6 = d6;
s.D5 = d5;
s.D4 = d4;
s.D3 = d3;
s.rec_ecg = r_ecg_s;





