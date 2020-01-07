clc;
clear all;
load('trainSet.mat');
X=[Xtrain dXtrain];
clear Xtrain dXtrain;

[n1, ~] = size(X);
R = randperm(n1);
numVal=floor(0.15*n1); % Validation
XVal = X(R(1:numVal),1:3);
dXVal = X(R(1:numVal),4:6);
R(1:numVal) = [];
XTrain = X(R,1:3);
dXTrain = X(R,4:6);
numTrain = size(XTrain,1);
clear X;
XVal=myReshape(XVal);
XTrain=myReshape(XTrain);

AhiddenLayerSize = 64; 
layers = [
    imageInputLayer([3 1 1],"Name","position",'Normalization','none')
    fullyConnectedLayer(AhiddenLayerSize,"Name","fc_1")
    reluLayer("Name","relu_1")
    fullyConnectedLayer(AhiddenLayerSize,"Name","fc_2")
    reluLayer("Name","relu_2")
    fullyConnectedLayer(AhiddenLayerSize,"Name","fc_3")
    reluLayer("Name","relu_3")
    fullyConnectedLayer(3,"Name","velocity")
    regressionLayer("Name","regressionoutput")];
%plot(layerGraph(layers));

miniBatchSize  = 256;
validationFrequency = floor(numTrain/miniBatchSize);
options = trainingOptions('adam', ...
    'MiniBatchSize',miniBatchSize, ...
    'MaxEpochs',500, ...
    'InitialLearnRate',2e-2, ...
    'GradientDecayFactor',0.99,...
    'SquaredGradientDecayFactor',0.999,...
    'Epsilon' ,1e-9,...
    'ValidationData',{XVal,dXVal}, ...
    'ValidationFrequency',validationFrequency, ...
    'Plots','training-progress', ...
    'Verbose',false);
%% train the network
myNet1 = trainNetwork(XTrain,dXTrain,layers,options);

% save('myNet.mat','myNet');



