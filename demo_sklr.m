function demo_sklr

%% load dataset
load('four_clusters.mat')
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
K = bregmanProj(K0,relative,equality,200,1);

%% apply kernel k-means
% use k = no_clusters
idx_multi = perfkkmeans(K,4,50); % repeat kernel k-means 20 times

% use k = 2 (binary clustering where last class is outlier)
idx_bin = perfkkmeans(K,2,20); % repeat kernel k-means 20 times

%% plot results
figure
subplot 221
cols = [0.8 * eye(3); 1 0.8 0];
scatter(X(:,1),X(:,2),30,cols(labels,:),'filled')
hold on
for c = 1:no_classes
    mu = mean(X(labels==c,:)); % find cluster center
    text(mu(1), mu(2), ['\bf ' num2str(c)], 'fontSize', 14, 'color', [1 0.5 1]);
end
title('original data')
set(gca, 'fontSize', 12)


subplot 222
scatter(X(:,1),X(:,2),30,idx_bin,'filled')
title('binary clustering')
set(gca, 'fontSize', 12)

subplot 223
scatter(X(:,1),X(:,2),30,idx_multi,'filled')
title('multiclass clustering')
set(gca, 'fontSize', 12)

subplot 224
imagesc(K);
title('transformed kernel matrix')
set(gca, 'fontSize', 12)

