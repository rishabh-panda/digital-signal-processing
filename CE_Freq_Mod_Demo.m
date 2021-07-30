clc;
clear all;
close all;

samples = 1000;
t = linspace(0,1,samples);

%% Message Signal
message_amplitude = 1;
message_frequency = 5;
message_signal = message_amplitude*cos(2*pi*message_frequency*t);
subplot(5,1,1);
plot(t,message_signal);
xlabel('Time Index')
ylabel('Amplitude')
title('Message Signal (1904215)');


%% Carrier Signal
carrier_amplitude = 1;
carrier_frequency = 15*message_frequency;
carrier_signal = carrier_amplitude*cos(2*pi*carrier_frequency*t);
subplot(5,1,2);
plot(t,carrier_signal);
xlabel('Time Index')
ylabel('Amplitude')
title('Carrier Signal (1904215)');

%% Frequency Modulation
B = 12;
%% B less than 1 => NBFM; B greater than 1 => WBFM  
%% NBFM - Narrow Band Frequency Modulation
%% WBFM - Wide Band Frequency Modulation

freq_mod_signal = carrier_amplitude*cos(2*pi*carrier_frequency*t+B*sin(2*pi*message_frequency*t));
subplot(5,1,3);
plot(t,freq_mod_signal);
xlabel('Time Index')
ylabel('Amplitude')
title('Frequency Modulation (1904215)');

%% Frequency Demodulation
%% Envelope Detector
x = abs(diff(freq_mod_signal));
for i=1:length(x)
  if x(i)<0
    x=0
  endif
 end
[b,a] = butter(5,0.01);
freq_demod_signal = filter(b,a,x);
subplot(5,1,4);
plot(freq_demod_signal);
xlabel('Time Index')
ylabel('Amplitude')
title('Frequency Demodulation');

subplot(5,1,5);
plot(x);
xlabel('Time Index')
ylabel('Amplitude')
title('Envelope Detector');
