clear, close all;

%% Transfer function
a = [2.765e-001 -3.464e-001 6.141e-001 -4.371e-001 4.410e-001 -1.645e-001 9.9619e-002];
b = [8.002e-004 1.9427e-002 -4.5489e-002 1.245e-002 3.050e-002 -1.928e-002 1.902e-003];

G = tf(b,a);

%% Task 1: data generation
ne = 2000;          % Experiment
nv = 11000;         % Validation
nt = 1000;          % Transient

sigma_u = 1;
sigma_v = 0.5;

% Inputs
ue = sigma_u.*randn(ne,1);
uv = sigma_u.*randn(nv,1);

% Noise
ve = sigma_v.*randn(ne,1);
vv = sigma_v.*randn(nv,1);

% Noiseless outputs
y0e = filter(b, a, ue);
y0v = filter(b, a, uv);

% Noisy outputs
ye = y0e + ve;
yv = y0v + vv;

%% Task 2: impulse response estimation + Task 3: model selection

N = ne-nt;
% Construct H for I=100;
I = 100;
H = zeros(N,I+1);
for ii = 0:N-1
   H(ii+1,:) = ue(nt+1+ii:-1:nt+1+ii-I);  
end

Ve = zeros(1,I);
Vv = zeros(1,I);
Vaic = zeros(1,I);
for I = 1:100 
    % Compute LS estimator
    Y = ye(nt+1:end); 
    thetaLS = H(:,1:I+1)\Y;
    
    % Compute cost function
    yeHat = filter(thetaLS,1,ue);
    yvHat = filter(thetaLS,1,uv);
    Ve(I) = immse(ye(nt+1:end),yeHat(nt+1:end))/sigma_v^2;
    Vv(I) = immse(yv(nt+1:end),yvHat(nt+1:end))/sigma_v^2;
    Vaic(I) = Ve(I)*(1+2*I/N);
end

% % Plots
% figure;
% plot(1:100,Ve,'-o')
% hold on;
% plot(1:100,Vv,'-o')
% plot(1:100,Vaic,'-o')
% legend('Ve', 'Vv', 'Vaic')
% ylabel('Cost function')
% xlabel('Model order')
% grid on;

%% Task 4: same for various noise levels
figure;
ii = 1;
for sigma = [0 0.1 0.5]
    [Ve, Vv, Vaic] = computeV(sigma);
    subplot(1,3,ii);
    plot(1:100,Ve,'-o')
    hold on;
    plot(1:100,Vv,'-o')
    plot(1:100,Vaic,'-o')
    legend('Ve', 'Vv', 'Vaic')
    ylabel('Cost function')
    xlabel('Model order')
    grid on;
    title(['sigma_v = ' num2str(sigma)]);
    ii = ii + 1;
end

%% Task 5: analysis
% see syllabus

%% Task 6: data generation and acquisition
addpath(genpath('./Data/'));

% Store estimation data
stringSys = {'500', '2000'};
stringNoise = {'1', '2', '3'};
bigUEst = zeros(2000,6);
bigYEst = zeros(2000,6);
bigUVal = zeros(11000,6);
bigYVal = zeros(11000,6);
nt = 1000;
figure;
nfft = 1024;
for ii = 1:2
    for jj = 1:3
        T = load(['uEst' stringSys{ii} '_' stringNoise{jj} '.mat'], 'u', 'y');
        ue = T.('u');
        ye = T.('y');
        T = load(['uVal' stringSys{ii} '_' stringNoise{jj} '.mat'], 'u', 'y');
        uv = T.('u');
        yv = T.('y');
        [Ve, Vv, Vaic, H] = computeV2(ue, uv, ye, yv);
%         figure('Name', ['System ' stringSys{ii} ' - Noise level ' stringNoise{jj}], 'NumberTitle', 'off');
%         plot(1:100,Ve,'-o')
%         hold on;
%         plot(1:100,Vv,'-o')
%         plot(1:100,Vaic,'-o')
%         legend('Ve', 'Vv', 'Vaic')
%         ylabel('Cost function')
%         xlabel('Model order')
%         grid on;
%         title(['System ' stringSys{ii} ' - Noise level ' stringNoise{jj}]);
        [~, order] = min(Vv);       
        Y = ye(nt+1:end); 
        thetaLS = H(:,1:order)\Y;
        if (strcmp(stringSys{ii},'500'))
            plot(db(abs(fftshift(fft(thetaLS,nfft)))),'-o');
        else
            plot(db(abs(fftshift(fft(thetaLS,nfft)))));
        end
        hold on;
        leg{(ii-1)*3+jj} = ['System ' stringSys{ii} ' - Noise level ' stringNoise{jj}];
    end
end
xlim([nfft/2, nfft])
legend(leg);



