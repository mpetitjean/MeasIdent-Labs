function H = timeAveraging(u, y)
% Method 1 for spectral averaging
% Temporal mean then fft

[n, m] = size(u);

% Mean over experiments

meanU = mean(u,2);
meanY = mean(y,2);

% Compute FFTs
fftU = fft(meanU);
fftY = fft(meanY);

H = fftY./fftU;