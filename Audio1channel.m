%%Author: Rishabh Panda
%%Dual Channel Audio Signal Processing

%sampling frequency
fs=5*10^3;

%number of channels
channels=1;

%number of bits: required to store each sample
bits=16;

%initialization of recording
r=audiorecorder(fs,bits,channels);

%time duration of recorded audio in seconds
duration=7;
disp('recording started');

%record blocking after the duration ends
recordblocking(r,duration);
disp('recording stopped');

%audio data extraction
x=getaudiodata(r);

%sends audio signal X to the speaker: Output
sound(x,fs,bits);

%defining time period
t=0:1/fs:(length(x)-1)/fs;

%plotting in time domain
subplot(3,1,1);
plot(t,x,'LineWidth',1.5);
xlabel('time (sec)');
ylabel('amplitude');
title('Audio Rec. (Time Domain)');
grid on;

%number of audio samples
n=length(x);

%defining frequency
f=0:(n-1)*fs/n;

%computing n-point DFT of x using a FFT algorithm
y=fft(x,n);
f_=(-n/2:n/2-1).*(fs/n);

%shifting the zero frequency components to the centre of spectrum
y_=fftshift(y);
ay_=abs(y_);

%plotting in frequency domain
subplot(3,1,2);
plot(f_,ay_,'LineWidth',1.5);
xlabel('frequency (Hz)');
ylabel('amplitude');
title('Audio Rec. (Frequency Domain)');
grid on;

%plotting periodogram
w=hanning(n, 'periodic');
subplot(3,1,3);
periodogram(x, w, n, fs, 'power');
grid on;
