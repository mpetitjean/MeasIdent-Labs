function H = makeHLevy(na, nb, Gm, snorm)

H = zeros(length(snorm),na+nb+1);
for ii = 1:length(snorm)
   H(ii,:) = [snorm(ii).^(nb:-1:0), -Gm(ii)*snorm(ii).^(na:-1:1)];
end