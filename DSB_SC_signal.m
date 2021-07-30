clc;
close all;
clear all;

% Modulating index
m_critical = 1; % critical 
m_over = 1.5; % over
m_under = 0.5; % under

% Amplitude of modulating signal
Am = 10; 

% Frequency of modulating signal (Hz)
fm = 5; 

% Time period of modulating signal (s)
Ta = 1/fm; 

t = 0:Ta/1000:1;

% Modulating signal
ym = Am*cos(2*pi*fm*t);
figure(1)
subplot(3,1,1)
plot(t,ym)
grid on;
xlabel('Time Index')
ylabel('Amplitude')
title('Modulating Signal')

% Relation between Am/Cm and fc/fa
Ac = Am/m_critical; %CHANGE IN MODULATING INDEX

fc = fm*15;
Tc = 1/fc;

% Carrier signal
yc = Ac*cos(2*pi*fc*t);
subplot(3,1,2)
plot(t,yc)
grid on;
xlabel('Time Index')
ylabel('Amplitude')
title('Carrier Signal')

% DSB-SC signal
y = ym.*yc;
subplot(3,1,3)
plot(t,y)
grid on;
xlabel('Time Index')
ylabel('Amplitude')
title('Double Sideband Suppressed Carrier Signal (DSB-SC)')
