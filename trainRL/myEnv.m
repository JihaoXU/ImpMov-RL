clc;
clear all;
close all;
%% Observation and Action Specifications
Min_X=-10;Max_X=10;
ObservationInfo = rlNumericSpec([3 1],'LowerLimit',Min_X,'UpperLimit',Max_X);
ObservationInfo.Name = 'position';
ObservationInfo.Description = 'x1, x2, x3';

Max_V=5;
ActionInfo = rlNumericSpec([3 1],'LowerLimit',-Max_V,'UpperLimit',Max_V);
ActionInfo.Name = 'velocity';
ActionInfo.Description = 'dx1, dx2, dx3';
%Create Environment using Function Names
env = rlFunctionEnv(ObservationInfo,ActionInfo,'myStepFunction','myResetFunction');
save('myEnv.mat','env');

obsInfo = getObservationInfo(env);
numObservations = obsInfo.Dimension(1);
actInfo = getActionInfo(env);
numActions = actInfo.Dimension(1);

%% Create DDPG agent
%create Critic
cHiddenLayerSize = 64; 
statePath = [
    imageInputLayer([numObservations 1 1],'Normalization','none','Name','position')
    concatenationLayer(1,2,'Name','concat')
    fullyConnectedLayer(cHiddenLayerSize,'Name','fc1')
    reluLayer('Name','relu1')
    fullyConnectedLayer(cHiddenLayerSize,'Name','fc2')
    reluLayer('Name','relu2')
    fullyConnectedLayer(cHiddenLayerSize,'Name','fc3')
    reluLayer('Name','relu3')
    fullyConnectedLayer(1,'Name','fc4')];
actionPath = [imageInputLayer([numActions 1 1],'Normalization','none','Name','velocity')];
% create the layerGraph
criticNetwork = layerGraph(statePath);
criticNetwork = addLayers(criticNetwork,actionPath);
% connect actionPath to obervationPath
criticNetwork = connectLayers(criticNetwork,'velocity','concat/in2');

criticOpts = rlRepresentationOptions('LearnRate',1e-4,'GradientThreshold',1);
criticOpts.UseDevice='gpu';
critic = rlRepresentation(criticNetwork,obsInfo,actInfo,'Observation',{'position'},'Action',{'velocity'},criticOpts);
% figure
% plot(criticNetwork)

%create Actor
load('myNet.mat');
actorLayer=myNet.Layers(1:8,1);

actorLayer(8).WeightLearnRateFactor=10;
actorLayer(8).BiasLearnRateFactor=10;

actorNetwork = layerGraph(actorLayer);

actorOpts = rlRepresentationOptions('LearnRate',1e-6,'GradientThreshold',1);
actorOpts.UseDevice='gpu';
actor = rlRepresentation(actorNetwork,obsInfo,actInfo,'Observation',{'position'},'Action',{'velocity'},actorOpts);
% figure
% plot(actorNetwork)

%create Agent
agentOpts = rlDDPGAgentOptions(...
    'SampleTime',0.02,...
    'TargetSmoothFactor',1e-3,...
    'ExperienceBufferLength',3e5,...
    'DiscountFactor',0.99,...
    'MiniBatchSize',512);
agentOpts.NoiseOptions.Variance = 0.3;
agentOpts.NoiseOptions.VarianceDecayRate = 1e-5;
agent = rlDDPGAgent(actor,critic,agentOpts);

%% Train Agent
trainOpts = rlTrainingOptions(...
    'MaxEpisodes',500, ...
    'MaxStepsPerEpisode', 300, ...
    'Verbose', false, ...
    'Plots','training-progress',...
    'StopTrainingCriteria','AverageReward',...
    'ScoreAveragingWindowLength',5,...
    'StopTrainingValue',0,...
    'SaveAgentCriteria','EpisodeReward',...
    'SaveAgentValue',-1200);

doTraining =false;
if doTraining
    % Train the agent.
    trainingStats = train(agent,env,trainOpts); 
    save('myAgent.mat','agent','trainingStats');
    generatePolicyFunction(agent,'FunctionName','newPolicy');
else
    % Load pretrained agent for the example.
    load('myAgent.mat');
    generatePolicyFunction(agent,'FunctionName','newPolicy');
end
% simOptions = rlSimulationOptions('MaxSteps',360);
% experience = sim(env,agent,simOptions);
% totalReward = sum(experience.Reward)
% plot(-1*experience.Reward)