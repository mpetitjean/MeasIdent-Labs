% Generate the signals needed for Lab1, section 1.4.1

clear;
close all;

% Schroder from 1 to 500 Hz with 1 Hz resolution
% f_samp = 8 kHz, normalize so that vrms = 1 mV
[s1, crest1] = multisine(4096, 500, 1, 8000, 'schroder',0);
s1 = s1./(rms(s1)/1e-3);

% Constant phase
[s2, crest2] = multisine(4096, 500, 1, 8000, 'constant',0);
s2 = s2./(rms(s2)/1e-3);

% Schroder, 512 samples
[s3, crest3] = multisine(512, 500, 1, 8000, 'schroder',0);
s3 = s3./(rms(s3)/1e-3);

% Schroder outside the analysis band
[s4, crest4] = multisine(4096, 7, 500, 8000, 'schroder',0);
s4 = s4./(rms(s4)/1e-3);

% Schroder, max 0.5V
[s5, crest5] = multisine(4096, 500, 1, 8000, 'schroder',0);
s5 = s5.*(0.5/max(s5));

% Schroder, max 3V
[s6, crest6] = multisine(4096, 500, 1, 8000, 'schroder',0);
s6 = s6.*(3/max(s6));

% Periodic noise
l = 256;
noise = rand(1,l);
noise = noise - rms(noise);
s7 = [];
for i = 1:4096/l
    s7 = [s7 noise];
end


% Aperiodic noise
s8 = rand(1, 4096);

% Multisine with only odd bins excited
[s9, crest9] = multisine(4096, 250, 1, 8000, 'schroder',1);
s9 = s9.*(3/max(s6));

    
    
    
    
    
    
    
    
    
    
    
    
