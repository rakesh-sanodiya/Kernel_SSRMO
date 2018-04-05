% clear all
clc
global centers population_init V M
filename = 'test.mat';
 fileID = fopen('IRIS.csv','w');
 IRIS1 = dlmread('IRISF.csv');
 V=4
 M=3
     for r = 1:30
        
         
            l=IRIS1(1:100,9)
            x=IRIS1(1:100,1:8)

  


         
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

Can1=int2str(r);
Can2='iris_mul';
Can3=strcat(Can2,Can1)
Can=strcat(Can3,'.csv')

csvwrite(Can,relative)

%% find initial kernel matrix

K0 = gaussKernel(x,100);

%% perform Bregman projections
K = bregmanProj(K0,relative,equality,200,1);



%% apply kernel k-means
% use k = no_clusters
idx_multi = perfkkmeans(K,3,200); % repeat kernel k-means 20 times

%other internal cluster validity index
%if dtype == 1
  % [st,sw,sb,cintra,cinter] = valid_sumsqures(data,labels,k);
%else
 %  [st,sw,sb,cintra,cinter] = valid_sumpearson(data,labels,k);

dtype=1;
[DB, CH, Dunn, KL, Ha] = ...
valid_internal_deviation(x,idx_multi(:,1), dtype);

% computing R-Squared

   if dtype == 1
     [St,Sw,Sb] = valid_sumsqures(x,idx_multi(:,1),1+1);
   else
     [St,Sw,Sb] = valid_sumpearson(x,idx_multi(:,1),1+1);
   end
   sst = trace(St);
   ssb = trace(Sb);
   RS = ssb/sst;




%silhouette Score
 R = 'euclidean';
SS = mean(silhouette(x, idx_multi, R))

%[CA,RI,AR,HI] = compute_clustering_performance(idx_multi,l);
[CA,RI,AR,HI,MI,Jac,FM] = compute_clustering_performance(idx_multi,l);
 %[CA,RI,SI] = compute_clustering_performance(fiI,lt);
fprintf(1,'\nour clustering performance:\n CA = %.2f, RI = %.2f, AR = %.2f, HI = %.2f, MI = %.2f ,  Jac = %.2f , FM = %.2f, SS=%.2f, DB=%2f, CH=%.2f, Dunn=%.2f, KL=%.2f  Ha=%.2f and RS=%.2f\n',...
    CA,RI,AR,HI,MI,Jac,FM,SS,DB,CH,Dunn,KL,Ha,RS);
%fprintf(1,'\nour clustering performance:\n CA = %.2f, RI = %.2f, AR = %.2f,HI = %.2f and \n',...
 %   CA,RI,AR,HI);
%population_init=[centers CA RI AR HI MI Jac FM SS DB CH Dunn KL Ha RS];
population_init=[centers r CA RI AR ];
%save test.mat
%nbytes = fprintf(fileID,'%5d %5d %5d %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n',population_init)          

nbytes = fprintf(fileID,'%5d %5d %5d %5d %f %f %f \n',population_init)   

     end
 fclose(fileID)
  
File = csvread('IRIS.csv')

[population front]=NDS_CD_cons(File);

csvwrite('iris_final.csv',population)

figure
subplot 221
cols = [0.8 * eye(3); 1 0.8 0];
scatter(xt(:,1),xt(:,2),30,cols(lt,:),'filled')
hold on
for c = 1:no_classes
    mu = mean(xt(lt==c,:)); % find cluster center
    text(mu(1), mu(2), ['\bf ' num2str(c)], 'fontSize', 14, 'color', [1 0.5 1]);
end
title('original data')
set(gca, 'fontSize', 12)



subplot 223
scatter(xt(:,1),xt(:,2),30,fiI,'filled')
title('multiclass clustering')
set(gca, 'fontSize', 12)




subplot 224
imagesc(K);
title('transformed kernel matrix')
set(gca, 'fontSize', 12)




     
     
%IRIS = dlmread('IRIS.csv');

%csvwrite('ring12.csv',population)


      