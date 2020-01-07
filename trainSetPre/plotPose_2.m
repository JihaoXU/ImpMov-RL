clc
clear all;
close all;

N=1

fileName="data_"+num2str(N)+".mat";
load(fileName)

figure
subplot(3,1,1)
plot(time,pose(:,1),'r');
title('x / mm');
subplot(3,1,2)
plot(time,pose(:,2),'g');
title('y / mm');
subplot(3,1,3)
plot(time,pose(:,3),'b');
title('z / mm');
xlabel('time / s')
