clc;
clear all;
close all;
pkg load communications;

% Adaptive delta modulation
function y=AdaptiveMod(Message,Step,deltaStart,deltaRate)
x_temp=deltaStart;
y_temp=0;
deltaFactor=0;
y=zeros(1,length(Message));
for i=1:length(Message)
	y(i)=(Message(i)>x_temp); %y stores either +1 or -1.
	x_temp=x_temp+Step*sign(y(i)-0.5)*(deltaRate^deltaFactor);
	deltaFactor=deltaFactor+sign((y(i)==y_temp)-0.5);
	y_temp=y(i);
end
end

% Simulation settings
A=1; % Amplitude of message signal
fc=1; % frequency of message signal
t=linspace(0,1,50); % defining the time axis
Step=0.2; % denotes the height of each step
SNR=20; %signal to noise ratio

% Perform adaptive delta modulation
xt_sig=A*sin(2*pi*fc*t); % message signal
yt_sig=AdaptiveMod(xt_sig, Step, 0, 1.2); % calling function
yr_sig=awgn(yt_sig, SNR);

% Plot results
subplot(3,1,1);
plot(t, xt_sig);
title('Message Signal');
xlabel('Time Axis')
ylabel('Amplitude')

subplot(3, 1, 2);
stairs(t, yr_sig, 'r');
title('Adaptive Delta Modulation');
xlabel('Time Axis')
ylabel('Amplitude')


subplot(3,1,3);
plot(t, xt_sig); hold on; stairs(t, yr_sig, 'b');
title('ADM and Message Signal');
xlabel('Time Axis')
ylabel('Amplitude')
