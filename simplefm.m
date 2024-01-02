clc;
clear all;
close all;
ac=1;
am=1;
fm=2;
fc=20;
B=5;
t=0:0.001:1;
m_t=am*cos(2*pi*fm*t);
subplot(311);
plot(t,m_t);
c_t=ac*cos(2*pi*fc*t);
subplot(312);
plot(t,c_t);
s_t=ac.*cos(2*pi*fc*t+B.*sin(2*pi*fm*t));
subplot(313);
plot(t,s_t);
hold on
plot(t,m_t);
hold off

