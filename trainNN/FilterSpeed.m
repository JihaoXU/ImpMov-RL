clc 
clear all;

N=1

dataName="data_"+num2str(N)+".mat";
load(dataName);

Ts=mean(diff(time));
Fs=1/Ts;
%% filter pose data by sptool 
%sptool
%%

pose2=sig2.data;
pose2=pose2(21:end,:);
speed2=(pose2(2:end,:)-pose2(1:end-1,:))*Fs;

pose2=pose2(2:end,:);
pose2=pose2(11:end,:);
speed2=speed2(11:end,:);
dataName2="data2_"+num2str(N)+".mat";
% save(dataName2,'pose2','speed2');
%% 
figure;
plot(pose2);
figure;
plot(speed2)
