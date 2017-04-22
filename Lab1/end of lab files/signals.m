clear;
close all;

% The multisine should excite the frequencies from 1
% Hz to 500 Hz with a frequency resolution of 1 Hz. Normalize the rms value
% of the input signal to 1 mV. Measure the system at a sample frequency of
% 8 kHz.
% [s1, crest1] = multisine(4096, 1, 500, 1, 'schroder', 0);
% s1 = s1/rms(s1);
% csvwrite('s1.csv',s1');
% load('meas1')
% plot(db(fft(y(:,10))),'r');

% A multisine with constant phase and excitation in the specified analysis
% band only
% [sCst, crest2] = multisine(4096, 1, 500, 1, 'constant', 0);
% sCst = sCst/max(sCst)*4.5;
% csvwrite('sCst.csv',sCst');


% A multisine with an arbitrary phase and excitation in the specified
% analysis band only
% [sR, crestR] = multisine(4096, 1, 500, 1, 'random', 0);
% sR = sR/rms(sR);
% csvwrite('sR.csv',sR');
% load('measR')
% hold on;
% plot(db(fft(y(:,10))),'b');
% legend('Schroder (4096 samples)', 'Random (4096 samples)')

% A multisine with a Schröeder phase and a data record length of 512
% samples in the specified analysis band only
% N = 512;
% fs = 1000;
% 
% [sS512, ~] = multisine(5000, 1, 400, 1000, 'schroder', 0);
% sS512 = sS512/rms(sS512);
% sS512 = sS512.';
% fr = fs/N;
% f = fr.*[0:N-1];
% 
% save('sS512.csv','sS512', '-ascii');

% load('measS512')
% figure;
% plot(db(fft(y(:,10))),'b');
% legend('Schroeder 512 samples')

% A multisine with a Schröeder phase and excitation outside the analysis
% band
% [sSout, c] = multisine(4096, 150, 250, 4000, 'schroder', 0);
% sSout = sSout/rms(sSout);
% csvwrite('sSout.csv',sSout');
% 
% % A multisine with a Schröeder phase and a maximal amplitude of 0.5V
% [s05, c] = multisine(4096, 1, 500, 4000, 'schroder', 0);
% s05 = s05/max(s05)*0.5;
% csvwrite('s05.csv',s05');
% figure;
% load('meas05.MAT')
% plot(db(abs(fft(y(:,10)))),'r')
% hold on;


% A multisine with a Schröeder phase and a maximal amplitude of 3V
% [s3, c] = multisine(4096, 1, 500, 4000, 'schroder', 0);
% s3 = s3/max(s3)*3;
% csvwrite('s3.csv',s3');
% load('meas3.MAT')
% plot(db(abs(fft(y(:,10)))),'b')
% legend('0.5V','3V')

% Perdiodic noise
n = randn(1, 256);
noiseP = repmat(n,1, 16);
csvwrite('noiseP.csv',noiseP');

% Aperdiodic noise
nA = randn(1, 4096);
csvwrite('noiseA.csv',nA');





