%% MVPAlab TOOLBOX - (mvpa_demo.m)
% -------------------------------------------------------------------------
% Brain, Mind and Behavioral Research Center - University of Granada.
% Contact: dlopez@ugr.es (David Lopez-Garcia)
% -------------------------------------------------------------------------

clear; clc;

%% Initialize project and run configuration file:

cfg = mvpalab_init();
run cfg_file_advanced;

%% Load data, generate conditions and feature extraction:

[cfg,data,fv] = mvpalab_import(cfg);

%% Compute MVPA analysis:

[result,cfg] = mvpalab_mvpa(cfg,fv);

%% Compute permutation maps and run statistical analysis:

[permaps,cfg] = mvpalab_permaps(cfg,fv);
stats = mvpalab_permtest(cfg,result,permaps);
%Saving results and permuted maps
mvpalab_saveresults(cfg,result);
mvpalab_savepermaps(cfg,permaps);
%% Compute diagonal
[resultdiag,permapsdiag,statsdiag] = mvpalab_extractdiag(cfg,result,permaps); %If permutation
%resultdiag = mvpalab_extractdiag(cfg,result); %If no permutation
%% Save cfg file:

mvpalab_savecfg(cfg);

% %% Plot the results:
% 
% run mvpa_plot;
