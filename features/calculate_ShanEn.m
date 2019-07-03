function ShanEn = calculate_ShanEn(signal)
%
% Parameter from:
%
% - "A Mathematical Theory of Communication", C. E. Shannon.
%
% INPUT:
% - signal : preprocessed ECG [mV]
%
% OUTPUT:
% 
% - ShanEn: Shannon entropy of the sign of the first difference
%
%- original code by Morteza Zabihi (morteza.zabihi@tuni.fi)

dsig = diff([0 signal]);
Rn = sign(dsig); Rn (Rn == -1) = 0;
words = buffer(Rn, 8, 0);
for i =1: size(words,2)
    words1(i) = bi2de(words(:,i)');
end
m = (2^8);

[Rank, ~, ~] = histcounts(words1,m);
prob = (Rank./sum(Rank)) + eps;
   
ShanEn = -1*sum(prob.*log(prob)); %Shannon  





