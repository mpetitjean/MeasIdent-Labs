function H = dftAveraging(u, y)
% Method 2 for spectral averaging
% fft then mean

[n, m] = size(u);

fftU = fft(u);
fftY = fft(y);

% Mean over experiments
meanfftU = mean(fftU,2);
meanfftY = mean(fftY,2);

H = meanfftY./meanfftU;

