% clear all
clc
global centers population_init V M
%fileID = fopen('K_M_IRIS.csv','w');
 V=15
 M=3
 for r = 1:10
 
%% load dataset
        load('new_iris.txt')
        labels=new_iris(1:150,5)
        l=labels
        X=new_iris(1:150,1:4)
        no_classes = max(labels);
        no_reps = 5; % number of constraints for each class combinations

%% generate inequality and equality class indices
% generate some inter-class constraints
perms_ineq = classperms(no_classes, no_reps);
perms_eql = []; % no equality constraints
ineq_inerclass = genConstraint(labels,perms_ineq,perms_eql);

% generate constrainst in which the last class is outlier
inliers = 1:no_classes-1; % inliers = [1 2 3]
outliers = no_classes; % outliers = [4]
perms_ineq = allperms(inliers,outliers,no_reps);
perms_eql = []; % no equality constraints
ineq_lastout = genConstraint(labels,perms_ineq,perms_eql);

% mix both constraints
relative = [ineq_inerclass; ineq_lastout];
equality = [];



%% find initial kernel matrix
K0 = gaussKernel(X,100);




%% perform Bregman projections
K = bregmanProj(K0,relative,equality,10,1);



%% apply kernel k-means
% use k = no_clusters
idx_multi = perfkkmeans(K,3,200); % repeat kernel k-means 20 times

Can1=int2str(r);
Can2='K_L_iris';
Can3=strcat(Can2,Can1)
Can=strcat(Can3,'.csv')

csvwrite(Can,idx_multi)


Cann1=int2str(r);
Cann2='Cons_K_L_iris';
Cann3=strcat(Cann2,Cann1)
Cann=strcat(Cann3,'.csv')

csvwrite(Cann,relative)


%other internal cluster validity index
%if dtype == 1
  % [st,sw,sb,cintra,cinter] = valid_sumsqures(data,labels,k);
%else
 %  [st,sw,sb,cintra,cinter] = valid_sumpearson(data,labels,k);
% 
% dtype=1;
% [DB, CH, Dunn, KL, Ha] = ...
% valid_internal_deviation(X,idx_multi(:,1), dtype);
% 
% % computing R-Squared
% 
%    if dtype == 1
%      [St,Sw,Sb] = valid_sumsqures(X,idx_multi(:,1),1+1);
%    else
%      [St,Sw,Sb] = valid_sumpearson(X,idx_multi(:,1),1+1);
%    end
%    sst = trace(St);
%    ssb = trace(Sb);
%    RS = ssb/sst;




%silhouette Score
% R = 'euclidean';
%SS = mean(silhouette(X, idx_multi, R))

%[CA,RI,AR,HI] = compute_clustering_performance(idx_multi,l);
%[CA,RI,AR,HI,MI,Jac,FM] = compute_clustering_performance(idx_multi,l);
 %[CA,RI,SI] = compute_clustering_performance(fiI,lt);
%fprintf(1,'\nour clustering performance:\n CA = %.2f, RI = %.2f, AR = %.2f, HI = %.2f, MI = %.2f ,  Jac = %.2f , FM = %.2f, SS=%.2f, DB=%2f, CH=%.2f, Dunn=%.2f, KL=%.2f  Ha=%.2f and RS=%.2f\n',...
    %CA,RI,AR,HI,MI,Jac,FM,SS,DB,CH,Dunn,KL,Ha,RS);
%fprintf(1,'\nour clustering performance:\n CA = %.2f, RI = %.2f, AR = %.2f,HI = %.2f and \n',...
 %   CA,RI,AR,HI);
%csvwrite('wine_ker.csv',idx_multi)
%population_init=[centers r HI MI Jac FM SS DB CH Dunn KL Ha RS CA RI AR ];
%nbytes = fprintf(fileID2,'%5d %5d %5d %d %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n',population_init);
 end
%fclose(fileID2);
%File = csvread('K_M_IRIS.csv');

%[population front]=NDS_CD_cons(File);

%csvwrite('K_M_S_IRIS.csv',population)

%for first generation 
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
    csvwrite(Cann,relative)
    p=p+1
    Cann1=int2str(p);
    Cann2='Cons_K_L_iris';
    Cann3=strcat(Cann2,Cann1)
    Cann=strcat(Cann3,'.csv')
    csvwrite(Cann,relative)
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
        id1 = find(labels == 1); l1 = length(id1);
        repl= id1(randi(l1,5,1))
        chromosom1(1:5,1)=repl
         Cann1=int2str(11);
    Cann2='Cons_K_L_iris';
    Cann3=strcat(Cann2,Cann1)
    Cann=strcat(Cann3,'.csv')
    csvwrite(Cann,chromosom1)
         
     end
     
      if (r0==2)
        id1 = find(labels == 1); l1 = length(id1);
        repl= id1(randi(l1,5,1))
        chromosom2(1:5,1)=repl
        Cann1=int2str(12);
    Cann2='Cons_K_L_iris';
    Cann3=strcat(Cann2,Cann1)
    Cann=strcat(Cann3,'.csv')
    csvwrite(Cann,chromosom2)
         
      end
      if (r0==3)
        id1 = find(labels == 1); l1 = length(id1);
        repl= id1(randi(l1,5,1))
        chromosom3(1:5,1)=repl
        Cann1=int2str(13);
    Cann2='Cons_K_L_iris';
    Cann3=strcat(Cann2,Cann1)
    Cann=strcat(Cann3,'.csv')
    csvwrite(Cann,chromosom3)
         
     end
     if (r0==4)
        id1 = find(labels == 1); l1 = length(id1);
        repl= id1(randi(l1,5,1))
        chromosom4(1:5,1)=repl
        Cann1=int2str(14);
    Cann2='Cons_K_L_iris';
    Cann3=strcat(Cann2,Cann1)
    Cann=strcat(Cann3,'.csv')
    csvwrite(Cann,chromosom4)
         
     end
     if (r0==5)
        id1 = find(labels == 1); l1 = length(id1);
        repl= id1(randi(l1,5,1))
        chromosom5(1:5,1)=repl
        Cann1=int2str(15);
    Cann2='Cons_K_L_iris';
    Cann3=strcat(Cann2,Cann1)
    Cann=strcat(Cann3,'.csv')
    csvwrite(Cann,chromosom5)
         
     end
       if (r0==6)
        id1 = find(labels == 1); l1 = length(id1);
        repl= id1(randi(l1,5,1))
        chromosom6(1:5,1)=repl
        Cann1=int2str(16);
    Cann2='Cons_K_L_iris';
    Cann3=strcat(Cann2,Cann1)
    Cann=strcat(Cann3,'.csv')
    csvwrite(Cann,chromosom6)
         
     end
     if (r0==7)
        id1 = find(labels == 1); l1 = length(id1);
        repl= id1(randi(l1,5,1))
        chromosom7(1:5,1)=repl
        Cann1=int2str(17);
    Cann2='Cons_K_L_iris';
    Cann3=strcat(Cann2,Cann1)
    Cann=strcat(Cann3,'.csv')
    csvwrite(Cann,chromosom7)
         
     end
      if (r0==8)
        id1 = find(labels == 1); l1 = length(id1);
        repl= id1(randi(l1,5,1))
        chromosom8(1:5,1)=repl
        Cann1=int2str(18);
    Cann2='Cons_K_L_iris';
    Cann3=strcat(Cann2,Cann1)
    Cann=strcat(Cann3,'.csv')
    csvwrite(Cann,chromosom8)
         
     end
    if (r0==9)
        id1 = find(labels == 1); l1 = length(id1);
        repl= id1(randi(l1,5,1))
        chromosom9(1:5,1)=repl
        Cann1=int2str(19);
    Cann2='Cons_K_L_iris';
    Cann3=strcat(Cann2,Cann1)
    Cann=strcat(Cann3,'.csv')
    csvwrite(Cann,chromosom9)
         
    end
     if (r0==10)
        id1 = find(labels == 1); l1 = length(id1);
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
         K = bregmanProj(K0,chromosom1,equality,10,1);



%% apply kernel k-means
% use k = no_clusters
    idx_multi = perfkkmeans(K,3,200); % repeat kernel k-means 20 times

    Can2='k_L_iris';
    Can3=strcat(Can2,int2str(t))
    Can=strcat(Can3,'.csv')
    csvwrite(Can,idx_multi)
    dtype=1;
    [DB, CH, Dunn, KL, Ha] = ...
    valid_internal_deviation(X,idx_multi(:,1), dtype);

% computing R-Squared

       if dtype == 1
         [St,Sw,Sb] = valid_sumsqures(X,idx_multi(:,1),1+1);
       else
         [St,Sw,Sb] = valid_sumpearson(X,idx_multi(:,1),1+1);
       end
       sst = trace(St);
       ssb = trace(Sb);
       RS = ssb/sst;




        %silhouette Score
         R = 'euclidean';
        SS = mean(silhouette(X, idx_multi, R))

        %[CA,RI,AR,HI] = compute_clustering_performance(idx_multi,l);
        [CA,RI,AR,HI,MI,Jac,FM] = compute_clustering_performance(idx_multi,l);
         %[CA,RI,SI] = compute_clustering_performance(fiI,lt);
        fprintf(1,'\nour clustering performance:\n CA = %.2f, RI = %.2f, AR = %.2f, HI = %.2f, MI = %.2f ,  Jac = %.2f , FM = %.2f, SS=%.2f, DB=%2f, CH=%.2f, Dunn=%.2f, KL=%.2f  Ha=%.2f and RS=%.2f\n',...
            CA,RI,AR,HI,MI,Jac,FM,SS,DB,CH,Dunn,KL,Ha,RS);
        %fprintf(1,'\nour clustering performance:\n CA = %.2f, RI = %.2f, AR = %.2f,HI = %.2f and \n',...
         %   CA,RI,AR,HI);
        %csvwrite('wine_ker.csv',idx_multi)
        population_init=[centers t HI MI Jac FM SS DB CH Dunn KL Ha RS CA RI AR ];
        nbytes = fprintf(fileID,'%5d %5d %5d %d %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n',population_init);



     end
     fclose(fileID);
     File = csvread('K_M_IRIS.csv');

    [population front]=NDS_CD_cons(File);
    csvwrite('K_M_S_IRIS.csv',population)
    for j=1:10
         y=population(1:10,4)
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
    
    