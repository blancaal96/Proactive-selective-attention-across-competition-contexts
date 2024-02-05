%Script using the fieldtrip functions to identify time-frequency significant ROI.
clear


%% Load data
dir = 'E:\Mi unidad\Experimento competition\DATA\EEG\derivatives';
cue_hi= cell(1,36);
cue_lo=cell (1,36);
for sub=1:36
    cue_hi{1,sub}= load ([dir filesep 'sub-' num2str(sub, '%.2d') filesep 'eeg' filesep 'conditions' filesep 'sub-' num2str(sub,'%.2d') '_task-competition_eeg_cue_hi_timefreq.mat']);
    cue_lo{1,sub}= load ([dir filesep 'sub-' num2str(sub, '%.2d') filesep 'eeg' filesep 'conditions' filesep 'sub-' num2str(sub,'%.2d') '_task-competition_eeg_cue_lo_timefreq.mat']);
end

%%

cfg = [];
cfg.channel = {'Fz','FC1','Cz','FC2','F1','C1','C2','F2','FCz'};
cfg.avgoverchan = 'yes';
cfg.avgoverrpt  = 'yes';

for i=1:36
cue_hi_avg{i} = ft_selectdata(cfg, cue_hi{i}.tf);
cue_lo_avg{i} = ft_selectdata(cfg, cue_lo{i}.tf);
end

%Cluster
alpha = 0.05;
cfg = [];
cfg.latency = [0 1];
cfg.feedback = 'textbar';
cfg.method = 'montecarlo';       % use the Monte Carlo Method to calculate the significance probability
cfg.correctm = 'cluster';
cfg.clusterstatistic = 'maxsum'; % test statistic that will be evaluated under the permutation distribution.
cfg.statistic = 'ft_statfun_depsamplesT'; %'depsamplesT'; %within subjects
cfg.tail = 0;                    % -1, 1 or 0 (default = 0); one-sided or two-sided test
cfg.clustertail = 0;

if cfg.tail == 0
    cfg.alpha = alpha/2;               % alpha level of the permutation test
else
    cfg.alpha = alpha;
end

cfg.clusteralpha = alpha;         % alpha level of the sample-specific test statistic that will be used for thresholding
cfg.numrandomization = 1000;
cfg.design = [repmat(1:size(cue_hi,2),1,2); [repelem(1, size(cue_hi,2)), repelem(2, size(cue_hi,2))]]; %A matrix with ones representing the trials of the first condition and twos representing the trials of the second condition
cfg.uvar = 1;
cfg.ivar = 2;
[stat] = ft_freqstatistics(cfg, cue_hi_avg{:}, cue_lo_avg{:}); %run cluster permutation

%% Plot

%Prepare data
cfg = [];
cfg.keepindividual = 'no';
cue_hi = ft_freqgrandaverage(cfg, cue_hi_avg{:});
cue_lo = ft_freqgrandaverage(cfg, cue_lo_avg{:});

cfg = [];
cfg.operation = 'subtract';
cfg.parameter = 'powspctrm';
Difference = ft_math(cfg, cue_hi, cue_lo); %subtract GAs

%Plot cluster
F1 = figure(1);
if isfield(stat, 'posclusters') %Positive clusters
    pos_cluster_pvals = [stat.posclusters(:).prob];
    pos_signif_clust = find(pos_cluster_pvals < alpha);
    pos = ismember(stat.posclusterslabelmat, pos_signif_clust);
    pos_int = zeros(size(Difference.powspctrm));
    where_timepoints = ismember(Difference.time, stat.time);
    pos_int(:, :, where_timepoints) = pos;
    pos_int = logical(pos_int);

    cfg = [];
    cfg.maskparameter = 'mask';
    cfg.maskstyle = 'outline';
    %cfg.colormap = RBcolormap;
    cfg.title = 'Preparation effect (cues high- cues low)';
    cfg.fontsize = 10;
    cfg.colorbar = 'no';
    cfg.zlim = [-2 2];
    cfg.xlim= [-0.1 1.125];
    Difference.mask = pos_int;
    ft_singleplotTFR(cfg, Difference);
    ylabel('Hz')
    xlabel('ms')
    xline(0, '--k', 'LineWidth', 2)
end
