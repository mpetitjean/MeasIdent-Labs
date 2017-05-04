%% Generate signals

% Full multisine
[s, ~] = multisine(8000, 1, 4000, 16000, 'schroder', 1.5,0);
csvwrite('full_multisine.csv',s.');

% Perdiodic noise
n = randn(1, 200);
n = n./rms(n)*1.5;
noiseP = repmat(n,1, 40);
csvwrite('noiseP.csv',noiseP');

% Aperdiodic noise
nA = randn(1, 8000);
nA = nA./rms(nA)*1.5;
csvwrite('noiseA.csv',nA');

% Random odd multisine
[multiRO, ~] = multisine_freq(4096,8000,1,2000,3,1.5);
csvwrite('multiRO.csv',multiRO);

%% Compute FRFs for full multisine
close all;
load('full.MAT');

% figure;
[H, stdH] = TransferFunc(u, y, [2 16 32], 'timeAveraging');
% plot(db(abs(H(:,1))),'r');
% hold on;
% plot(db(abs(H(:,2))),'b');
% plot(db(abs(H(:,3))),'k');
% legend('2','16','32')
% title('Time Averaging')
H32(:,1) = H(:,3);

% figure;
[H, stdH] = TransferFunc(u, y, [2 16 32], 'dftAveraging');
% plot(db(abs(H(:,1))),'r');
% hold on;
% plot(db(abs(H(:,2))),'b');
% plot(db(abs(H(:,3))),'k');
% legend('2','16','32')
% title('DFT Averaging')
H32(:,2) = H(:,3);

% figure;
[H, stdH] = TransferFunc(u, y, [2 16 32], 'frfAveraging');
% plot(db(abs(H(:,1))),'r');
% hold on;
% plot(db(abs(H(:,2))),'b');
% plot(db(abs(H(:,3))),'k');
% legend('2','16','32')
% title('FRF Averaging')
H32(:,3) = H(:,3);

% figure;
[H, stdH] = TransferFunc(u, y, [2 16 32], 'averagingAuto1');
% plot(db(abs(H(:,1))),'r');
% hold on;
% plot(db(abs(H(:,2))),'b');
% plot(db(abs(H(:,3))),'k');
% legend('2','16','32')
% title('Cross Averaging 1')
H32(:,4) = H(:,3);


% figure;
[H, stdH] = TransferFunc(u, y, [2 16 32], 'averagingAuto2');
% plot(db(abs(H(:,1))),'r');
% hold on;
% plot(db(abs(H(:,2))),'b');
% plot(db(abs(H(:,3))),'k');
% legend('2','16','32')
% title('Cross Averaging 2')
H32(:,5) = H(:,3);

figure;
plot(db(abs(H32)));
legend('timeAveraging','DFT Averaging','FRF Averaging','Cross Averaging 1','Cross Averaging 2')
title('Multisine Excitation')
% axis([0 2000 -60 20])



%% Compute FRFs for periodic noise
close all;
load('noiseP.MAT');

% figure;
[H, stdH] = TransferFunc(u, y, [2 16 32], 'timeAveraging');
% plot(db(abs(H(:,1))),'r');
% hold on;
% plot(db(abs(H(:,2))),'b');
% plot(db(abs(H(:,3))),'k');
% legend('2','16','32')
% title('Time Averaging')
H32(:,1) = H(:,3);

% figure;
[H, stdH] = TransferFunc(u, y, [2 16 32], 'dftAveraging');
% plot(db(abs(H(:,1))),'r');
% hold on;
% plot(db(abs(H(:,2))),'b');
% plot(db(abs(H(:,3))),'k');
% legend('2','16','32')
% title('DFT Averaging')
H32(:,2) = H(:,3);

% figure;
[H, stdH] = TransferFunc(u, y, [2 16 32], 'frfAveraging');
% plot(db(abs(H(:,1))),'r');
% hold on;
% plot(db(abs(H(:,2))),'b');
% plot(db(abs(H(:,3))),'k');
% legend('2','16','32')
% title('FRF Averaging')
H32(:,3) = H(:,3);

% figure;
[H, stdH] = TransferFunc(u, y, [2 16 32], 'averagingAuto1');
% plot(db(abs(H(:,1))),'r');
% hold on;
% plot(db(abs(H(:,2))),'b');
% plot(db(abs(H(:,3))),'k');
% legend('2','16','32')
% title('Cross Averaging 1')
H32(:,4) = H(:,3);

% figure;
[H, stdH] = TransferFunc(u, y, [2 16 32], 'averagingAuto2');
% plot(db(abs(H(:,1))),'r');
% hold on;
% plot(db(abs(H(:,2))),'b');
% plot(db(abs(H(:,3))),'k');
% legend('2','16','32')
% title('Cross Averaging 2')
H32(:,5) = H(:,3);

figure;
plot(db(abs(H32)));
legend('timeAveraging','DFT Averaging','FRF Averaging','Cross Averaging 1','Cross Averaging 2')
title('Periodic Noise Excitation')

%% Compute FRFs for aperiodic noise
close all;
load('noiseA.MAT');

% figure;
[H, stdH] = TransferFunc(u, y, [2 16 32], 'timeAveraging');
% plot(db(abs(H(:,1))),'r');
% hold on;
% plot(db(abs(H(:,2))),'b');
% plot(db(abs(H(:,3))),'k');
% legend('2','16','32')
% title('Time Averaging')
H32(:,1) = H(:,3);

% figure;
[H, stdH] = TransferFunc(u, y, [2 16 32], 'dftAveraging');
% plot(db(abs(H(:,1))),'r');
% hold on;
% plot(db(abs(H(:,2))),'b');
% plot(db(abs(H(:,3))),'k');
% legend('2','16','32')
% title('DFT Averaging')
H32(:,2) = H(:,3);

% figure;
[H, stdH] = TransferFunc(u, y, [2 16 32], 'frfAveraging');
% plot(db(abs(H(:,1))),'r');
% hold on;
% plot(db(abs(H(:,2))),'b');
% plot(db(abs(H(:,3))),'k');
% legend('2','16','32')
% title('FRF Averaging')
H32(:,3) = H(:,3);

% figure;
[H, stdH] = TransferFunc(u, y, [2 16 32], 'averagingAuto1');
% plot(db(abs(H(:,1))),'r');
% hold on;
% plot(db(abs(H(:,2))),'b');
% plot(db(abs(H(:,3))),'k');
% legend('2','16','32')
% title('Cross Averaging 1')
H32(:,4) = H(:,3);


% figure;
[H, stdH] = TransferFunc(u, y, [2 16 32], 'averagingAuto2');
% plot(db(abs(H(:,1))),'r');
% hold on;
% plot(db(abs(H(:,2))),'b');
% plot(db(abs(H(:,3))),'k');
% legend('2','16','32')
% title('Cross Averaging 2')
H32(:,5) = H(:,3);

figure;
plot(db(abs(H32)));
legend('timeAveraging','DFT Averaging','FRF Averaging','Cross Averaging 1','Cross Averaging 2')
title('Aperiodic Noise Excitation')

%% RO multisine
load('RO')




