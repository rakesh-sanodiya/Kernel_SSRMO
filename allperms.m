function perms = allperms(inliers, outliers, no_reps)


if ~exist('no_reps','var') || isempty(no_reps)
    no_reps = 1;
end

if numel(inliers) == 1
    perms = [];
    return
else
    base = nchoosek(inliers, 2); % choose first two points from the inliers
end
last = ones(size(base,1),1) * outliers(:)'; % choose the outliers
perms = [repmat(base,length(outliers),1), last(:), no_reps * ones(numel(last),1)];
