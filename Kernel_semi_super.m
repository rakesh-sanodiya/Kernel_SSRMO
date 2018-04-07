function [error]=Kernel_semi_super(t_data,t_label,u_data,u_label,ts_data,ts_label)

global centers population_init V M
fileID = fopen('K_M_IRIS3.csv','w');
 V=2
 M=4
 [t_data,t_label,train_task_index]=Convert_data(t_data,t_label);
    [u_data,u_label,ul_task_index]=Convert_data(u_data,u_label);
 for r = 1:1

    m=1
    
    p_d=4;
    ln_theta=zeros(p_d,m);
    ln_alpha=log(ones(1,m)*0.1);
    ln_sigma=log(0.1);
    K=50;
    label_index=cell(1,m);
    unlabel_index=cell(1,m);
    Laplacian=cell(1,m);
    for i=1:m
        index1=sort(find(train_task_index==i));
        index2=sort(find(ul_task_index==i));
        ln_theta(p_d,i)=log(mean(pdist([t_data(index1,:);u_data(index2,:)])));
        label_index{i}=index1;
        unlabel_index{i}=index2;
        tmp=ConstructWeightedNNGraph([t_data(index1,:);u_data(index2,:)],K,t_label(:,i),r);
        Laplacian{i}=diag(tmp*ones(size(tmp,1),1))-tmp;
        clear index1 index2 tmp;
    end
    m_theta=mean(exp(ln_theta),2);
    Cov_theta=cov(exp(ln_theta)')+10^(-4)*eye(p_d);
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
   
   ACTUAL=ts_label,PREDICTED=pre
    error=(ts_label'-predict')*(ts_label-predict)/(var(ts_label)*length(ts_label));
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


[CA,RI,AR,HI,MI,Jac,FM] = compute_clustering_performance(PREDICTED,ts_label);
 
fprintf(1,'\nour clustering performance:\n CA = %.2f, RI = %.2f, AR = %.2f, HI = %.2f, MI = %.2f ,  Jac = %.2f , FM = %.2f, SS=%.2f, DB=%2f, CH=%.2f, Dunn=%.2f, KL=%.2f  Ha=%.2f and RS=%.2f\n',...
    CA,RI,AR,HI,MI,Jac,FM,SS,DB,CH,Dunn,KL,Ha,RS);

population_init=[r error CA AR SS Dunn];
nbytes = fprintf(fileID,' %d %f %f %f %f %f \n',population_init);

 
 end
fclose(fileID);
File = csvread('K_M_IRIS3.csv');

[population front]=NDS_CD_cons(File);

csvwrite('K_M_S_IRIS.csv',population)

 


for r = 1:5
    fileID = fopen('K_M_IRIS.csv','w');
    p=11
   for c = 1:5
       
    c0 = int2str(randi([1,10],1))
    c1 = int2str(randi([1,10],1))
    cross=0.8
    c3 = rand(1,1)
    c4=randi([1,7],1)
    
     Can2='Cons_k_L_iris';
    Can3=strcat(Can2,c0)
    Can=strcat(Can3,'.csv')
    chromosom1=csvread(Can);
    Can3=strcat(Can2,c1)
    Can=strcat(Can3,'.csv')
    chromosom2=csvread(Can);
    if (c3<0.8)
               
    if (c4==1)
       chromosom3=chromosom1
       chromosom1(1:5,1:3)=chromosom2(1:5,1:3)
       chromosom2(1:5,1:3)=chromosom3(1:5,1:3)
    end
    
    if (c4==2)
        chromosom3=chromosom1
       chromosom1(6:10,1:3)=chromosom2(6:10,1:3)
       chromosom2(6:10,1:3)=chromosom3(6:10,1:3)
    end
    
    if (c4==3)
       chromosom3=chromosom1
       chromosom1(11:15,1:3)=chromosom2(11:15,1:3)
       chromosom2(11:15,1:3)=chromosom3(11:15,1:3) 
    end
    
    if (c4==4)
        chromosom3=chromosom1
       chromosom1(16:20,1:3)=chromosom2(16:20,1:3)
       chromosom2(16:20,1:3)=chromosom3(16:20,1:3)
    end
    
    if (c4==5)
            chromosom3=chromosom1
       chromosom1(21:25,1:3)=chromosom2(21:25,1:3)
       chromosom2(21:25,1:3)=chromosom3(21:25,1:3)
    end
    
    if (c4==6)
           chromosom3=chromosom1
       chromosom1(26:30,1:3)=chromosom2(26:30,1:3)
       chromosom2(26:30,1:3)=chromosom3(26:30,1:3)
    end
    
    if (c4==7)
        chromosom3=chromosom1
       chromosom1(31:35,1:3)=chromosom2(31:35,1:3)
       chromosom2(31:35,1:3)=chromosom3(31:35,1:3)
    end
    end
    Cann1=int2str(p);
    Cann2='Cons_K_L_iris';
    Cann3=strcat(Cann2,Cann1)
    Cann=strcat(Cann3,'.csv')
    csvwrite(Cann,chromosom1)
    p=p+1
    Cann1=int2str(p);
    Cann2='Cons_K_L_iris';
    Cann3=strcat(Cann2,Cann1)
    Cann=strcat(Cann3,'.csv')
    csvwrite(Cann,chromosom2)
    p=p+1
   end    
   
   
    Can2='Cons_k_L_iris';
    Can3=strcat(Can2,int2str(11))
    Can=strcat(Can3,'.csv')
    chromosom1=csvread(Can);
    Can3=strcat(Can2,int2str(12))
    Can=strcat(Can3,'.csv')
    chromosom2=csvread(Can);
    Can3=strcat(Can2,int2str(13))
    Can=strcat(Can3,'.csv')
    chromosom3=csvread(Can);
    Can3=strcat(Can2,int2str(14))
    Can=strcat(Can3,'.csv')
    chromosom4=csvread(Can);
    Can3=strcat(Can2,int2str(15))
    Can=strcat(Can3,'.csv')
    chromosom5=csvread(Can);
    Can3=strcat(Can2,int2str(16))
    Can=strcat(Can3,'.csv')
    chromosom6=csvread(Can);
    Can3=strcat(Can2,int2str(17))
    Can=strcat(Can3,'.csv')
    chromosom7=csvread(Can);
    Can3=strcat(Can2,int2str(18))
    Can=strcat(Can3,'.csv')
    chromosom8=csvread(Can);
    Can3=strcat(Can2,int2str(19))
    Can=strcat(Can3,'.csv')
    chromosom9=csvread(Can);
    Can3=strcat(Can2,int2str(20))
    Can=strcat(Can3,'.csv')
    chromosom10=csvread(Can);
   
    A=0.1
    %A=0.2 or o.1 mutation probability
    r1 = rand(1,1)
    r0=8
    if (r1<A)
        r0 = randi([1,7],1)
    end
    
    
     if (r0==1)
        id1 = find(t_label == 1); l1 = length(id1);
        repl= id1(randi(l1,5,1))
        chromosom1(1:5,1)=repl
         Cann1=int2str(11);
    Cann2='Cons_K_L_iris';
    Cann3=strcat(Cann2,Cann1)
    Cann=strcat(Cann3,'.csv')
    csvwrite(Cann,chromosom1)
         
     end
     
      if (r0==2)
        id1 = find(t_label == 1); l1 = length(id1);
        repl= id1(randi(l1,5,1))
        chromosom2(1:5,1)=repl
        Cann1=int2str(12);
    Cann2='Cons_K_L_iris';
    Cann3=strcat(Cann2,Cann1)
    Cann=strcat(Cann3,'.csv')
    csvwrite(Cann,chromosom2)
         
      end
      if (r0==3)
        id1 = find(t_label == 1); l1 = length(id1);
        repl= id1(randi(l1,5,1))
        chromosom3(1:5,1)=repl
        Cann1=int2str(13);
    Cann2='Cons_K_L_iris';
    Cann3=strcat(Cann2,Cann1)
    Cann=strcat(Cann3,'.csv')
    csvwrite(Cann,chromosom3)
         
     end
     if (r0==4)
        id1 = find(t_label == 1); l1 = length(id1);
        repl= id1(randi(l1,5,1))
        chromosom4(1:5,1)=repl
        Cann1=int2str(14);
    Cann2='Cons_K_L_iris';
    Cann3=strcat(Cann2,Cann1)
    Cann=strcat(Cann3,'.csv')
    csvwrite(Cann,chromosom4)
         
     end
     if (r0==5)
        id1 = find(t_label == 1); l1 = length(id1);
        repl= id1(randi(l1,5,1))
        chromosom5(1:5,1)=repl
        Cann1=int2str(15);
    Cann2='Cons_K_L_iris';
    Cann3=strcat(Cann2,Cann1)
    Cann=strcat(Cann3,'.csv')
    csvwrite(Cann,chromosom5)
         
     end
       if (r0==6)
        id1 = find(t_label == 1); l1 = length(id1);
        repl= id1(randi(l1,5,1))
        chromosom6(1:5,1)=repl
        Cann1=int2str(16);
    Cann2='Cons_K_L_iris';
    Cann3=strcat(Cann2,Cann1)
    Cann=strcat(Cann3,'.csv')
    csvwrite(Cann,chromosom6)
         
     end
     if (r0==7)
        id1 = find(t_label == 1); l1 = length(id1);
        repl= id1(randi(l1,5,1))
        chromosom7(1:5,1)=repl
        Cann1=int2str(17);
    Cann2='Cons_K_L_iris';
    Cann3=strcat(Cann2,Cann1)
    Cann=strcat(Cann3,'.csv')
    csvwrite(Cann,chromosom7)
         
     end
      if (r0==8)
        id1 = find(t_label == 1); l1 = length(id1);
        repl= id1(randi(l1,5,1))
        chromosom8(1:5,1)=repl
        Cann1=int2str(18);
    Cann2='Cons_K_L_iris';
    Cann3=strcat(Cann2,Cann1)
    Cann=strcat(Cann3,'.csv')
    csvwrite(Cann,chromosom8)
         
     end
    if (r0==9)
        id1 = find(t_label == 1); l1 = length(id1);
        repl= id1(randi(l1,5,1))
        chromosom9(1:5,1)=repl
        Cann1=int2str(19);
    Cann2='Cons_K_L_iris';
    Cann3=strcat(Cann2,Cann1)
    Cann=strcat(Cann3,'.csv')
    csvwrite(Cann,chromosom9)
         
    end
     if (r0==10)
        id1 = find(t_label == 1); l1 = length(id1);
        repl= id1(randi(l1,5,1))
        chromosom10(1:5,1)=repl
        Cann1=int2str(20);
    Cann2='Cons_K_L_iris';
    Cann3=strcat(Cann2,Cann1)
    Cann=strcat(Cann3,'.csv')
    csvwrite(Cann,chromosom10)
       
     end
     for t=1:20
    Can2='Cons_k_L_iris';
    Can3=strcat(Can2,int2str(t))
    Can=strcat(Can3,'.csv')
    chromosom1=csvread(Can);
        [error HI MI Jac FM SS DB CH Dunn KL Ha RS CA RI AR]=kernel_semi_super2(t_data,t_label,train_task_index,u_data,u_label,ul_task_index,chromosom1);
     
     
            
          population_init=[r error CA AR SS Dunn];
nbytes = fprintf(fileID,' %d %f %f %f %f %f \n',population_init);


     end
     fclose(fileID);
     File = csvread('K_M_IRIS.csv');

    [population front]=NDS_CD_cons(File);
    csvwrite('K_M_S_IRIS.csv',population)
    for j=1:10
         y=population(1:10,1)
         y=y(j)
         y=int2str(y);
        Can2='Cons_k_L_iris';
        Can3=strcat(Can2,y)
        Can=strcat(Can3,'.csv')
        chromosom1=csvread(Can);
        Can3=strcat(Can2,int2str(j))
        Can=strcat(Can3,'.csv')
        csvwrite(Can,chromosom1)
    end
end