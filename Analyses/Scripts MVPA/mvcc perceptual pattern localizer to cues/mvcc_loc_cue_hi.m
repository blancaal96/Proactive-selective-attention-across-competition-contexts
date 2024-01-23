%% MVPAlab TOOLBOX - (mvpa_demo.m)
% -------------------------------------------------------------------------
% Brain, Mind and Behavioral Research Center - University of Granada.
% Contact: dlopez@ugr.es (David Lopez-Garcia)
% -------------------------------------------------------------------------

clear; clc;

%% Initialize project and run configuration file:

cfg = mvpalab_init();
cfg.location = 'E:\Mi unidad\Experimento competition\DATA\EEG\Analisis multi\mvcc localizador cue hi';


    
    run cfg_file_mvcc_loc_cue_hi;

    %% Load data, generate conditions and feature extraction:

    [cfg,data,fv] = mvpalab_import(cfg);
    
    %% Compute MVPA analysis:

    [result,cfg] = mvpalab_mvcc(cfg,fv);
    %% 
    
   [permaps,cfg] = mvpalab_cpermaps(cfg,fv);
    
% Compute permutation maps and run statistical analysis:


mvpalab_saveresults(cfg,result);
mvpalab_savepermaps(cfg,permaps);

stats = mvpalab_permtest(cfg,result,permaps);
[resultdiag,permapsdiag,statsdiag] = mvpalab_extractdiag(cfg,result, permaps);

% Save cfg file:

mvpalab_savecfg(cfg);

%% Plot the results:
%run mvcc_plot;
