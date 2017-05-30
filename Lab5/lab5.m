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
alpha = (min(freq) + max(freq))/2;
% alpha = 1;
fnorm = freq./alpha;
snorm = 1j*2*pi*fnorm;

%% Levy implementation
na = 6;
nb = 6;
hLevy = makeHLevy(na, nb, Gm, snorm);

% split real and imag for LS
Gmc = [real(Gm); imag(Gm)];
hLevyc = [real(hLevy); imag(hLevy)];
thetaLevy = hLevyc\Gmc;
condLevy=cond(hLevyc);

% Exctract num and den
num = thetaLevy(1:nb+1);
num2 = num./((alpha.^(nb:-1:0)).');
den = thetaLevy(nb+2:end);
den2 = den./((alpha.^(na:-1:1)).');

% Plot result
figure;
w = 2*pi*freq;
GLevy = freqs(num2,[den2;1],w);
plot(freq,db(Gm));
hold on;
plot(freq,db(GLevy));
plot(freq,db(Gm-GLevy));
legend('Gm','GLevy','Error');
xlabel('Frequency');
ylabel('Magnitude');

%% Sanathanan implementation

denSan = den;
maxit = 10;

for it = 1:maxit
    Asan = polyval([denSan; 1], snorm);
    GmSan = Gm./Asan;
    hSan = makeHSan(hLevy, Asan);

    % Split
    GmSanc = [real(GmSan); imag(GmSan)];
    hSanc = [real(hSan); imag(hSan)];

    % Solve 
    thetaSan = hSanc\GmSanc;
    condSan = cond(hSanc);

    % Extract num and den
    numSan = thetaSan(1:nb+1);
    denSan = thetaSan(nb+2:end);
end

% Normalize
denSan = denSan./((alpha.^(na:-1:1)).');
numSan = numSan./((alpha.^(nb:-1:0)).');

% Plot result
figure;
GSan = freqs(numSan,[denSan;1],w);
plot(freq,db(Gm));
hold on;
plot(freq,db(GSan));
plot(freq,db(Gm-GSan));
legend('Gm','GSan','Error');
xlabel('Frequency');
ylabel('Magnitude');

figure;
plot(freq,db(Gm-GLevy));
hold on;
plot(freq,db(Gm-GSan));
legend('Levy error','Sanathanan error');

%% Gauss-Newton implementation
close all;
% use thetaLevy as init
thetaGn = thetaLevy;
cost = Inf;
tol = 1e-3;
it = 0;

while cost > tol
    num = thetaGn(1:nb+1);
    den = thetaGn(nb+2:end);
    Bgn = polyval(num,snorm);
    Agn = polyval([den; 1],snorm);
    Ggn = Bgn./Agn;

    % Error and Jacobian
    El = Gm-Ggn;
    cost = El'*El;
    Jl = makeJacobian(num, den, snorm, Agn, Bgn);

    % Split
    Elc = [real(El); imag(El)];
    Jlc = [real(Jl); imag(Jl)];   
    deltaTheta = Jlc\Elc;
    condJac = cond(Jl);

    thetaGn = thetaGn + deltaTheta;
    it = it + 1;
end

num = thetaGn(1:nb+1);
den = thetaGn(nb+2:end);
num = num./((alpha.^(nb:-1:0)).');
den = den./((alpha.^(na:-1:1)).');

% Plot result
figure;
Ggn = freqs(num,[den;1],w);
plot(freq,db(Gm));
hold on;
plot(freq,db(Ggn));
plot(freq,db(Gm-Ggn));
legend('Gm','Ggn','Error');
xlabel('Frequency');
ylabel('Magnitude');

figure;
plot(freq,db(Gm-GLevy));
hold on;
plot(freq,db(Gm-GSan));
plot(freq,db(Gm-Ggn));
legend('Levy error','Sanathanan error','Gauss-Newton error');



