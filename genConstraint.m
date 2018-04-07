function [relative, equality] = genConstraint(labels, rel_class, eql_class)


if ~exist('rel_class', 'var') || isempty(rel_class)
    rel_class = [];
    relative = [];
else
    relative = zeros(sum(rel_class(:,4)),3);
end

if ~exist('eql_class', 'var') || isempty(eql_class)
    eql_class = [];
    equality = [];
else
    equality = zeros(sum(eql_class(:,4)),3);
end

cnt = 0;
for i = 1:size(rel_class,1)
    triplet = rel_class(i,1:3);
    n = rel_class(i,4);
    id1 = find(labels == triplet(1)); l1 = length(id1);
    id2 = find(labels == triplet(2)); l2 = length(id2);
    id3 = find(labels == triplet(3)); l3 = length(id3);
    const = [id1(randi(l1,n,1)), id2(randi(l2,n,1)), id3(randi(l3,n,1))];
    relative((1:n)+cnt,:) = const;
    cnt = cnt + n;
end

cnt = 0;
for i = 1:size(eql_class,1)
    triplet = eql_class(i,1:3);
    n = eql_class(i,4);
    id1 = find(labels == triplet(1)); l1 = length(id1);
    id2 = find(labels == triplet(2)); l2 = length(id2);
    id3 = find(labels == triplet(3)); l3 = length(id3);
    const = [id1(randi(l1,n,1)), id2(randi(l2,n,1)), id3(randi(l3,n,1))];
    equality((1:n)+cnt,:) = const;
    cnt = cnt + n;
end
