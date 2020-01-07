function [NextObs,Reward,IsDone,LoggedSignals] = myStepFunction(Action,LoggedSignals)
% Custom step function to construct cart pole environment for the function
% name case.
% This function applies the given action to the environment and evaluates
% the system dynamics for one simulation step.

% Define the environment constants.
% Sample time
Ts = 0.02;

% Check if the given action is valid
Velocity = Action;
dx1=Velocity(1);
dx2=Velocity(2);
dx3=Velocity(3);
V=[dx1;dx2;dx3];
% Unpack the state vector from the logged signals
State = LoggedSignals.State;
x1_=State(1);
x2_=State(2);
x3_=State(3);
% Euler integration
LoggedSignals.State = State + Ts*V;

% Transform state to observation
NextObs = LoggedSignals.State;

% Check terminal condition
LX=norm([x1_;x2_;x3_])^2;
LV=norm(V)^2;

C2=1e-1;

L=LX+C2*LV;
U=myNetFun([x1_;x2_;x3_])';

Reward = -L+1*(cosVU(V,U)-1)+((L<0.1)-1)-0.1;

IsDone = L<0.05;
if IsDone
    Reward = Reward+300;
end

end

function y=cosVU(v,u)
    y=dot(v,u)/(norm(v)*norm(u)+eps);
end