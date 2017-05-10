clear, close all;

%% Transfer function
a = [2.765e-001 -3.464e-001 6.141e-001 -4.371e-001 4.410e-001 -1.645e-001 9.9619e-002];
b = [8.002e-004 1.9427e-002 -4.5489e-002 1.245e-002 3.050e-002 -1.928e-002 1.902e-003];

H = tf(b,a);

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
ve = sigma_u.*randn(ne,1);
vv = sigma_u.*randn(nv,1);

% Noiseless outputs
y0e = filter(b, a, ue);
y0v = filter(b, a, uv);

% Noisy outputs
ye = y0e + ve;
yv = y0v + vv;

%% Task 2: impulse response estimation

for I = 1:100
    H = 1; % ?
    Y = 1; % ?   
    thetaLS = H\Y;
end
