function perms = classperms(no_classes, no_reps)


if ~exist('no_reps','var') || isempty(no_reps)
    no_reps = 1;
end

indices = repmat(1:no_classes,no_classes,1);
perms = [indices(:) indices(:) repmat([1:no_classes]',no_classes,1)];
perms(1:no_classes+1:end,:) = []; % remove intra-class perms!

perms = [perms, no_reps * ones(size(perms,1),1)];