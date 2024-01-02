clc;
clear all;
close all;
ac=1;
am=4;
fm=2;
fc=20;
ka=0.5;
t=0:0.001:1;
m_t=am*cos(2*pi*fm*t);
subplot(311);
plot(t,m_t);
c_t=ac*cos(2*pi*fc*t);
subplot(312);
plot(t,c_t);
s_t=ac.*(1+ka*am.*cos(2*pi*fm*t)).*cos(2*pi*fc*t);
subplot(313);
plot(t,s_t);
hold on
plot(t,1+0.5*m_t,'k--');
plot(t,-1-0.5*m_t,'k--');
plot(t,s_t);
hold off
