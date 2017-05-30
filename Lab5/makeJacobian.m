function Jl = makeJacobian(num, den, snorm, A, B)

nb = length(num)-1;
na = length(den);

Jl = zeros(length(snorm),nb+na+1);
for ii = 1:length(snorm)
    Jl(ii,:) = [(snorm(ii).^(nb:-1:0))./A(ii), -B(ii).*(snorm(ii).^(na:-1:1))./(A(ii)^2)]; 
end