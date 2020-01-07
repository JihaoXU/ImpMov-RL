clc
clear all;
close all;

N=1

path="../urControl/";
file_pose=path+"Pose_"+num2str(N)+".csv";

pose=csvread(file_pose,1,1);
rowNum=size(pose,1);
time=csvread(file_pose,1,0,[1 0 rowNum 0]);

pose=pose(:,1:3);
pose=pose*1000;


Lp=sqrt(sum(pose.^2,2));
Lp1=Lp-Lp(10);
Lp2=Lp-Lp(end);

i=100;
j=size(Lp,1);
while(1)
    if(Lp1(i)>1)
        break
    end
    i=i+1;
end

while(1)
    if(Lp2(j)>0.1)
        break
    end
    j=j-1;
end
j=min(j+35,rowNum);

pose=pose(i:j,:);
time=time(i:j,:)-time(i);

figure;
scatter3(pose(1,1),pose(1,2),pose(1,3),'r*');hold on;
scatter3(pose(end,1),pose(end,2),pose(end,3),'ro');
plot3(pose(:,1),pose(:,2),pose(:,3),'b');
grid on;
xlabel('x');
ylabel('y');
zlabel('z');
title('pose')


dataName="data_"+num2str(N)+".mat";
% save(dataName,'pose','time');