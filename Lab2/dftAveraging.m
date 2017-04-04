function H = dftAveraging(u, y)
% Method 2 for spectral averaging
% fft then mean

[n, m] = size(u);
nfft = 2^nextpow2(n);

fftU = fft(u,nfft);
fftY = fft(y,nfft);
meanfftU = zeros(1, nfft);
meanfftY = zeros(1, nfft);

% Mean over experiments
for i = 1:m
    meanfftU(i) = mean(fftU(i,:));
    meanfftY(i) = mean(fftY(i,:));
end

H = meanfftY./meanfftU;
