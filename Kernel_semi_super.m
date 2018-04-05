function [tranductive_error,inductive_error,model]=SSMTR(traindata,trainlabel,uldata,ullabel,testdata,testlabel)
%traindata: a cell array. Each cell in the array contains a training data 
%           matrix, each row of whom represents a training data point, for the corresponding task
%trainlabel: a cell array. Each cell in the array contains a row vector, 
%            each element of whom represents a label, for the corresponding task
%uldata: a cell array containing unlabeled data of the same format as 'traindata'
%ullabel: a cell array containing labels for unlabeled data of the same format as 'trainlabel'
%testdata: a cell array containing test data of the same format as 'traindata'
%testlabel: a cell array containing labels for test data of the same format as 'trainlabel'
%tranductive_error: the tranductive errors for all tasks
%inductive_error: the inductive errors for all tasks
%model: a struct variable containing all learned parameters
    m=length(traindata);
    [traindata,trainlabel,train_task_index]=PreprocessMTData(traindata,trainlabel);
    [uldata,ullabel,ul_task_index]=PreprocessMTData(uldata,ullabel);
    parameter_dim=3;
    ln_theta=zeros(parameter_dim,m);
    ln_alpha=log(ones(1,m)*0.1);
    ln_sigma=log(0.1);
    K=5;
    label_index=cell(1,m);
    unlabel_index=cell(1,m);
    Laplacian=cell(1,m);
    for i=1:m
        index1=sort(find(train_task_index==i));
        index2=sort(find(ul_task_index==i));
        ln_theta(parameter_dim,i)=log(mean(pdist([traindata(index1,:);uldata(index2,:)])));
        label_index{i}=index1;
        unlabel_index{i}=index2;
        tmp=ConstructWeightedNNGraph([traindata(index1,:);uldata(index2,:)],K,trainlabel(:,i));
        Laplacian{i}=diag(tmp*ones(size(tmp,1),1))-tmp;
        clear index1 index2 tmp;
    end
    m_theta=mean(exp(ln_theta),2);
    Cov_theta=cov(exp(ln_theta)')+10^(-4)*eye(parameter_dim);
    max_iteration=20;
    for t=1:max_iteration
        %Update theta and sigma
        [ln_sigma,ln_theta,ln_alpha] = optimizeParameters_2(traindata,trainlabel,uldata,label_index,unlabel_index,Laplacian,m_theta,Cov_theta,ln_sigma,ln_theta,ln_alpha);
        %Update m_theta and Cov_theta
        theta=exp(ln_theta);
        m_theta=mean(theta,2);
        Cov_theta=cov(theta');
        clear theta;
    end
    sigma=exp(ln_sigma);
    theta=exp(ln_theta);
    model.sigma=sigma;
    model.theta=theta;
    model.alpha=exp(ln_alpha);
    model.m_theta=m_theta;
    model.Cov_theta=Cov_theta;
    tranductive_error=zeros(1,m);
    inductive_error=zeros(1,m);
    for i=1:m
        index1=label_index{i};
        index2=unlabel_index{i};
        subdata=[traindata(index1,:);uldata(index2,:)];
        alpha=exp(ln_alpha(i));
        original_Km=CalculateKernelMatrix1(subdata,subdata,theta);
        CoeffMatrix=pinv(eye(size(subdata,1))/alpha+Laplacian{i}*original_Km)*Laplacian{i};
        Km=CalculateKernelMatrix2(traindata(index1,:),traindata(index1,:),theta(:,i),original_Km(:,1:length(index1)),original_Km(:,1:length(index1)),CoeffMatrix);
        Ky=pinv(Km+sigma^2*eye(length(index1)))*trainlabel(index1)';
        clear Km;
        tranductive_error(i)=Prediction(subdata,length(index1),Ky,theta(:,i),original_Km(:,1:length(index1)),CoeffMatrix,uldata(index2,:),ullabel(index2));
        inductive_error(i)=Prediction(subdata,length(index1),Ky,theta(:,i),original_Km(:,1:length(index1)),CoeffMatrix,testdata{i},testlabel{i});
        clear index1 index2 subdata original_Km CoeffMatrix Ky;
    end
    clear traindata trainlabel uldata ullabel testdata testlabel theta ln_theta Cov_theta m_theta label_index unlabel_index Laplacian;

function error=Prediction(data,n,Ky,theta,train_Km,CoeffMatrix,testdata,testlabel)
    original_Km=CalculateKernelMatrix1(data,testdata,theta);
    Km=CalculateKernelMatrix2(testdata,data(1:n,:),theta,original_Km,train_Km,CoeffMatrix);
    predict=Km*Ky;
    error=(testlabel-predict')*(testlabel'-predict)/(var(testlabel)*length(testlabel));
    clear Km traindata Ky theta testdata testlabel;