function H = averagingAuto2(u, y)

[n, m] = size(u);
nfft = 2^nextpow2(n);

fftU = fft(u,nfft);
fftY = fft(y,nfft);

% Compute cross powers
for i = 1:n
    Gyy(i,:) = fftY(i,:).*conj(fftY(i,:));
    Guy(i,:) = fftU(i,:).*conj(fftY(i,:)); 
end

% Average over experiments
for i = 1:m
    Gyy(i) = mean(Gyy(:,i));
    Guy(i) = mean(Guy(:,i));
end

H = Gyy./Guy;