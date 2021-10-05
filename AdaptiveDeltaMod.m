clc;
clear all;
close all;
pkg load communications;

% Adaptive delta modulation function
function y = AdaptiveMod(x,delta,delta_start,delta_change_rate)
y_old=0;
delta_factor=0;
x_old=delta_start;
y=zeros(1,length(x));
for i=1:length(x)
	y(i)=(x(i) > x_old);
	x_old=x_old+delta*sign(y(i)-0.5)*(delta_change_rate^delta_factor);
	delta_factor=delta_factor+sign((y(i)==y_old)-0.5);
	y_old=y(i);
end
end

% Adaptive delta demodulation function
function y = AdaptiveDemod(x,delta,delta_start,delta_change_rate)
x_old=0;
delta_factor = 0;
y_old=delta_start;
y=zeros(1, length(x));
for i=1:length(x)
    xd=(x(i)>=0.5);
	y_old=y_old+delta*sign(xd-0.5)*(delta_change_rate^delta_factor);
	delta_factor=delta_factor+sign((xd==x_old)-0.5);
	y(i)=y_old;
	x_old=xd;
end
end

% Simulation settings
tStart=0;
tStop=0.002;
Fs=48*10^3;
delta=0.3;
SNR=20;

% Calculate
Ts=1/Fs;
t=tStart:Ts:tStop;

% Perform adaptive delta modulation and demodulation
xt_sig=awgn(sin(2*pi*1000*t)+sin(2*pi*1500*t)+sin(2*pi*2000*t),20);
yt_sig=AdaptiveMod(xt_sig, delta, 0, 1.2);
yr_sig=awgn(yt_sig, SNR);
xr_sig=AdaptiveDemod(yr_sig, delta, 0, 1.2);

% Plot results
subplot(2,2,1);
plot(t, xt_sig, 'b');
ylim([-4 4]);
title('Message Signal');
xlabel('Time Axis')
ylabel('Amplitude')
subplot(2, 2, 2);
stairs(t, yt_sig);
ylim([-0.5 1.5]);
title('Adaptive Delta Modulation bits (Tx)');
xlabel('Time Axis')
ylabel('Amplitude')
subplot(2, 2, 3);
stairs(t, yr_sig);
title('Adaptive Delta Modulation bits (Rx)');
xlabel('Time Axis')
ylabel('Amplitude')
subplot(2, 2, 4);
plot(t, xt_sig, 'b');
hold on;
stairs(t, xr_sig, 'r');
ylim([-4 4]);
title('Adaptive Delta Demodulated Signal Comparision (delta = 0.3)');
xlabel('Time Axis')
ylabel('Amplitude')
