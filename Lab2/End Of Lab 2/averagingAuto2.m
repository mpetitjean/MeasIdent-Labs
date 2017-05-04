function H = averagingAuto2(u, y)

fftU = fft(u);
fftY = fft(y);

% Compute cross powers
Gyy = fftY.*conj(fftY);
Guy = fftU.*conj(fftY); 


% Average over experiments
Gyy = mean(Gyy,2);
Guy = mean(Guy,2);

H = Gyy./Guy;