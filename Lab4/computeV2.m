function [Ve, Vv, Vaic, H] = computeV2(ue, uv, ye, yv)

ne = 2000;          % Experiment
nt = 1000;          % Transient

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

for I = 0:100 
    % Compute LS estimator
    Y = ye(nt+1:end); 
    thetaLS = H(:,1:I+1)\Y;
    
    % Compute cost function
    yeHat = filter(thetaLS,1,ue);
    yvHat = filter(thetaLS,1,uv);
    
    Ve(I+1) = immse(ye(nt+1:end),yeHat(nt+1:end));
    Vv(I+1) = immse(yv(nt+1:end),yvHat(nt+1:end));
    Vaic(I+1) = Ve(I+1)*(1+2*I/N);
end
