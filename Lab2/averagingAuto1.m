function H = averagingAuto1(u, y)

[n, m] = size(u);
nfft = 2^nextpow2(n);

fftU = fft(u,nfft);
fftY = fft(y,nfft);

% Compute cross powers
for i = 1:n
    Gyu(i,:) = fftY(i,:).*conj(fftU(i,:));
    Guu(i,:) = fftU(i,:).*conj(fftU(i,:)); 
end

% Average over experiments
for i = 1:m
    Gyu(i) = mean(Gyu(:,i));
    Guu(i) = mean(Guu(:,i));
end

H = Gyu./Guu;