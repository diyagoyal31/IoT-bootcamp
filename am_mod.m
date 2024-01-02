fs=1000000;%Sampling Frequency
fm=2000;%Mesage signal frequency = 2KHz
fc=50000;%Carrier signal frequency = 50KHz
Am=1;
Ac=1;
t=[0:0.001*fs]/fs;
m=Am*cos(2*pi*fm*t);
c=Ac*cos(2*pi*fc*t);
ka=0.5; % amplitude sensitivity factor
u=ka*Am; % modulation index
s1=Ac*(1+u*cos(2*pi*fm*t)).*cos(2*pi*fc*t); % AM equation
subplot(3,1,1);
plot(t,m);
title('Modulating or Message signal(fm=2KHz)');
subplot(3,1,2);
plot(t,c);
title('Carrier signal(fc=50KHz)');
subplot(3,1,3);
hold on
plot(t,1+0.5*m,'k--');
plot(t,-1-0.5*m,'k--');
plot(t,s1);
title('Under Modulated signal(ka.Am=0.5)');
Am=2;
ka=0.5;
u=ka*Am;
s2=Ac*(1+u*cos(2*pi*fm*t)).*cos(2*pi*fc*t);
figure(2);
subplot(3,1,1);
plot(t,m);
title(' Modulating signal');
subplot(3,1,2);
plot(t,s2);
hold on
plot(t,1+m,'g--');
plot(t,-1-m,'g--');
title(' Exact Modulated signal(ka.Am= 1)');
Am=5;
ka=0.5;
u=ka*Am;
s3=Ac*(1+u*cos(2*pi*fm*t)).*cos(2*pi*fc*t);
subplot(3,1,3);
plot(t,s3);
hold on
plot(t,1+2.5*m,'r--');
plot(t,-1-2.5*m,'r--');
title('Over Modulated signal(ka.Am=2.5)');
% r1= s1.*c;
% [b a] = butter(2,0.01);
% mr1= filter(b,a,r1);
% subplot(3,1,3);
% plot(t,mr1);
% r2= s2.*c;

