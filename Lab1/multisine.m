function [s, crest] = multisine(N_samples, kmin, kmax, fres, phase_type, eplot)
%{
Generates a multisine signal of N_samples. It sweeps a number of
frequencies equal to N_freq, all multiples of f_base.
The crest factor is also computed and returned.

The phase of each sine is determined by the argument phase_type, which can
either be 'constant' for a constant phase spectrum, 'random' for a random
phase or 'schroder' for a schroder phase.
%}

s = zeros(1, N_samples);
fs = fres*N_samples; %biggest frequency
Ts = 1/fs;
t = 0:Ts:(N_samples-1)*Ts; %N samples

switch phase_type

    case 'constant' % Constant phase fixed to 0
    
    for k = kmin:fres:kmax
        s = s + sin(2*pi*fres*k*t + pi/2);
    end
        
    case 'random'   % Random phase, uniformly distributed between 0 and 2pi
        
    for k = kmin:fres:kmax
        s = s + sin(2*pi*fres*k*t + 2*pi*rand(1));
    end
        
    case 'schroder' % Schroder's formula
    
    for k = kmin:fres:kmax
        s = s + sin(2*pi*fres*k*t + pi*k*(k+1)/kmax);
    end
    
    otherwise
        error('Unknown phase_type argument');        
end

crest = max(s)/rms(s);

if (eplot == 1)
    
    figure;
    subplot(1,2,1)
    plot(t, s);
    xlabel('Time (s)')
    xlim([0 max(t)])
    ylabel('Amplitude')
    title(['Temporal signal with a ', phase_type, ' phase']);

    subplot(1,2,2)
    nfft = N_samples;
    freq = abs(fftshift(fft(s,nfft)));
    freq = freq(end/2:end);
    stem(freq)
    xlabel('Frequency (bins)')
    ylabel('Amplitude')
    title(['Frequency content with a ', phase_type, ' phase']);
end



