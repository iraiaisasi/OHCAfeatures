function [coef_rec,coef_dec] = ini_coeff(wv_name,n_lev)
% Function from:
%
% Stationay Wavelet Transform: "The stationary wavelet transform and some statistical applications", G.P Nason et al.
%
% INPUT:
% - wv_name: type of mother wavelet
% - n_lev: number of levels of the SWT
%
% OUTPUT:
% - coeff_rec and coef_dec: reconstruction and decomposition filter coefficients
% needed for the calculation of approximation and detail coefficients at 7 levels
%
% original code by Andoni Elola (andoni.elola@ehu.eus), Unai Irusta and Iraia Isasi (iraia.isasi@ehu.es)

[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters(wv_name);% Lehenengo mailako koefizienteak lortu (bereraikitzeko koefizienteak)

% Detail
coef_rec{1} = Hi_R;
coef_dec{1} = Hi_D;
for i=1:n_lev-1
    coef_rec{i+1} = dyadup(coef_rec{i},0,1); % At each level filters are upsampled by a factor of 2
    coef_dec{i+1} = dyadup(coef_dec{i},0,1);
end

% Approximation
coef_rec{n_lev+1} = Lo_R;
coef_dec{n_lev+1} = Lo_D;
for i=1:n_lev-1
    coef_rec{n_lev+1+i} = dyadup(coef_rec{n_lev+i},0,1);% At each level filters are upsampled by a factor of 2
    coef_dec{n_lev+1+i} = dyadup(coef_dec{n_lev+i},0,1);
end



