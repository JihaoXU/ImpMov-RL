clc;
clear all;
close all;
load('goal.mat')
goal=goal*100;
xd=[0,0,0;
    0.5,0,0;
    -0.5,0,0;
    0,0.5,0;
    0,-0.5,0;];
xd=xd*100;
figure
for i=1:5    
    file_pose1="DS_myNet_data_"+num2str(i)+".mat";
    load(file_pose1);
    pose=pose-goal;
    h1=plot3(pose(:,1),pose(:,2),pose(:,3),'b','LineWidth',1);hold on;
end

for i=1:5
    file_pose2="DS_newPolicy_data_"+num2str(i)+".mat";
    load(file_pose2);
    pose=pose-goal;
    h2=plot3(pose(:,1),pose(:,2),pose(:,3),'r','LineWidth',1);hold on;
    g(i,:)=goal-goal+xd(i,:);
    myPoint(g(i,:),[0 0 0]);
end
myPoint(goal-goal,[0 0 0])

plot3(g(2:3,1),g(2:3,2),g(2:3,3),'k');
plot3(g(4:5,1),g(4:5,2),g(4:5,3),'k');
hold off;
xlabel('x (mm)');
ylabel('y (mm)');
zlabel('z (mm)');
legend([h1 h2],'Learned trajectory','Imporved trajectory','Location','Best');
set(gca,'FontSize',14,'Fontname','Times New Roman');
box on;
grid on;