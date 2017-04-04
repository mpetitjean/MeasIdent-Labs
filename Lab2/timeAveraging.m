function H = timeAveraging(u, y)
% Method 1 for spectral averaging
% Temporal mean then fft

[n, m] = size(u);
meanU = zeros(1, n);
meanY = zeros(1, n);

% Mean over experiments
for i = 1:m
    meanU(i) = mean(u(i,:));
    meanY(i) = mean(y(i,:));
end

% Compute FFTs
fftU = fft(meanU);
fftY = fft(meanY);

H = fftY./fftU;