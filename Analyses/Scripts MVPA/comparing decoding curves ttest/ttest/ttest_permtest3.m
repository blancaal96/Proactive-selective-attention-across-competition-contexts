%This function needs as an argument the t values of the real data and the t values of the permutations, then it compares the distributionof the t values and gives the statistics (clusters, p value threshold)
function [stats] = ttest_permtest3(res, per)

cnt = 1;
countp = 1;
if size (res.p, 1)> 1
    fprintf ('Temporal generalization detected... \n')
    tg = 1;
    minclust = 10;
else
    fprintf ('Diagonal detected...')
    tg = 0;
    minclust = 3;
end

if nargin <3
    nper = 5000;
end
fprintf('Extracting cluster info... \n')
clust_real = zeros([size(res.t,1) size(res.t,2)]);
clust_real(find(res.p<0.05)) = 1;
clust_map_real = bwconncomp(clust_real);
%select only big enough clusters, >3 or 10 points
clustpos_real=[];
clustsize_real=[];
for i = 1 : clust_map_real.NumObjects
    if numel(clust_map_real.PixelIdxList{i})>=minclust;
        clustpos_real(end+1) = i;
        clustsize_real(end+1) = numel(clust_map_real.PixelIdxList{i});
    end
end
%now that we have all big enough clusters, we sum the t-values of each one.
clusttvalue_real = [];
for i = 1 : length(clustpos_real)
        clusttvalue_real(end+1) = sum(res.t(clust_map_real.PixelIdxList{clustpos_real(i)}));
end
stats.clusters = clust_map_real;
%% Permutations
%we now do the same but for every permutation
    clustpos=[];
    clustsize=[];
    clusttvalue = [];
for perm = 1:size(per.t,3)
    clust(:,:) = zeros([size(res.t,1) size(res.t,2)]);
    clust(find(per.p(:,:,perm)<0.05)) = 1;
    clust_map{perm} = bwconncomp(clust);
    %select only big enough clusters, >10 points
    count = 1;
    for i = 1 : clust_map{perm}.NumObjects
        if numel(clust_map{perm}.PixelIdxList{i})>=minclust;
            clustpos{count,perm} = i; %the count argument is given because in each permutation it is possible to have many clusters
            clustsize{count,perm} = numel(clust_map{perm}.PixelIdxList{i});
            count = count+1;
        end
    end
    %now that we have all big enough clusters, we sum the t-values of each one.
    try
        for i = 1 : length (find((~cellfun(@isempty,clustpos(:,perm)))))%the t-values of each cluster are summed, as there could be more clusters than number of permutations it is possible to have more than 5000 t values (although not probable)
                    data = per.t(:,:,perm); %the t values of one permutation cluster
                    clusttvalue(countp) = sum(data(clust_map{perm}.PixelIdxList{clustpos{i,perm}}));
                    countp = countp+1;
        end
    end
end
h = histogram(...
    clusttvalue,'Normalization','probability','BinMethod','integers');
%mark significant tvalues by specifying the margins of the normal
%distribution for a two-tailed analysis and alpha <0.05
if ~isempty (clusttvalue)
    p = prctile(clusttvalue, 97.5);
    p_= prctile(clusttvalue, 2.5);
else
    p = 0;
    p_ =0;
end
stats.posclustthres = p;
stats.negclustthres = p_;

%select the data in the real result
pos_clusters = clustpos_real(find (clusttvalue_real>= p));
neg_clusters = clustpos_real(find (clusttvalue_real<= p_));

%create a mask for plot reasons
%positive clusters
pos_pixels = [];
sigmask = ones([size(res.t,1) size(res.t,2)]);
try
    for i = 1:length(pos_clusters)
        pos_pix = cell2mat(clust_map_real.PixelIdxList(pos_clusters(i)));
        pos_pixels = [pos_pixels; pos_pix];
    end
end
sigmask(pos_pixels) = 0;
stats.sigmask = sigmask;

%negative clusters
neg_pixels = [];
sigmask_ = ones([size(res.t,1) size(res.t,2)]);
try
    for i = 1:length(neg_clusters)
        neg_pix = cell2mat(clust_map_real.PixelIdxList(neg_clusters(i)));
        neg_pixels = [neg_pixels; neg_pix];
    end
end
sigmask_(neg_pixels) = 0;
stats.sigmask_ = sigmask_;
end
