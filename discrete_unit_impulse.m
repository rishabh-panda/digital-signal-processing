clc;
clear all;
close all;

n= -10:1:10;
x1= [zeros(1,10), 1, zeros(1,10)];
stem(n,x1);
xlabel('Time--->');
ylabel('Amplitude--->');
title('Discrete Unit Impulse Function');