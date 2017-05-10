clear;
close all;
N = 4096;
fs = 1e4;

%% sine 77 Hz 1V amp

t = 0:1/fs:(N-1)/fs;
s1 = sin(2*pi*77*t);
csvwrite('sine1.csv',s1');

X = fftshift(fft(s1));
dF = fs/N;                      % hertz
f = -fs/2:dF:fs/2-dF;           % hertz
figure;
plot(f,db(abs(X)));
grid on;

% Problem 77Hz not aligned on multiple of f_res
f2 = round(77/fs*N)*fs/N;
s3 = sin(2*pi*f2*t);
csvwrite('sine3.csv',s3');

X = fftshift(fft(s3));
dF = fs/N;                      % hertz
f = -fs/2:dF:fs/2-dF;           % hertz
figure;
plot(f,db(abs(X)));
grid on;


%% Determination IP
amp = logspace(-1, log10(5), 10)';
sIP = repmat(amp,[1 N]).*repmat(sin(2*pi*f2*t),[length(amp) 1]);

for ii = 1:length(amp)
    csvwrite(['sAmp' num2str(ii) '.csv'], sIP(ii,:)');
end

figure;
ampOut = zeros(1,length(amp));
for ii = 1:length(amp)
    load(['sAmp' num2str(ii)]);
    ampOut(ii) = max(y(:,end));
end
slope = 1.001;
oo = 12.9;
plot(db(amp), db(ampOut), 'o');
hold on;
lin = @(x) slope*x + oo;
fplot(lin)
xlabel('Input Amplitude (dB)')
ylabel('Output Amplitude (dB)')
grid on;

figure;
plot(db(amp), lin(db(amp)) - db(ampOut)');
hold on;
line([-20 15],[1 1],'linestyle', ':')
grid on;


%% Extending to multisines
[s, ~] = multisine_freq(4096, 1e4 , 5, 1000, 3, 1.5);
csvwrite('multi.csv', s);

load('multi.MAT')

% Plot excited frequencies
excited = db(abs(fft(u(:,10))));
excited(excited < 30) = -Inf;
excited(excited ~= -Inf) = 1;

figure;
plot(excited.*db(abs(fft(y(:,10)))), 'ro')
hold on;

% Plot even frequencies
Y = db(abs(fft(y(:,10))));
Yeven = Y;
Yeven(2:2:end) = -Inf;
plot(Yeven, 'kx')


% Plot unexcited odd frequencies
Yodd = Y;
Yodd(1:2:end) = -Inf;
Yodd(excited == 1) = -Inf;
plot(Yodd, 'bd')

[H, stdH] = TransferFunc(u, y, 5, 'dftAveraging');
plot(stdH, 'cx')

legend('Excited frequencies','Even frequencies', 'Non excited odd frequencies', 'Noise floor')
