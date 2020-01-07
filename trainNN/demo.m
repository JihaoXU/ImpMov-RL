clc;
clear all;
close all;

load('goal.mat');
load('trainSet.mat');

figure
%scatter3 the training set
myPoint([0,0,0],[0 0 0]);hold on;
h1=scatter3(100*Xtrain(:,1),100*Xtrain(:,2),100*Xtrain(:,3),4,'g*');

%predict trajectory
Xpre=g(x0);

for j=1:size(Xpre,1)
    h2=scatter3(100*Xpre(j,1,1),100*Xpre(j,2,1),100*Xpre(j,3,1),5,'bo');
    pause(0.001);
end
xlabel('x (mm)');
ylabel('y (mm)');
zlabel('z (mm)');
legend([h1 h2],'Demonstration trajectory','Learned trajectory','Location','Best');
set(gca,'FontSize',14,'Fontname','Times New Roman');
box on;
grid on;
hold off