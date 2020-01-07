clc;
clear all;
close all;

load('savedAgents/Agent450');
generatePolicyFunction(saved_agent,'FunctionName','newPolicy');

figure;
x_d=[0; 0; 0];
myPlot(x_d,sqrt(0.03));
hold on;
grid on;

C2=1e-1;

x1=4.88+0.1*randn();
x2=-2.48+0.1*randn();
x3=2.59+0.1*randn();
X=[x1;x2;x3];
Y=X;
dt=0.1;

plot3(X(1),X(2),X(3),'ro','MarkerSize',2);hold on;
plot3(Y(1),Y(2),Y(3),'b*','MarkerSize',2);

x_rec=[];
y_rec=[];
for i=1:300
    Vx=newPolicy(X-x_d)';
    X=X+Vx/5*dt;
    Vy=myNetFun(Y-x_d)';
    Y=Y+Vy*dt;
    
    plot3(X(1),X(2),X(3),'ro','MarkerSize',2);
    plot3(Y(1),Y(2),Y(3),'b*','MarkerSize',2);
    pause(0.03);
    
    IsDone1(i,1) = (norm(X-x_d)^2+C2*norm(Vx)^2)<0.03;
    IsDone2(i,1) = (norm(Y-x_d)^2+C2*norm(Vy)^2)<0.03;
    
    if IsDone1(i,1)
        break;
    end
    
    x_rec=[x_rec;X' Vx'/5];
    y_rec=[y_rec;Y' Vy'];
    
    r1(i)=sum(X.^2+C2*Vx.^2);
end
plot3([x_d(1) x1],[x_d(2) x2],[x_d(3) x3],'k')
hold off;

% figure
% plot(r1,'b');





