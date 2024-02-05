%This script performs the time-frequency analysis for each of the conditions and plots them or the mean across conditions
%This script uses fieldtrip and eeglab functions
clear
dir = 'E:\Mi unidad\Experimento competition\DATA\EEG\derivatives';
sdir = 'E:\Mi unidad\Experimento competition\DATA\EEG\derivatives\';
%dir = 'E:\Mi unidad\Experimento competition\DATA\EEG\conditions4mat';
%sdir = 'E:\Mi unidad\Experimento competition\DATA\EEG\conditions4freq\';
CondInfo= readtable('E:\Mi unidad\Experimento competition\Scripts\5_conditions\CondDataFreq.xlsx');
conds = CondInfo.CondName(24:29); %we do time freq only for cue hi, cue lo, cue face hi, cue face lo, cue name hi, cue name lo

freqs = {'theta';
        'alpha';
        'beta';
        };

%ft_warning off
for sub = 1:36
    % we load the eeglab preprocessed data from both conditions and
    % transform it into fieldtrip
    for cond = 1:length(conds)
        load ([dir filesep 'sub-' num2str(sub, '%.2d') filesep 'eeg' filesep 'conditions' filesep 'sub-' num2str(sub,'%.2d') '_task-competition_eeg_' conds{cond} '.mat']);

        data = eeglab2fieldtrip(EEG,'raw', 'none');


        %% Time-frequency analysis
        % specify and logaritmically distribute your frequencies
        minFreq =  2;
        maxFreq = 20;
        nSteps = (maxFreq-minFreq);
        vecFreq = logspace(log10(minFreq),log10(maxFreq),nSteps);   %if we want to make logaritmically distributed.
        %vecFreq = linspace(minFreq, maxFreq, nSteps);
        % specify and logaritmically distribute the wavelet cycles
        minCycles = 3;
        maxCycles = 5;
        nCycles = logspace(log10(minCycles),log10(maxCycles),nSteps); %same as before, only usefull if we include beta and gamma
        %nCycles = linspace (minCycles, maxCycles, nSteps);
        % the analysis
        cfg = [];
        cfg.channel = {'C1', 'Cz', 'C2', 'FC1', 'FCz', 'FC2', 'F1', 'Fz', 'F2'};
        cfg.method     = 'wavelet';
        cfg.width      = nCycles;
        cfg.output     = 'pow';
        cfg.keeptrials = 'yes';
        cfg.pad = 'nextpow2';
        cfg.foi        = vecFreq;
        cfg.toi        = -1:(1/256):1.55; %Time window of interest
        tf = ft_freqanalysis(cfg, data); %output is trials*channels*freqs*time
        cfg=[];
        cfg.baseline= [-0.280 -0.1];
        cfg.baselinetype= 'db';
        tf= ft_freqbaseline(cfg, tf);

%%

             %save spefic bin in ft format
            %fr = [freqs{f} '\'];
            fn = ['sub-' num2str(sub,'%.2d') '_task-competition_eeg_' conds{cond} '_timefreq.mat'];
            fp = [sdir 'sub-' num2str(sub, '%.2d') filesep 'eeg' filesep 'conditions' filesep];

            save([fp filesep fn],'tf');
            %clear freq_ind
        %end

    end

end


%% To select temporal window to extract indexes for correlations

%mean across conditions hi and lo, only to plot it and select the cluster
%for the correlations with behavior/decoding
tfcond.tf= cell(1,36);
for sub=1:36

    trials= min([size(tfhi.tf.powspctrm,1), size(tflo.tf.powspctrm,1)]);
    tfcond.tf{sub}= tflo.tf; %we copy the rest of the struct info
    tfcond.tf{sub}.powspctrm= (tfhi.tf.powspctrm(1:trials,:,:,:) + tflo.tf.powspctrm(1:trials,:,:,:))/2; %mean across conditions hi and lo

    cfg=[];
    tfcond.tf{sub}=ft_freqdescriptives(cfg, tfcond.tf{sub});
end

%mean across subjects
cfg=[];
meansub=ft_freqgrandaverage(cfg,tfcond.tf{:});
cfg=[];
cfg.zlim = [-2 1.3];
cfg.xlim= [-0.1 1.125];
figure
ft_singleplotTFR(cfg,meansub)
title(['Mean power across conditions in frontocentral electrodes'])
ax = gca;
ax.FontSize = 14;


%% Plot only cue hi
for sub=1:36
    tfhi= load ([dir filesep 'sub-' num2str(sub, '%.2d') filesep 'eeg' filesep 'conditions' filesep 'sub-' num2str(sub,'%.2d') '_task-competition_eeg_cue_hi_timefreq.mat']);
    tflo= load ([dir filesep 'sub-' num2str(sub, '%.2d') filesep 'eeg' filesep 'conditions' filesep 'sub-' num2str(sub,'%.2d') '_task-competition_eeg_cue_lo_timefreq.mat']);
    tfhisub.tf{sub}= tfhi.tf; %we copy the rest of the struct info
    tflosub.tf{sub}= tflo.tf;
    cfg=[];
    tfhisub.tf{sub}=ft_freqdescriptives(cfg, tfhisub.tf{sub});
    tflosub.tf{sub}=ft_freqdescriptives(cfg, tflosub.tf{sub});
end

%mean across subjects
cfg=[];
meansubhi=ft_freqgrandaverage(cfg,tfhisub.tf{:});
cfg=[];
cfg.xlim= [-0.1 1.125];
figure
ft_singleplotTFR(cfg,meansubhi)

%% Plot only cue lo

%mean across subjects
cfg=[];
meansublo=ft_freqgrandaverage(cfg,tflosub.tf{:});
cfg=[];
cfg.xlim= [-0.1 1.125];
figure
ft_singleplotTFR(cfg,meansublo)
