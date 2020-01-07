function action1 = newPolicy(observation1)
%#codegen

% Reinforcement Learning Toolbox
% Generated on: 07-Jan-2020 14:38:08

action1 = localEvaluate(observation1);
end
%% Local Functions
function action1 = localEvaluate(observation1)
persistent policy
if isempty(policy)
	policy = coder.loadDeepLearningNetwork('agentData.mat','policy');
end
action1 = predict(policy,observation1);
end