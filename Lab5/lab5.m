clear, close all;

%% Load variables
load('IdentificationData_Lab2.mat');

um = mean(xData,2);
ym = mean(yData,2);

Um = fft(um);
Ym = fft(ym);

%% Estimate the frequency response
N = 1024;
F = 114;
harm = [15:128].';
Gm = Ym(harm+1)./Um(harm+1);
freq = harm*fs/N;
figure;
subplot(2,1,1)
plot(freq,db(Gm))
xlabel('Frequency');
ylabel('Magnitude');
subplot(2,1,2)
plot(freq,unwrap(angle(Gm)))
xlabel('Frequency');
ylabel('Phase');

%% Matrix conditionning
