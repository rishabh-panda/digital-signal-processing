t= 0:0.001:1;
A=1;
f=2;
x1=A*sin(2*pi*f*t);
subplot(2,2,1)
plot(t,x1);
xlabel('Time--->');
ylabel('Amplitude--->');
title('CT sine wave');

x2=A*cos(2*pi*f*t);
subplot(2,2,2)
plot(t,x2);
xlabel('Time--->');
ylabel('Amplitude--->');
title('CT Cosine wave');

x3=square(2*pi*f*t);
subplot(2,2,3)
plot(t,x3);
xlabel('Time--->');
ylabel('Amplitude--->');
title('CT Square wave');

x4=sawtooth(2*pi*f*t);
subplot(2,2,4)
plot(t,x4);
xlabel('Time--->');
ylabel('Amplitude--->');
title('CT triangular Signal');