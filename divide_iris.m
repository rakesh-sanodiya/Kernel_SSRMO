% clear all
clc
global centers population_init V M
fileID = fopen('K_M_IRIS.csv','w');
 V=15
 M=3
 for r = 1:1
%% load dataset
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
K1 = gaussKernel(X1,60);
K2 = gaussKernel(X2,60);
K3 = gaussKernel(X3,30);


%% perform Bregman projections
K11 = bregmanProj(K1,relative,equality,10,1);
K12 = bregmanProj(K2,relative,equality,10,1);
K13 = bregmanProj(K3,relative,equality,10,1);

%% apply kernel k-means
% use k = no_clusters

idx_multi1 = perfkkmeans(K11,3,200); % repeat kernel k-means 20 times
idx_multi2 = perfkkmeans(K12,3,200);
idx_multi3 = perfkkmeans(K13,3,200);

% 
% 
% Can1=int2str(r);
% Can2='K_L_iris';
% Can3=strcat(Can2,Can1)
% Can=strcat(Can3,'.csv')
% 
% csvwrite(Can,idx_multi)
% 
% %other internal cluster validity index
% %if dtype == 1
%   % [st,sw,sb,cintra,cinter] = valid_sumsqures(data,labels,k);
% %else
%  %  [st,sw,sb,cintra,cinter] = valid_sumpearson(data,labels,k);
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
% 
% 

% 
% %silhouette Score
%  R = 'euclidean';
% SS = mean(silhouette(X, idx_multi, R))

%[CA,RI,AR,HI] = compute_clustering_performance(idx_multi,l);
[CA,RI,AR,HI,MI,Jac,FM] = compute_clustering_performance(idx_multi1,l1);
 %[CA,RI,SI] = compute_clustering_performance(fiI,lt);
fprintf(1,'\nour clustering performance:\n CA = %.2f, RI = %.2f, AR = %.2f, HI = %.2f, MI = %.2f ,  Jac = %.2f , FM = %.2f\n',...
    CA,RI,AR,HI,MI,Jac,FM);

[CA,RI,AR,HI,MI,Jac,FM] = compute_clustering_performance(idx_multi2,l2);
 %[CA,RI,SI] = compute_clustering_performance(fiI,lt);
fprintf(1,'\nour clustering performance:\n CA = %.2f, RI = %.2f, AR = %.2f, HI = %.2f, MI = %.2f ,  Jac = %.2f , FM = %.2f\n',...
    CA,RI,AR,HI,MI,Jac,FM);

[CA,RI,AR,HI,MI,Jac,FM] = compute_clustering_performance(idx_multi3,l3);
 %[CA,RI,SI] = compute_clustering_performance(fiI,lt);
fprintf(1,'\nour clustering performance:\n CA = %.2f, RI = %.2f, AR = %.2f, HI = %.2f, MI = %.2f ,  Jac = %.2f , FM = %.2f\n',...
    CA,RI,AR,HI,MI,Jac,FM);

%fprintf(1,'\nour clustering performance:\n CA = %.2f, RI = %.2f, AR = %.2f,HI = %.2f and \n',...
 %   CA,RI,AR,HI);
% %csvwrite('wine_ker.csv',idx_multi)
% population_init=[centers r HI MI Jac FM SS DB CH Dunn KL Ha RS CA RI AR ];
% nbytes = fprintf(fileID,'%5d %5d %5d %d %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n',population_init);
 end
% fclose(fileID);
% File = csvread('K_M_IRIS.csv');
% 
% [population front]=NDS_CD_cons(File);
% 
% csvwrite('K_M_S_IRIS.csv',population)