function H = frfAveraging(u, y)
% Method 3 for spectral averaging
% fft then mean of H

fftU = fft(u);
fftY = fft(y);

% Mean over experiments
H = fftY./fftU;
H = mean(H,2);