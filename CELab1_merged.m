%% Program for generating,
%% Amplitude Modulated, Demodulated, DSB-SC and SSB-SC Signals
%% Name: Rishabh Panda
%% Roll No: 1904215

clc;
close all;
clear all;

% Modulating index
m_critical = 1; %critical
m_over = 1.5; %over
m_under = 0.5; %under 

% Amplitude of modulating signal
Am = 2; 

% Frequency of modulating signal (Hz)
fm = 5; 

% Time period of modulating signal (s)
Ta = 1/fm; 
t = 0:(Ta/1000):1;

% Modulating signal
ym = Am*cos(2*pi*fm*t);
figure(1)
subplot(3,3,1)
plot(t,ym)
grid on;
xlabel('Time Index')
ylabel('Amplitude')
title('Modulating Signal')

% Relation between Am/Cm and fc/fa
% Relation between Am/Cm and fc/fa
Ac_under = Am/m_under;
Ac_critical = Am/m_critical;
Ac_over = Am/m_over;

fc = fm*15; %carrier and message signal frequency relation
Tc = 1/fc;

% Carrier signals (under, critical, under)
yc_under = Ac_under*cos(2*pi*fc*t);
yc_critical = Ac_critical*cos(2*pi*fc*t);
yc_over = Ac_over*cos(2*pi*fc*t);

% Carrier signal
yc = Ac_critical*cos(2*pi*fc*t);
subplot(3,3,2)
plot(t,yc_critical)
grid on;
xlabel('Time Index')
ylabel('Amplitude')
title('Carrier Signal')

% Amplitude Modulation
y_mod = (Ac_under+ym).*cos(2*pi*fc*t);
subplot(3,3,3)
plot(t,y_mod)
grid on;
xlabel('Time Index')
ylabel('Amplitude')
title('50% Amplitude Modulated Signal')

y_mod = (Ac_critical+ym).*cos(2*pi*fc*t);
subplot(3,3,4)
plot(t,y_mod)
grid on;
xlabel('Time Index')
ylabel('Amplitude')
title('100% Amplitude Modulated Signal')

y_mod = (Ac_over+ym).*cos(2*pi*fc*t);
subplot(3,3,5)
plot(t,y_mod)
grid on;
xlabel('Time Index')
ylabel('Amplitude')
title('150% Amplitude Modulated Signal')

%Amplitude Demodulation
y_demo = y_mod.*yc_critical;
[b,a] = butter(5,0.01);
y_demo_filtered = filter(b,a,y_demo);
subplot(3,3,6)
plot(t,y_demo);
grid on;
xlabel('Time Index')
ylabel('Amplitude')
title('Demodulation Without Filtering')

subplot(3,3,7)
plot(t,y_demo_filtered);
grid on;
xlabel('Time Index')
ylabel('Amplitude')
title('Filtered Demodulation')

% DSB-SC signal
y = ym.*yc;
subplot(3,3,8)
plot(t,y)
grid on;
xlabel('Time Index')
ylabel('Amplitude')
title('Double Sideband Suppressed Carrier Signal (DSB-SC)')

% SSB-SC signal
%y = cos(2*pi*(fm-fc)*t);
m_cap_t = sin(2*pi*fm*t);
y = ym.*cos(2*pi*fc*t)+m_cap_t.*sin(2*pi*fc*t);
subplot(3,3,9)
plot(t,y)
grid on;
xlabel('Time Index')
ylabel('Amplitude')
title('Single Sideband Suppressed Carrier Signal (SSB-SC)')