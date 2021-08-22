%Octave simulation code for TDM and PCM
%Name: Rishabh Panda
%Roll: 1904215

clear all
pkg load signal
% generation of TDM
fs = 1000;
f0=50;w=0.005;t=0:1/fs:1;
x1=pulstran(0:1/fs:1, 0:1/f0:1, "rectpuls", w);
x2=0.5*pulstran(0:1/fs:1, 0.01:1/f0:1, "rectpuls", w);
y1=20*sin(2*pi*2*t);
y2=20*sin(2*pi*4*t);
subplot(4,1,1);
plot(t,y1,t,y2);
title('Message Signal (1904215)');
xlabel('Time Axis');
ylabel('Amplitude');
subplot(4,1,2);
plot(t,x1,t,x2);
title('Pulse Train Signal (1904215)');
xlabel('Time Axis');
ylabel('Amplitude');
Pam1=x1.*y1;
Pam2=x2.*y2;
y3=Pam1+Pam2;
subplot(4,1,3);
plot(t,y3);
title('Time Division Multiplexing (1904215)');
xlabel('Time Axis');
ylabel('Amplitude');
subplot(4,1,4);
plot(t,Pam1,t,Pam2);
title('PAM Signal (1904215)');
xlabel('Time Axis');
ylabel('Amplitude');
d1=y3.*x1;
[b,a]=butter(5,0.02);
s1=filter(b,a,d1);
figure;
subplot(2,1,1);
plot(t,s1);
title('Demodulation1 (1904215)');
xlabel('Time Axis');
ylabel('Amplitude');
d2=y3.*x2;
[b,a]=butter(5,0.02);
s2=filter(b,a,d2);
subplot(2,1,2);plot(t,s2);
title('Demodulation2 (1904215)')
xlabel('Time Axis');
ylabel('Amplitude');

% Generation of PCM
% PCM signal generation
f=2;
a=3;
fs=20*f;
t= 0:1/fs:2;
x=a*sin(2*pi*f*t);
subplot(4,1,1)
plot(t,x)
title ('Analog signal (1904215)');
xlabel('Time Axis');
ylabel('Amplitude');
subplot(4,1,2)
stem(t,x);

% level shifting
x1=x+a;
l=length(x1);
% quantization
q_op=round(x1);
% encoder
enco= dec2bin(q_op);
k=1;
code=zeros(1,l);
for i=1:l
for j=1:3
code(k)= enco(i,j)-48;
k=k+1;
end
end
subplot(4,1,3),stairs(code);
axis([0 243 0 2]);
title('Encoded Signal (1904215)');
xlabel('Time Axis');
ylabel('Amplitude');
% receiver
deco= bin2dec(enco);
% shifting amplitude level
xr=deco-a;
%plotting
subplot(4,1,4)
plot(t,x,'b',t,xr,'r')
title('Decoded Signal (1904215)')
xlabel('Time Axis');
ylabel('Amplitude');