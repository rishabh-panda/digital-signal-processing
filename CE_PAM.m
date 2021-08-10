%% Pulse Amplitude Modulation
clc;
close all;
clear all;

samples = 1000;
fm = 3; % source frequency
Am = 1;
Ac = 1;
fs = 10; % sampl
t = linspace(0,1,samples);
m_t = Am*cos(2*pi*fm*t);

% PAM Signal
c_t = zeros(1,samples);
for i = 1:20:samples
    c_t(1, i:i+9) = 1;
    c_t(1, i+10:i+19) = 0;
end

s_t = m_t.*c_t;

figure(1)
subplot(4,1,1);
plot(t,m_t);
title('Message Signal');
xlabel('Time Axis');
ylabel('Amplitude');

subplot(4,1,2);
plot(t,c_t);
title('Pulse Signal');
xlabel('Time Axis');
ylabel('Amplitude');

subplot(4,1,3);
plot(t,s_t);
title('Pulse Amplitude Modulation');
xlabel('Time Axis');
ylabel('Amplitude');

%demodulation
dt = s_t.*c_t;
[b,a] = butter(5,0.01);
retrieved = filter(b,a,dt);

subplot(4,1,4);
plot(t, retrieved);
title('Demodulated Signal');
xlabel('Time Axis');
ylabel('Amplitude');
