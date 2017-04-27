function [s, spectrum] = multisine_freq(N, F)
%{
 Generate an odd random phase multisine. The spectrum is N points long
 and the frequencies are grouped by F. In each group, one element is
 randomly selected and removed.
%}

spectrum = ones(1,N/4);

% Randomly remove 1 out of 3 samples
for i = 1:F:fix(N/4/3)*3
    r = fix(F*rand(1));      % random number between 0 and F-1
    spectrum(i+r) = 0;
end

% Add even samples inbetween
spectrum = upsample(spectrum, 2);
spectrum = spectrum(1:end-1);

% Add random phase
spectrum = spectrum.*exp(1i*2*pi*rand(1,length(spectrum)));

% Mirror negative part
spectrum = [conj(spectrum) 0 spectrum];

% ifft
s = fftshift(ifft(ifftshift(spectrum)));

% plots
figure;
subplot(1,2,1)
stem(abs(spectrum))
title('Frequency content')
xlabel('Frequency (bins)')
ylabel('Amplitude')

subplot(1,2,2)
plot(1:length(s),real(s))
title('Temporal signal')
