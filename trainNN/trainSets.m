clc
clear all;

Num=6
x0=zeros(1,3);
goal=zeros(1,3);
for i=1:Num
    dataName="data2_"+num2str(i)+".mat";
    load(dataName);
    goal=goal+pose2(end,:);
    x0=x0+pose2(1,:);
end
goal=goal/Num;
x0=x0/Num-goal;
Xtrain=[];
dXtrain=[];
for i=1:Num
    dataName="data2_"+num2str(i)+".mat";
    load(dataName);
    pose2=pose2-goal;
    Xtrain=[Xtrain;pose2];
    dXtrain=[dXtrain;speed2];
end
Xtrain=Xtrain/100;
dXtrain=dXtrain/100;
goal=goal/100;
x0=x0/100;
% save('goal.mat','goal','x0')
% save('trainSet.mat','Xtrain','dXtrain');