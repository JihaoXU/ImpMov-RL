function Y=myReshape(X)
[n,~]=size(X);
Y=reshape(X',3,1,1,n);
end