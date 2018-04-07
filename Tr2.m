function result=Tr2(A,traindata,uldata,theta,alpha,original_Km,coeffMatrix,Laplacian)
    derivation=KernelMatrixDerivation(traindata,uldata,theta,alpha,original_Km,coeffMatrix,Laplacian);
    result=zeros(size(derivation,3),1);
    for i=1:length(result)
        result(i)=trace(A*derivation(:,:,i));
    end
    clear derivation A traindata uldata theta alpha original_Km coeffMatrix Laplacian;
    
function derivation=KernelMatrixDerivation(traindata,uldata,theta,alpha,original_Km,coeffMatrix,Laplacian)
    n=size(traindata,1);
    para_no=length(theta);
    derivation=zeros(n,n,para_no+1);
    Coeff1=coeffMatrix*Laplacian;
    Coeff2=Coeff1*original_Km(:,1:n);
    clear Coeff1;
    tmp=traindata*[traindata;uldata]'*Coeff2;
    derivation(:,:,1)=traindata*traindata'-tmp-tmp'+Coeff2'*[traindata;uldata]*[traindata;uldata]'*Coeff2;
    clear tmp;
    disMatrix=CalPairwiseDis([traindata;uldata]);
    tmp=exp(-disMatrix(1:n,:)/(2*theta(3)^2))*Coeff2;
    derivation(:,:,2)=exp(-disMatrix(1:n,1:n)/(2*theta(3)^2))-tmp-tmp'+Coeff2'*exp(-disMatrix/(2*theta(3)^2))*Coeff2;
    clear tmp;
    tmp=theta(2)*theta(3)^(-3)*(exp(-disMatrix(1:n,:)/(2*theta(3)^2)).*disMatrix(1:n,:))*Coeff2;
    derivation(:,:,3)=theta(2)*theta(3)^(-3)*(exp(-disMatrix(1:n,1:n)/(2*theta(3)^2)).*disMatrix(1:n,1:n))-tmp-tmp'+Coeff2'*theta(2)*theta(3)^(-3)*(exp(-disMatrix/(2*theta(3)^2)).*disMatrix)*Coeff2;
    clear tmp;
    derivation(:,:,4)=-alpha^(-2)*original_Km(:,1:n)'*coeffMatrix*Coeff2;
    clear traindata uldata theta alpha original_Km coeffMatrix Laplacian Coeff2;