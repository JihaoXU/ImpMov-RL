clc
clear all;
close all;
load('goal.mat');

N=4
xd=[0,0,0;
    0.5,0,0;
    -0.5,0,0;
    0,0.5,0;
    0,-0.5,0;];

path="../urControl/";
file_pose=path+"DS_myNet_Pose_"+num2str(N)+".csv";

pose=csvread(file_pose,1,1);
rowNum=size(pose,1);
time=csvread(file_pose,1,0,[1 0 rowNum 0]);

pose=pose(:,1:3);
pose=pose*1000;

figure;
scatter3(pose(1,1),pose(1,2),pose(1,3),'r*');hold on;
scatter3(pose(end,1),pose(end,2),pose(end,3),'ro');
plot3(pose(:,1),pose(:,2),pose(:,3),'b');
grid on;
xlabel('x');
ylabel('y');
zlabel('z');
title('pose')

dataName="DS_myNet_data_"+num2str(N)+".mat";
% save(dataName,'pose','time');

% endPose=pose(end,:);
% goal=(goal+xd(N,:))*100;
% 
% Error=norm(endPose-goal)
% dt=mean(diff(time))
% endTime=time(end)