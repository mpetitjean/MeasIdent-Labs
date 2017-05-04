function H = averagingAuto1(u, y)

fftU = fft(u);
fftY = fft(y);

% Compute cross powers
Gyu = fftY.*conj(fftU);
Guu = fftU.*conj(fftU); 


% Average over experiments
Gyu = mean(Gyu,2);
Guu = mean(Guu,2);

H = Gyu./Guu;