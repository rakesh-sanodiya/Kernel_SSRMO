function K0 = gaussKernel(X,k)


X = zscore(X); % normalize features
N = size(X,1);
if ~exist('k','var') || isempty(k)
    k = min(40,N);
end

diag_shift = 0; % apply diagonal shift on K0 for numerical stability

D = pdist2(X,X);
D_sorted = sort(D, 2, 'ascend');
sig = D_sorted(:,k); % estimate sigma (std) for each point

K0 = exp(-D.^2./(sig*sig')) + diag_shift * eye(N);
