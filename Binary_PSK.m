% Binary PSK Modulation and Demodulation
clear all;
clc;
N=10;
n=randi([0 1],1,N);
%Bit to symbol mapping-polar NRZ
for ii=1:N
    if n(ii)==0
        nn(ii)=-1;
    else
        nn(ii)=1;
    end
end
% polar NRZ Signal
s=100;      %no.of sample to represent each bit
i=1; % index of input bit
t=0:1/s:N; %Time
for j=1:length(t)   
    if t(j)<=i
        m(j)=nn(i);
    else
        m(j)=nn(i);
        i=i+1;
    end
end
subplot(411);
plot(t,m,'r');
xlabel('Time');
ylabel('Amplitude');
%Carrier signal generation
c=cos(2*pi*2*t);
subplot(412);
plot(t,c,'k');
xlabel('Time');
ylabel('Amplitude');
title('Carrier Signal');
x=m.*c;
subplot(413);
plot(t,x,'g');
xlabel('Time');
ylabel('Amplitude');
title('PSK modulated Signal');
% hold on
% plot(t,m,'r');
%Coherent Detection
y=x; % No Noise
%Product modulator
y1=y.*c;
%Product modulator output
subplot(414);
plot(t,y1,'g');
xlabel('Time');
ylabel('Amplitude');
title('Product modulator Output');
%Reconstruction
%Integrator
int_op=[];
for ii=0:s:length(y1)-s
    int_o=(1/s)*trapz(y1(ii+1:ii+s));
    int_op=[int_op int_o];
end
%Decision Device
Th=0; % Threshold for ASK
disp('Detected bits:');
det_bits=(round(int_op,1)>=Th)   
%BER Computation
ber=sum(n~=det_bits)/N
