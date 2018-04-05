 clear all
clc
global centers population_init V M
filename = 'test.m';
fileID = fopen('myfile123.csv','w');
 V=3
 M=3
     for r = 1:1
        
         load('M2.mat')
            l1=M2(1:90,3)
            l2=M2(181:240,3)
            lt=[l1;l2]
            lte1=M2(91:180,3)
            lte2=M2(240:300,3)
            lte=[lte1;lte2]

            xt1=M2(1:90,1:2)
            xt2=M2(181:240,1:2)
            xt=[xt1;xt2]
            xte1=M2(91:180,1:2)
            xte2=M2(240:300,1:2)
            xte=[xte1;xte2]
            

            no_classes = max(lt);
no_reps = 5; % number of constraints for each class combinations

%% generate inequality and equality class indices
% generate some inter-class constraints
perms_ineq = classperms(no_classes, no_reps);
perms_eql = []; % no equality constraints
ineq_inerclass = genConstraint(lt,perms_ineq,perms_eql);

% generate constrainst in which the last class is outlier
inliers = 1:no_classes-1; % inliers = [1 2 3]
outliers = no_classes; % outliers = [4]
perms_ineq = allperms(inliers,outliers,no_reps);
perms_eql = []; % no equality constraints
ineq_lastout = genConstraint(lt,perms_ineq,perms_eql);

% mix both constraints
relative = [ineq_inerclass; ineq_lastout];
equality = [];





Can1=int2str(r);
Can2='iris_mul';
Can3=strcat(Can2,Can1)
Can=strcat(Can3,'.csv')

csvwrite(Can,relative)











%% find initial kernel matrix

K0 = gaussKernel(xt,100);

%% perform Bregman projections
K = bregmanProj(K0,relative,equality,200,1);

%% apply kernel k-means
% use k = no_clusters
idx_multi = perfkkmeans(K,2,20); % repeat kernel k-means 20 times


c1 = find(idx_multi==1)

c2=find(idx_multi==2)


cc1=xt(c1,1:2)
cc2=xt(c2,1:2)


su1=sum(cc1)/size(cc1,1)

su2=sum(cc2)/size(cc2,1)


sus=[su1;su2]

for i = 1:size(xte,1)
     arr1 = zeros(2,1);
    
    
     for cent = 1:2
         p1=(sus(cent)-xte(i))*(sus(cent)-xte(i));
         p2=(sus(cent,2)-xte(i,2))*(sus(cent,2)-xte(i,2));
         arr1(cent)=p1+p2;
     end
    
     
     Ind1(i)=min(arr1);
     
     if (arr1(1)==Ind1(i))
         fiI(i)=1;
     else
         (arr1(2)==Ind1(i))
         fiI(i)=2;
    
     end
end

fiI = transpose(fiI)
dtype=1;
[DB, CH, Dunn, KL, Ha] = ...
valid_internal_deviation(xt,idx_multi(:,1), dtype);

% computing R-Squared

   if dtype == 1
     [St,Sw,Sb] = valid_sumsqures(xt,idx_multi(:,1),1+1);
   else
     [St,Sw,Sb] = valid_sumpearson(xt,idx_multi(:,1),1+1);
   end
   sst = trace(St);
   ssb = trace(Sb);
   RS = ssb/sst;




%silhouette Score
 R = 'euclidean';
SS = mean(silhouette(xt,idx_multi, R))
[CA,RI,AR,HI,MI,Jac,FM] = compute_clustering_performance(fiI,lte);

% [CA,RI,SI] = compute_clustering_performance(fiI,lt);
fprintf(1,'\nour clustering performance:\n CA = %.2f, RI = %.2f, AR = %.2f, HI = %.2f, MI = %.2f ,  Jac = %.2f , FM = %.2f, SS=%.2f, DB=%2f, CH=%.2f, Dunn=%.2f, KL=%.2f  Ha=%.2f and RS=%.2f\n',...
    CA,RI,AR,HI,MI,Jac,FM,SS,DB,CH,Dunn,KL,Ha,RS);

population_init=[centers r CA RI AR];
save test.mat
nbytes = fprintf(fileID,'%5d %5d %5d %f %f %f\n',population_init)           



     end
 

File = csvread('myfile123.csv')

[population front]=NDS_CD_cons(File);

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






%M2 = dlmread('somefile.txt');

%csvwrite('ring12.csv',population)



     
     
     
     
     
     
     

      