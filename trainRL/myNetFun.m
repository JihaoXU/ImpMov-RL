function velocity = myNetFun(position)
persistent myNet
if isempty(myNet)
	myNet = coder.loadDeepLearningNetwork('myNet.mat','myNet');
end
velocity = predict(myNet,position);
end
