function error=Prediction(traindata,Ky,theta,testdata,testlabel)
    Km=CalculateKernelMatrix1(testdata,traindata,theta);
    predict=Km*Ky;
    error=(testlabel-predict')*(testlabel'-predict)/(var(testlabel)*length(testlabel));
    clear Km traindata Ky theta testdata testlabel;
    
    
    
    %Km=CalculateKernelMatrix1(testdata,traindata(index,:),theta);
    
    

    
    
    
    
    
    
    