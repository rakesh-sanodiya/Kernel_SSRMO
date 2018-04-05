 clear all
clc
global centers population_init V M
filename = 'test.mat';
 fileID = fopen('activitymobile.csv','w');
 mobile_x = dlmread('X_train.txt')
 mobile_y = dlmread('y_train.txt')
 V=6
 M=3
     for r = 1:50
        
         
            l=mobile_y(1:500,1)
            x=mobile_x(1:500,1:561)

  


         
            no_classes = max(l);
no_reps = 5; % number of constraints for each class combinations

%% generate inequality and equality class indices
% generate some inter-class constraints
perms_ineq = classperms(no_classes, no_reps);
perms_eql = []; % no equality constraints
ineq_inerclass = genConstraint(l,perms_ineq,perms_eql);

% generate constrainst in which the last class is outlier
inliers = 1:no_classes-1; % inliers = [1 2 3]
outliers = no_classes; % outliers = [4]
perms_ineq = allperms(inliers,outliers,no_reps);
perms_eql = []; % no equality constraints
ineq_lastout = genConstraint(l,perms_ineq,perms_eql);

% mix both constraints
relative = [ineq_inerclass; ineq_lastout];
equality = [];


%% find initial kernel matrix

K0 = gaussKernel(x,100);

%% perform Bregman projections
K = bregmanProj(K0,relative,equality,200,1);

%% apply kernel k-means
% use k = no_clusters
idx_multi = perfkkmeans(K,6,20); % repeat kernel k-means 20 times


[CA,RI,SI] = compute_clustering_performance(idx_multi,l);
 %[CA,RI,SI] = compute_clustering_performance(fiI,lt);
fprintf(1,'\nour clustering performance:\n SI = %.2f, CA = %.2f and RI = %.2f\n',...
    SI,CA,RI);

population_init=[centers SI CA RI];
save test.mat
nbytes = fprintf(fileID,'%5d %5d %5d %5d %5d %5d %f %f %f\n',population_init)          



     end
 fclose(fileID)
  
File = csvread('activitymobile.csv')

[population front]=NDS_CD_cons(File);




      