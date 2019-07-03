function SampEn = calculate_SampEn(signal,m,r)
%
% Feature from:
%
% " Sample entropy anallysis of neonatal heart rate variability." Lake.D.E
%
% INPUT:
% - signal: preprocessed ecg[mV]
% - m: maximum template length
% - r:  matching tolerance 
% OUTPUT:
% - SampEn: Sample Entropy.
%
% - by Rebeca Goya Esteban and Oscar Barquero Perez
% Available:
% " Machine learning techniques for the detection of shockable rhythms in automated external defibrillators"
% https://github.com/FelipeURJC/ohca-vs-public-dbs/blob/master/ecg%20parameters%20computation/parameters/calculate_SampEn.m


%parameters
sd = std(signal);
r  = r*sd;

N=length(signal);
X=signal(:);

B_m_i = zeros(1,N-m);
A_m_i = zeros(1,N-m);

% creation of a matrix containing all the vectors to be compared with each
% other
for n=1:2
   M=zeros(N-m,m+n-1);
   [f,~]= size(M);
   for i=1:f
       M(i,:)=X(i:i+m+n-2);
   end
   %correlation measure.

   for i=1:f
       %creation of a matrix whose rows contain the vector to be compared
       %with the rest of the vectors, replicates the matrix given with
       %dimensions fx1
       Mi=repmat(M(i,:),f,1);
       % for each row of the matrix the maximum between the columns of the
       % matrix of differences
       dist = max(abs(Mi-M),[],2);
       %eliminate autocomparisons
       dist(i,:)=[];
       if n ==1
           B_m_i(i)=length(find(dist<=r))/(N-m-1);
       else
           A_m_i(i)=length(find(dist<=r))/(N-m-1);
       end

   end
end
B_m = mean(B_m_i);
A_m = mean(A_m_i);
SampEn = log(B_m) - log(A_m);

