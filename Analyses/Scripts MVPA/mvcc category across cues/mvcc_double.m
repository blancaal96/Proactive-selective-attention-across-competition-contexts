%% MVPAlab TOOLBOX - (mvpa_demo.m)
% -------------------------------------------------------------------------
% Brain, Mind and Behavioral Research Center - University of Granada.
% Contact: dlopez@ugr.es (David Lopez-Garcia)
% -------------------------------------------------------------------------

clear; clc;

%% Initialize project and run configuration file:

cfg = mvpalab_init();

for an = 1:2
    
    run cfg_file_advanced_double;

    %% Load data, generate conditions and feature extraction:

    [cfg,data,fv] = mvpalab_import(cfg);
    
    %% Compute MVPA analysis:

    [result,cfg] = mvpalab_mvcc(cfg,fv);
    [permaps,cfg] = mvpalab_cpermaps(cfg,fv);
    
    %[cfg,diffMap,stats] = mvpalab_sfilter(cfg); %%PONERLO VARIAS VECES? SLIDING FILTER
    
    res.acc.ab(:,:,:,an) = result.acc.ab;
    res.acc.ba(:,:,:,an) = result.acc.ba;
    res.auc.ab(:,:,:,an) = result.auc.ab;
    res.auc.ba(:,:,:,an) = result.auc.ba;
    per.acc.ab(:,:,:,:,an) = permaps.acc.ab;
    per.acc.ba(:,:,:,:,an) = permaps.acc.ba;
    per.auc.ab(:,:,:,:,an) = permaps.auc.ab;
    per.auc.ba(:,:,:,:,an) = permaps.auc.ba;
    

end
%% Compute permutation maps and run statistical analysis:

result.acc.ab = mean(res.acc.ab,4);
result.acc.ba = mean(res.acc.ba,4);
result.auc.ab = mean(res.auc.ab,4);
result.auc.ba = mean(res.auc.ba,4);

permaps.acc.ab = mean(per.acc.ab,5);
permaps.acc.ba = mean(per.acc.ba,5);
permaps.auc.ab = mean(per.auc.ab,5);
permaps.auc.ba = mean(per.auc.ba,5);

%añadido
rus.acc(:,:,:,1) = result.acc.ab;
rus.acc(:,:,:,2) = result.acc.ba;
rus.auc(:,:,:,1) = result.auc.ab;
rus.auc(:,:,:,2) = result.auc.ba;
pur.acc(:,:,:,:,1) = permaps.acc.ab;
pur.acc(:,:,:,:,2) = permaps.acc.ba;
pur.auc(:,:,:,:,1) = permaps.auc.ab;
pur.auc(:,:,:,:,2) = permaps.auc.ba;
    


result.acc = mean(rus.acc,4);
result.auc = mean(rus.auc,4);

permaps.acc = mean(pur.acc,5);
permaps.auc = mean(pur.auc,5);
%fin del añadido

cfg.location = 'E:\Mi unidad/Experimento Competition/DATA/EEG/Analisis multi/cross class (c1 n1 c2 n2) y (c1 n2 c2 n1) lo media direcciones';

mvpalab_saveresults(cfg,result);
mvpalab_savepermaps(cfg,permaps);

stats = mvpalab_permtest(cfg,result,permaps);
[resultdiag,permapsdiag,statsdiag] = mvpalab_extractdiag(cfg,result,permaps);

%% Save cfg file:

mvpalab_savecfg(cfg);

%% Plot the results:
%run mvcc_plot;
