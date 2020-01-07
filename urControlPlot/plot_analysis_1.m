clc;
clear all;
close all;
load('goal.mat')
goal=goal*100;
figure

file_pose1="DS_myNet_data_1.mat";
load(file_pose1);
pose=pose-goal;
h1=plot3(pose(:,1),pose(:,2),pose(:,3),'b','LineWidth',1.5);hold on;


file_pose1="DS_newPolicy_data_1.mat";
load(file_pose1);
pose=pose-goal;
h2=plot3(pose(:,1),pose(:,2),pose(:,3),'r','LineWidth',1.5);
myPoint(goal-goal,[0 0 0])

grid on;
xlabel('x (mm)');
ylabel('y (mm)');
zlabel('z (mm)');
legend([h1 h2],'Learned trajectory','Imporved trajectory','Location','Best');
set(gca,'FontSize',14,'Fontname','Times New Roman');
box on;
grid on;