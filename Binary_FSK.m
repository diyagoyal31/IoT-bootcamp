% Binary FSK Modulation and Demodulation
clear all;
clc;
N=10;
disp('input message sequence:')
n=randi([0 1],1,N)
%Bit to symbol mapping-Unipolar NRZ
for ii=1:N
    if n(ii)==1
        nn(ii)=1;
    else
        nn(ii)=0;
    end
end
% Unipolar NRZ Signal
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
figure(1)
subplot(411);
plot(t,m,'r');
xlabel('Time');
ylabel('Amplitude');
title('Unipolar NRZ message signal')
%Carrier signal generation
c1=cos(2*pi*1*t);%Carrier1
c2=cos(2*pi*3*t);%Carrier2
%Plotting Carrier-1
subplot(412);
plot(t,c1,'k');
xlabel('Time');
ylabel('Amplitude');
title('Carrier Signal-1');
%Plotting Carrier-2
subplot(413);
plot(t,c2,'k');
xlabel('Time');
ylabel('Amplitude');
title('Carrier Signal-2');
%FSK Signal Generation
for i=1:length(t)
    if m(i)==1
        x(i)=c1(i);
    else
        x(i)=c2(i);
    end
end

subplot(414);
plot(t,x,'r');
xlabel('Time');
ylabel('Amplitude');
title('Binary FSK modulated Signal');

%Coherent Detection
y=x; % No Noise
%Product modulator outputs 
y1=y.*c1;
%Integrator-1 output
int_op1=[];
for ii=0:s:length(y1)-s
    int_o=(1/s)*trapz(y1(ii+1:ii+s));
    int_op1=[int_op1 int_o];
end
y2=y.*c2;
%Integrator-2 output
int_op2=[];
for ii=0:s:length(y2)-s
       int_o=(1/s)*trapz(y2(ii+1:ii+s));
    int_op2=[int_op2 int_o];
end

%Hard Decision decoding
disp('Detected bits:');
l=int_op1-int_op2;
det_bits=(l>0)   
%BER Computation
ber=sum(n~=det_bits)/N
