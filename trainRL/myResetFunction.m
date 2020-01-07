function [InitialObservation, LoggedSignals] = myResetFunction()
% Reset function to place custom cart-pole environment into a random
% initial state.
%constants
%position
x1=4.88+0.2*(rand()-0.5);
x2=-2.48+0.2*(rand()-0.5);
x3=2.59+0.2*(rand()-0.5);

% Return initial environment state variables as logged signals.
LoggedSignals.State = [x1;x2;x3];
InitialObservation = LoggedSignals.State;
end
