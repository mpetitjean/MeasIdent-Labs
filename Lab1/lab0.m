%vubirelec.be/people/georgios-birpoutsoukis
%office @K6

% Multisine with constant phase = pi/2
clear all;
close all;

kmin = 1;
kmax = 500;
N = 4096;
fres = 1;
fs = fres*N; %biggest frequency
Ts = 1/fs;
t = 0:Ts:(N-1)*Ts; %N samples
u = zeros(1,length(t));

for k=kmin:fres:kmax
    u = u + cos (2*pi*k*fres*t+pi/2);
end

t = 0:Ts:(2*N-1)*Ts;
u = repmat(u,1,2);

subplot(2,5,1)
plot(t,u) % time domein

z=fft(u);
%f = 0:fs/N:fs-fs/N;
subplot(2,5,6) % frequency domein
stem(abs(z))
xlim([0 fs/2])


% We use a random phase phi =[0,2pi]

t = 0:Ts:(N-1)*Ts; %N samples
u = zeros(1,length(t));
phi = rand(1,N)*2*pi;
i=1;

for k=kmin:fres:kmax
    u = u + cos (2*pi*k*fres*t+phi(i));
    i=i+1;
end

t = repmat(t,1,2);
u = repmat(u,1,2);

subplot(2,5,2)
plot(t,u) % time domein

z=fft(u);
subplot(2,5,7) % frequency domein
stem(abs(z))
xlim([0 fs/2])


% Multisine with Schroeder phase k(k-1)*pi/kmax

t = 0:Ts:(N-1)*Ts; %N samples
u = zeros(1,length(t));

for k=kmin:fres:kmax
    phi = k*(k-1)*pi/kmax;
    u = u + cos (2*pi*k*fres*t+phi);
end

t = repmat(t,1,2);
u = repmat(u,1,2);

subplot(2,5,3)
plot(t,u) % time domein

z=fft(u);
subplot(2,5,8) % frequency domein
stem(abs(z))
xlim([0 fs/2])


% Schroeder phase

kmin = 1;
kmax = 500;
fres = 1;
k=kmin:fres:kmax;
phi = k.*(k-1)*pi/kmax;
subplot(2,5,4)
title('Schroeder phase')
xlabel('k')
ylabel('phi')
plot(k,phi)


% Odd multisine

t = 0:Ts:(N-1)*Ts; %N samples
u = zeros(1,length(t));

for k=kmin+1:fres*2:kmax-1
    phi = k*(k-1)*pi/kmax;
    u = u + cos (2*pi*k*fres*t+phi);
end

t = repmat(t,1,2);
u = repmat(u,1,2);

subplot(2,5,5)
plot(t,u) % time domein

z=fft(u);
subplot(2,5,10) % frequency domein
stem(abs(z))
xlim([0 fs/2])


%*** Explanations ***
%We have a max in 0 because each signal has the same phase. This is not
%good for an excitation. This is to abrupt. That's why we use a random
%phase or a Schroeder phase
%bin n°1 = one period in the time windo

