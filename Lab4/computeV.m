function [Ve, Vv, Vaic] = computeV(sigma_v)

% Transfer function
a = [2.765e-001 -3.464e-001 6.141e-001 -4.371e-001 4.410e-001 -1.645e-001 9.9619e-002];
b = [8.002e-004 1.9427e-002 -4.5489e-002 1.245e-002 3.050e-002 -1.928e-002 1.902e-003];

% data generation
ne = 2000;          % Experiment
nv = 11000;         % Validation
nt = 1000;          % Transient

sigma_u = 1;

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
    if (sigma_v ~= 0)
        Ve(I) = immse(ye(nt+1:end),yeHat(nt+1:end))/sigma_v^2;
        Vv(I) = immse(yv(nt+1:end),yvHat(nt+1:end))/sigma_v^2;
    else
        Ve(I) = immse(ye(nt+1:end),yeHat(nt+1:end));
        Vv(I) = immse(yv(nt+1:end),yvHat(nt+1:end));
    end
    Vaic(I) = Ve(I)*(1+2*I/N);
end
