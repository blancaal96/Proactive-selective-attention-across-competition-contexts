function [res,per] = ttest_res3(cond1,cond2,nper)
subs = 1:size(cond1.res,3);
fprintf ('Getting T-test results... \n')
randmode =1; 
if size (cond1.res, 1)> 1
    fprintf ('Temporal generalization detected... \n')
    tg = 1;
else
    fprintf ('Diagonal detected...')
    tg = 0;
end

if nargin <3
    nper = 5000;
end

if tg    
    for t1 = 1:size(cond1.res,1)
        for t2 =  1:size(cond1.res,2)
        x = squeeze(cond1.res(t1,t2,:));
        y = squeeze(cond2.res(t1,t2,:));

        [h, p, ci, stats] = ttest(x,y);
        %we store the tvalue for each time-point and participant
        res.t(t1,t2) = stats.tstat; 
        res.p(t1,t2) = p;
        end
    end
    fprintf('      # Permuted maps >> ');
    for perm = 1:nper
        fprintf([int2str(nper) '/' int2str(perm) ' '])
        cond1_.res = [];
        cond2_.res = [];
        %two ways of performing permutations
        % 1: full random, all trials in each condition might be assigned the
        % -1
        if randmode ==1
            for s = 1:size(cond1.res,3)
                if rand<=0.5
                    cond1_.res(:,:,s) = cond1.res(:,:,s)*-1;
                    cond2_.res(:,:,s) = cond2.res(:,:,s);
                else
                    cond1_.res(:,:,s) = cond1.res(:,:,s);
                    cond2_.res(:,:,s) = cond2.res(:,:,s)*-1;
                end
            end
        else
        % 2: we make sure that the -1 is distributed equally
            rn = randperm (size(cond1.res,3));
                for s = 1:size(cond1.res,3)/2
                    cond1_.res(:,:,rn(s)) = cond1.res(:,:,rn(s))*-1;
                    cond2_.res(:,:,rn(s)) = cond2.res(:,:,rn(s));
                end
                for s = size(cond1.res,3)/2:size(cond1.res,3)
                    cond1_.res(:,:,rn(s)) = cond1.res(:,:,rn(s));
                    cond2_.res(:,:,rn(s)) = cond2.res(:,:,rn(s))*-1;
                end
        end
        for t1 = 1:size(cond1_.res,1)
            for t2 =  1:size(cond1_.res,2)
            x = squeeze(cond1_.res(t1,t2,:));
            y = squeeze(cond2_.res(t1,t2,:));

            [h, p, ci, stats] = ttest(x,y);
            %we store the tvalue for each time-point and participant
            per.t(t1,t2,perm) = stats.tstat; 
            per.p(t1,t2,perm) = p;
            end
        end
        % a counter
        if perm>1
        for j = 0 : log10(perm - 1) + numel(num2str(nper)) + 2
            fprintf('\b'); % Delete previous counter display
        end
        end
    end
else 
    for t = 1:size(cond1.res,2)
        x = squeeze(cond1.res(:,t,:));
        y = [squeeze(cond2.res(:,t,:))];

        [h, p, ci, stats] = ttest(x,y);
        %we store the tvalue for each time-point and participant
        res.t(:,t) = stats.tstat; 
        res.p(:,t) = p;
    end
    fprintf('      # Permuted maps >> ');
    for perm = 1:nper
        fprintf([int2str(nper) '/' int2str(perm) ' '])
        cond1_.res = [];
        cond2_.res = [];
        %two ways of performing permutations
        % 1: full random, all trials in each condition might be assigned the
        % -1
        if randmode ==1
            for s = 1:size(cond1.res,3)%loop across all subjects, some subjects will have positive values and other subjects negative ones
                if rand<=0.5
                    cond1_.res(:,:,s) = cond1.res(:,:,s)*-1;
                    cond2_.res(:,:,s) = cond2.res(:,:,s);
                else
                    cond1_.res(:,:,s) = cond1.res(:,:,s);
                    cond2_.res(:,:,s) = cond2.res(:,:,s)*-1;
                end
            end
        else
        % 2: we make sure that the -1 is distributed equally
            rn = randperm (size(cond1.res,3));
                for s = 1:size(cond1.res,3)/2
                    cond1_.res(:,:,rn(s)) = cond1.res(:,:,rn(s))*-1;
                    cond2_.res(:,:,rn(s)) = cond2.res(:,:,rn(s));
                end
                for s = (size(cond1.res,3)/2)+1:size(cond1.res,3)
                    cond1_.res(:,:,rn(s)) = cond1.res(:,:,rn(s));
                    cond2_.res(:,:,rn(s)) = cond2.res(:,:,rn(s))*-1;
                end   
        end
        for t = 1:size(cond1_.res,2)
            x = squeeze(cond1_.res(:,t,:));
            y = squeeze(cond2_.res(:,t,:));

            [h, p, ci, stats] = ttest(x,y);%we store the t values of each permutation matrix (sign changed), we will have 5000 t values
            %we store the tvalue for each time-point and participant
            per.t(:,t,perm) = stats.tstat; 
            per.p(:,t,perm) = p;
        end
        % a counter
        if perm>1
        for j = 0 : log10(perm - 1) + numel(num2str(nper)) + 2
            fprintf('\b'); % Delete previous counter display
        end
        end
    end
end
%fprintf (['Elapsed ' int2str(toc) ' s \n']);
fprintf ('Done!')
end