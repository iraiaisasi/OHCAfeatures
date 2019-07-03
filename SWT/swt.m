function [swa,swd] = swt(signal,n_lev,coef_dec)
% Function from:
%
% Stationay Wavelet Transform: "The stationary wavelet transform and some statistical applications", G.P Nason et al.
%
% INPUT:
% - signal: preprocessed ecg
% - n_lev: number of levels of the SWT
% - coef_dec: decomposition filter coefficients
%
% OUTPUT:
% - swa and swd: approximation and detail coefficients at 7 levels
%
% original code by Andoni Elola (andoni.elola@ehu.eus), Unai Irusta and Iraia Isasi (iraia.isasi@ehu.es)

s = length(signal);
for k = 1:n_lev
    
    lo = coef_dec{k+n_lev};
    hi = coef_dec{k};
    % Extension.
    lf = length(lo);
    signal  = wextend('1D','per',signal,lf/2);
    
    % Detail coefficient at 7 levels
    swd(k,:) = wkeep1(wconv1(signal,hi),s,lf+1);
    
    % Aproximation coefficients at 7 levels
    swa(k,:) = wkeep1(wconv1(signal,lo),s,lf+1);
    
    signal = swa(k,:);
    
end



