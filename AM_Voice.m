clc; 
close all; 
clear all;
A=input('Enter the Amplitude of the carrier Wave: ');
Fc=input('Enter the carrier frequency: ');      % hertz 
Fs=input('Enter the sampling frequency: ');
x = input('Enter the recording Time: ');  
Order=input('Enter the order of the Filter: ');
dt = 1/Fs;                               % seconds per sample
StopTime = x;            
t = (0:dt:StopTime-dt)'; 
N=size(t,1);
%% Signal Wave
recObj = audiorecorder(Fs,8,1);         
disp('Start speaking.')
recordblocking(recObj, x);
disp('End of Recording.');
Input_Signal=(getaudiodata(recObj))';
%% Filtering out the Signal to desired Frequency
beginFreq = 1000 / (Fs/2);
endFreq = 4000 / (Fs/2);
[b,a] = butter(Order, [beginFreq, endFreq], 'bandpass');
%% Bandpass filter design
Signal = filter(b, a, Input_Signal);
%% Carrier Wave
Carrier = (A*cos(2*pi*Fc*t)');
%% Signal Modulation
Modulated = Signal.*Carrier;
%% Designing Of Bandpass filter for Demodulation
Freq1 = 20 / (Fs/2);
Freq2 = Fc / (Fs/2);
[num,den] = butter(Order,[Freq1,Freq2],'bandpass');   
%% Demodulation of Signal
Demodulated = filter(num,den,Modulated);
Demodulated1 = 2*Demodulated.*Carrier;
[e,f] = butter(Order*2,(Fc/2)/Fs,'low');
Demodulated2 = filter(e,f,Demodulated1);
%% Plotting Of Carrier Wave
subplot(221)                                              
plot(t(1:100),Carrier(1:100));
title('Time Domain Representation of Carrier Wave');  
xlabel('Time');
ylabel('Magnitude');  
%% Plotting Of Signal
subplot(222) 
plot(t,Signal);
title('Time Domain Representation of Signal');  
xlabel('Time');
ylabel('Magnitude'); 
%% Plotting Of Modulated Signal
subplot(223)       
plot(t,Modulated)
title('Modulated Signal');  
xlabel('Time');
ylabel('Magnitude'); 
%% Plotting Of Demodulated Signal
subplot(224) 
plot(t,Signal,'r')
title('Demodulated Signal');  
xlabel('Time');
ylabel('Magnitude'); 
%% Frequency Domain Analysis
fCarrier = (fftshift(fft(Carrier)));
fSignal = (fftshift(fft(Signal)));
fMod = (fftshift(fft(Modulated)));
fDemod = (fftshift(fft(Demodulated2)));
freq = -Fs/2:(Fs/N):(Fs/2)-(Fs/N);
%% Ploting Of Frequencies of the Signal
figure 
subplot(221)
plot(freq,abs(fCarrier)/N);
title('F-Domain Carrier Wave');  
xlabel('Frequency');
ylabel('Magnitude');
subplot(222)
plot(freq,abs(fSignal)/N);
title('F-Domain Signal');  
xlabel('Frequency');
ylabel('Magnitude');
subplot(223)
plot(freq,abs(fMod)/N)
title('F-Domain Modulated Signal');  
xlabel('Frequency');
ylabel('Magnitude');
subplot(224)
plot(freq,abs(fDemod)/N);
title('F-Domain Demodulated Signal');  
xlabel('Frequency');
ylabel('Magnitude');
%% Verifying the output
disp('The original Signal.');
sound(Signal,Fs,8);
pause(5);
disp('The Demodulated Signal.');
sound(Demodulated2,Fs,8)