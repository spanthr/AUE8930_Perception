%% Problem 01
clc
clear all
close all
Fs=1000                                                                     %Sampling freq.
dt=1/Fs                                                                      % Sampling time

time=0:dt:0.1
time_data=2+ 3*cos(500*pi*time) + 2*cos(1000*pi*time) + 3*sin(2000*pi*time)
figure()
plot(time,time_data)
title('SIgnal visualization in Time Domain')
xlabel('Time in sec')
ylabel('Amplitude')

%% Problem 1 part 2 Fourier Transform of the function
freq= abs(fft(time_data));
figure()
plot(freq)
title('Singal visualization in Frequency Domain')
xlabel('Frequency in Hertz')
ylabel('Amplitude')
