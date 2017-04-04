function H = dftAveraging(u, y)
% Method 3 for spectral averaging
% fft then mean of H

[n, m] = size(u);
nfft = 2^nextpow2(n);

fftU = fft(u,nfft);
fftY = fft(y,nfft);

% Mean over experiments
for i = 1:m
    Htest(:,i) = fftY(:,i)./fftU(:,i); 
end

for i = 1:n
    H(i) = mean(Htest(i,:));
end
