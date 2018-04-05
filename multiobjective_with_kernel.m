 clear all
clc
global centers population_init V M
filename = 'test.mat';
 fileID = fopen('myfile1.csv','w');
 V=4
 M=3
     for r = 1:2
        
         load('four_clusters.mat')
            l1=labels(1:50)
            l2=labels(100:149)
            l3=labels(200:249)
            l4=labels(300:349)
            l=[l1;l2;l3;l4]

            l5=labels(50:99)
            l6=labels(150:199)
            l7=labels(250:299)
            l8=labels(350:400)
            lt=[l5;l6;l7;l8]


            x1=X(1:50,:)
            x2=X(100:149,:)
            x3=X(200:249,:)
            x4=X(300:349,:)
            x=[x1;x2;x3;x4]

            x5=X(50:99,:)
            x6=X(150:199,:)
            x7=X(250:299,:)
            x8=X(350:400,:)
            xt=[x5;x6;x7;x8]
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
idx_multi = perfkkmeans(K,4,20); % repeat kernel k-means 20 times


c1 = find(idx_multi==1)

c2=find(idx_multi==2)


c3=find(idx_multi==3)

c4=find(idx_multi==4)

cc1=x(c1,1:2)
cc2=x(c2,1:2)
cc3=x(c3,1:2)
cc4=x(c4,1:2)

su1=sum(cc1)/size(cc1,1)

su2=sum(cc2)/size(cc2,1)

su3=sum(cc3)/size(cc3,1)

su4=sum(cc4)/size(cc4,1)
sus=[su1;su2;su3;su4]

for i = 1:size(xt,1)
     arr1 = zeros(4,1);
    
    
     for cent = 1:4
         p1=(sus(cent)-xt(i))*(sus(cent)-xt(i));
         p2=(sus(cent,2)-xt(i,2))*(sus(cent,2)-xt(i,2));
         arr1(cent)=p1+p2;
     end
    
     
     Ind1(i)=min(arr1);
     
     if (arr1(1)==Ind1(i))
         fiI(i)=1;
     elseif (arr1(2)==Ind1(i))
         fiI(i)=2;
     elseif (arr1(3)==Ind1(i))
         fiI(i)=3;
     else
         fiI(i)=4;
     end
end
 [CA,RI,SI] = compute_clustering_performance(fiI,lt);
fprintf(1,'\nour clustering performance:\n SI = %.2f, CA = %.2f and RI = %.2f\n',...
    SI,CA,RI);

population_init=[centers SI CA RI];
save test.mat
nbytes = fprintf(fileID,'%5d %5d %5d %5d %f %f %f\n',population_init)          



     end
 
  
File = csvread('myfile.csv')

[population front]=NDS_CD_cons(File);


fclose(fileID)
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








     
     
     
     
     
     
     

      