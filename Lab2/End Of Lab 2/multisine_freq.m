function [s, spectrum] = multisine_freq(N, fs , fmin, fmax, F, rmsVal)
%{
 Generate an odd random phase multisine. The spectrum is N points long
 and the frequencies are grouped by F. In each group, one element is
 randomly selected and removed.
%}
fres = fs/N;

% Randomly remove 1 out of F samples
% for i = 1:F:fix(N/4/3)*3
%     r = fix(F*rand(1));      % random number between 0 and F-1
%     spectrum(i+r) = 0;
% end

bin = round(fmin/fres)+1: round(fmax/fres);
bin = bin(1:2:end);
spectrum = zeros(N,1);

count = 1;
for i=1:F:length(bin)-F
    r = randi([0 F-1]);      % random number between 0 and F-1
    ind(count) = i+r; 
    count = count + 1;
end

bin = bin(ind);

% bin = bin(randi([0 2],1,round(length(bin)/F))+[1:F:length(bin)]);

% Add random phase
spectrum(bin+1) = exp(-1i*2*pi.*rand(1,length(bin)));

s = 2*real(ifft(spectrum));
s = s./rms(s)*rmsVal;

% plots
figure;
subplot(1,2,1)
plot((abs(fft(s))))
title('Frequency content')
xlabel('Frequency (bins)')
ylabel('Amplitude')

subplot(1,2,2)
plot(1:length(s),real(s))
title('Temporal signal')
