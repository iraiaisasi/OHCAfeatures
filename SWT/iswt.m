function a = iswt(swa,swd,coef_rec,n_lev)
% Function from:
%
% Stationay Wavelet Transform: "The stationary wavelet transform and some statistical applications", G.P Nason et al.
%
% INPUT:
% - swa: denoised approximation coefficients
% - swd: denoised detail coefficients
% - coef_rec: reconstruction filter coefficients
% - n_lev: number of levels of the SWT
%
% OUTPUT:
% - a: reconstructed ECG signal using detail and approximation coefficients
%
% original code by Andoni Elola (andoni.elola@ehu.eus), Unai Irusta and Iraia Isasi (iraia.isasi@ehu.es)

a = swa(length(coef_rec)/2,:);
for i=1:length(coef_rec)/2
    rl = coef_rec{end-(i-1)};
    rh = coef_rec{end-n_lev-(i-1)};
    lf = length(rl);
    d  = swd(end-(i-1),:);
    d  = wextend('1D','per',d,lf/2);
    d  = wkeep1(wconv1(d,rh),length(swd(end-(i-1),:)),lf+1);
    d  = [zeros(1,2^(length(coef_rec)/2-i)) d(1:end-2^(length(coef_rec)/2-i))];
    a  = wextend('1D','per',a,lf/2);
    a  = wkeep1(wconv1(a,rl),length(swa(end-(i-1),:)),lf+1);
    a  = [zeros(1,2^(length(coef_rec)/2-i)) a(1:end-2^(length(coef_rec)/2-i))];
    a  = (a+d)/2;
end


