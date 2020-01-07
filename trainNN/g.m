function [X]=g(x0)
dt=0.02;
x=x0;
X=[x];

for i=1:300
    dx=myNetFun(x');
    x=x+dx*dt;
    X=[X;x];
end
end

