clear all
clc;
[y,Fs] = audioread('Recording.m4a');
sound(y,Fs);
plot(y);
