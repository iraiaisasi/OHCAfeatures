function [x1,x2] = calculate_Xj(signal,fs,prC, aMs)

% Slope and Frequency domain Features, from
% "A Reliable Method for Rhythm Analysis During Cardiopulmonary 
% Resuscitation", Ayala U. et al.
%
% INPUT:
% - signal: preproccessed ECG [mV]
% - fs: sampling frequency [sample/s]
% - amS: averaging time in ms
% - prC: prctile
% OUTPUT:
% - x1, x2: slope domain features 
%
% original code by Unai Ayala and Unai Irusta (unai.irusta@ehu.es)


signal = signal(:);

% Averaging and slope calculation
bP=ones(1,round(aMs*fs/1000));

%%% Square root of the slope
slope = diff(signal); slope(end+1)=slope(end);
slope = slope.^2;

%%% Averaging of the slope (removing transient)
tr_sec  = 2; %%% 2-second transient
slope   = [ones(1,tr_sec*fs)*slope(1) slope(:)' ones(1,tr_sec*fs)*slope(end)]; 
slope   = filter(bP,1,slope);
slope   = slope(tr_sec*fs+1:end-tr_sec*fs);

x1 = prctile(slope,prC)/max(slope);

minAmp     = 0.1*max(slope);  % minpeakheight
minDist    = fs/10; % minpeakdistance
[pks,~]= findpeaks(slope,'MINPEAKHEIGHT',minAmp,'MINPEAKDISTANCE',minDist);
x2         = length(pks);