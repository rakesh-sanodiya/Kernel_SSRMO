% clear all
clc
global centers population_init V M
fileID = fopen('K_M_IRIS.csv','w');
 V=15
 M=3
 
 load('new_iris.txt')
 labels=new_iris(1:150,5)
 l1=[new_iris(1:20,5);new_iris(51:70,5);new_iris(101:120,5)]
 l2=[new_iris(21:40,5);new_iris(71:90,5);new_iris(121:140,5)]
 l3=[new_iris(41:50,5);new_iris(91:100,5);new_iris(141:150,5)]
 
 l12=new_iris(1:10,5)
 l22=new_iris(51:60,5)
 l32=new_iris(101:110,5)
 lx=[l12;l22;l32]
  
 l=labels
 X=new_iris(1:150,1:4)
 X1=[new_iris(1:20,1:4);new_iris(51:70,1:4);new_iris(101:120,1:4)]
 X2=[new_iris(21:40,1:4);new_iris(71:90,1:4);new_iris(121:140,1:4)]
 X3=[new_iris(41:50,1:4);new_iris(91:100,1:4);new_iris(141:150,1:4)]
 
 
 X12=new_iris(1:10,5)
 X22=new_iris(51:60,5)
 X32=new_iris(101:110,5)
 Xx=[X12;X22;X32]
 
 for r = 1:10
 
%% load dataset
%         load('new_iris.txt')
%         labels=new_iris(1:150,5)
%         l=labels
%         X=new_iris(1:150,1:4)
        no_classes = max(labels);
        no_reps = 5; % number of constraints for each class combinations

%% generate inequality and equality class indices
% generate some inter-class constraints
perms_ineq = classperms(no_classes, no_reps);
perms_eql = []; % no equality constraints
ineq_inerclass = genConstraint(lx,perms_ineq,perms_eql);

% generate constrainst in which the last class is outlier
inliers = 1:no_classes-1; % inliers = [1 2 3]
outliers = no_classes; % outliers = [4]
perms_ineq = allperms(inliers,outliers,no_reps);
perms_eql = []; % no equality constraints
ineq_lastout = genConstraint(lx,perms_ineq,perms_eql);

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
 
 