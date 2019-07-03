function X = computeFeatures(s,fs)

% INPUT:
%
% - s :struct with the reconstructed ECG signal s.rec_ecg and detail
% coefficients s.Dx
% - fs: sampling frequency [sample/s]
%
% OUTPUT:
%
% - X: array with feature values corresponding to each ECG segments
%
% implemented by  Iraia Isasi (iraia.isasi@ehu.eus) and Unai Irusta (unai.irusta@ehu.eus)

% VF-filter Leak
X(1)   = calculate_VFLEAK(s.rec_ecg);


% Sample Entropy
m = 2;
r = 0.2;
X(2)     = calculate_SampEn(s.rec_ecg,m,r);
X(3)     = calculate_SampEn(s.D7,m,r);
X(4)     = calculate_SampEn(s.D6,m,r);
X(5)     = calculate_SampEn(s.D5,m,r);
X(6)     = calculate_SampEn(s.D4,m,r);
X(7)     = calculate_SampEn(s.D3,m,r);


% x3, x4, x5
[X(8) , X(9), X(10)] = calculate_Xi(s.rec_ecg,fs);


% x1, x2
prC_Xj = 30; 
aMs_Xj = 100;
[X(11), X(12)]       = calculate_Xj(s.rec_ecg, fs , prC_Xj, aMs_Xj);


% bCP
X(13) = calculate_bCP(s.rec_ecg, fs);


% Interquartile ranges
X(14) = calculate_IQR(s.rec_ecg);
X(15) = calculate_IQR(s.D7);
X(16) = calculate_IQR(s.D6);
X(17) = calculate_IQR(s.D5);
X(18) = calculate_IQR(s.D4);
X(19) = calculate_IQR(s.D3);


% Skewness, Kurtosis
[X(20), X(21)] = calculate_Skew_Kurt(s.rec_ecg);
[X(22), X(23)] = calculate_Skew_Kurt(s.D7);
[X(24), X(25)] = calculate_Skew_Kurt(s.D6);
[X(26), X(27)] = calculate_Skew_Kurt(s.D5);
[X(28), X(29)] = calculate_Skew_Kurt(s.D4);
[X(30), X(31)] = calculate_Skew_Kurt(s.D3);


% mean and standard deviation of the absolute value of the amplitudes and slopes
[X(32), X(33)] = calculate_MeanAbs_StdAbs(s.rec_ecg); 
[X(34), X(35)] = calculate_MeanAbs1_StdAbs1(s.rec_ecg);

[X(36), X(37)] = calculate_MeanAbs_StdAbs(s.D7); 
[X(38), X(39)] = calculate_MeanAbs1_StdAbs1(s.D7); 

[X(40), X(41)] = calculate_MeanAbs_StdAbs(s.D6); 
[X(42), X(43)] = calculate_MeanAbs1_StdAbs1(s.D6); 

[X(44), X(45)] = calculate_MeanAbs_StdAbs(s.D5); 
[X(46), X(47)] = calculate_MeanAbs1_StdAbs1(s.D5);

[X(48), X(49)] = calculate_MeanAbs_StdAbs(s.D4); 
[X(50), X(51)] = calculate_MeanAbs1_StdAbs1(s.D4); 

[X(52), X(53)] = calculate_MeanAbs_StdAbs(s.D3); 
[X(54), X(55)] = calculate_MeanAbs1_StdAbs1(s.D3); 


% Mean and standard deviation of the heart rate
[X(56), X(57)] = calculate_MeanRate_StdRate(s.rec_ecg,fs);


% Abin,CVbin
[X(58), X(59)] = calculate_Abin_CVbin(s.rec_ecg,fs);


% Energy content of the 4-8 Hz frequency band
X(60) = calculate_Enrg(s.rec_ecg,fs);


% The skewness of the amplitude spectrum of the EKG
X(61) = calculate_SkewPSD(s.rec_ecg);


% Shannon entropy of the sign of the first difference
X(62) = calculate_ShanEn(s.rec_ecg);
X(63) = calculate_ShanEn(s.D3);
X(64) = calculate_ShanEn(s.D4);
X(65) = calculate_ShanEn(s.D5);
X(66) = calculate_ShanEn(s.D6);
X(67) = calculate_ShanEn(s.D7);


% Hjorth mobility and complexity
[X(68),X(69)] = calculate_Hmb_Hcmp(s.D3);
[X(70),X(71)] = calculate_Hmb_Hcmp(s.D4);
[X(72),X(73)] = calculate_Hmb_Hcmp(s.D5);
[X(74),X(75)] = calculate_Hmb_Hcmp(s.D6);
[X(76),X(77)] = calculate_Hmb_Hcmp(s.D7);
[X(78),X(79)] = calculate_Hmb_Hcmp(s.rec_ecg);

end