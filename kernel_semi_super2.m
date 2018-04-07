function [error HI MI Jac FM SS DB CH Dunn KL Ha RS CA RI AR]=Kernel_semi_super2(t_data,t_label,train_task_index,u_data,u_label,ul_task_index,nchild1)


    m=1
    
    parameter_dim=4;
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
        ln_theta(parameter_dim,i)=log(mean(pdist([t_data(index1,:);u_data(index2,:)])));
        label_index{i}=index1;
        unlabel_index{i}=index2;
        tmp=ConstructWeightedNNGraph2([t_data(index1,:);u_data(index2,:)],K,t_label(:,i),nchild1);
        Laplacian{i}=diag(tmp*ones(size(tmp,1),1))-tmp;
        clear index1 index2 tmp;
    end
    m_theta=mean(exp(ln_theta),2);
    Cov_theta=cov(exp(ln_theta)')+10^(-4)*eye(parameter_dim);
    max_iteration=20;
    for t=1:max_iteration
       % Update theta and sigma
        [ln_sigma,ln_theta,ln_alpha] = opt_p(t_data,t_label,u_data,label_index,unlabel_index,Laplacian,m_theta,Cov_theta,ln_sigma,ln_theta,ln_alpha);
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
  % for i=1:m
   
        index1=label_index{1};
        index2=unlabel_index{1};
        subdata=[t_data(index1,:);u_data(index2,:)];
        alpha=exp(ln_alpha(1));
        original_Km=CalculateKernelMatrix1(subdata,subdata,theta);
        CoeffMatrix=pinv(eye(size(subdata,1))/alpha+Laplacian{1}*original_Km)*Laplacian{1};
        Km=CalculateKernelMatrix2(t_data(index1,:),t_data(index1,:),theta(:,1),original_Km(:,1:length(index1)),original_Km(:,1:length(index1)),CoeffMatrix);
        Ky=pinv(Km+sigma^2*eye(length(index1)))*t_label(index1);
       %% extra code
      data=subdata,n=length(index1),theta=theta(:,1),train_Km=original_Km(:,1:length(index1)),ts_data=u_data(index2,:),ts_label=u_label(index2)
      %data=subdata,n=length(index1),theta=theta(:,i),train_Km=original_Km(:,1:length(index1)),ts_data=X,ts_label=y

   original_Km=CalculateKernelMatrix1(data,ts_data,theta);
    Km=CalculateKernelMatrix2(ts_data,data(1:n,:),theta,original_Km,train_Km,CoeffMatrix);
    predict=Km*Ky;
    pre=round(predict)
   % error=(ts_label-predict')*(ts_label'-predict)/(var(ts_label)*length(ts_label));
   ACTUAL=ts_label,PREDICTED=pre
    error=(ts_label'-predict')*(ts_label-predict)/(var(ts_label)*length(ts_label));
        %Ky=pinv(Km+sigma^2*eye(length(index1)))*t_label(index1)';
        %%end of extra code
        clear Km;
       % tranductive_error(i)=Prediction(subdata,length(index1),Ky,theta(:,i),original_Km(:,1:length(index1)),CoeffMatrix,u_data(index2,:),u_label(index2));
       %inductive_error(i)=Prediction(subdata,length(index1),Ky,theta(:,i),original_Km(:,1:length(index1)),CoeffMatrix,ts_data{i},ts_label{i});
dtype=1;
[DB, CH, Dunn, KL, Ha] = ...
valid_internal_deviation(ts_data,PREDICTED, dtype);

% computing R-Squared

   if dtype == 1
     [St,Sw,Sb] = valid_sumsqures(ts_data,PREDICTED,1+1);
   else
     [St,Sw,Sb] = valid_sumpearson(ts_data,PREDICTED,1+1);
   end
   sst = trace(St);
   ssb = trace(Sb);
   RS = ssb/sst;




%silhouette Score
 R = 'euclidean';
SS = mean(silhouette(ts_data, PREDICTED, R))

%[CA,RI,AR,HI] = compute_clustering_performance(idx_multi,l);
[CA,RI,AR,HI,MI,Jac,FM] = compute_clustering_performance(PREDICTED,ts_label);
 %[CA,RI,SI] = compute_clustering_performance(fiI,lt);
fprintf(1,'\nour clustering performance:\n CA = %.2f, RI = %.2f, AR = %.2f, HI = %.2f, MI = %.2f ,  Jac = %.2f , FM = %.2f, SS=%.2f, DB=%2f, CH=%.2f, Dunn=%.2f, KL=%.2f  Ha=%.2f and RS=%.2f\n',...
    CA,RI,AR,HI,MI,Jac,FM,SS,DB,CH,Dunn,KL,Ha,RS);
%fprintf(1,'\nour clustering performance:\n CA = %.2f, RI = %.2f, AR = %.2f,HI = %.2f and \n',...
 %   CA,RI,AR,HI);
%csvwrite('wine_ker.csv',idx_multi)
%population_init=[error HI MI Jac FM SS DB CH Dunn KL Ha RS CA RI AR ];
%nbytes = fprintf(fileID,' %f %d %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n',population_init);

