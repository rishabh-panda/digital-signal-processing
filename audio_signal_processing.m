%sampling frequency
fs=4000;

%number of channels
channels=1;

%number of bits
bits=16;

%initialization
r=audiorecorder(fs,bits,channels);

%time duration of recorded audio
duration=10;
disp('recording started');

%record blocking
recordblocking(r,duration);
disp('recording stopped');

%data extraction
x=getaudiodata(r);
sound(x,fs,bits);

%defining time period
t=0:1/fs:(length(x)-1)/fs;
subplot(2,1,1);
plot(t,x,'LineWidth',1.5);
xlabel('time (sec)');
ylabel('amplitude');
title('Audio Rec. (Time Domain)');

%number of audio samples
n=length(x);

%defining frequency
f=0:(n-1)*fs/n;

%application of fft
y=fft(x,n);
f_0=(-n/2:n/2-1).*(fs/n);
y_0=fftshift(y);
ay_0=abs(y_0);
subplot(2,1,2);
plot(f_0,ay_0,'LineWidth',1.5);
xlabel('frequency (Hz)');
ylabel('amplitude');
title('Audio Rec. (Frequency Domain)');
