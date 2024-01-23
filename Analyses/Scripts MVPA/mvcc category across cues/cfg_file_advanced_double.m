%% IF MVCC

cfg.analysis = 'MVCC';
cfg.location = 'E:\Mi unidad/Experimento Competition/DATA/EEG/Analisis multi/cross class (c1 n1 c2 n2) y (c1 n2 c2 n1) lo media direcciones';

if an == 1
    cfg.location = 'E:\Mi unidad/Experimento Competition/DATA/EEG/Analisis multi/cross class (c1 n1 c2 n2) y (c1 n2 c2 n1) lo media direcciones';
    condition_a = 'cue_face_1_lo'; %Here specify if you want to perform category anticipation in high competition or low competition
    condition_b = 'cue_name_1_lo';
    condition_c = 'cue_face_2_lo'; 
    condition_d = 'cue_name_2_lo'; 
else
    cfg.location = 'E:\Mi unidad/Experimento Competition/DATA/EEG/Analisis multi/cross class (c1 n1 c2 n2) y (c1 n2 c2 n1) lo media direcciones';
    condition_a = 'cue_face_1_lo';
    condition_b = 'cue_name_2_lo';
    condition_c = 'cue_face_2_lo';
    condition_d = 'cue_name_1_lo';
end

% Condition indentifiers:
cfg.study.conditionIdentifier{1,1} = condition_a;
cfg.study.conditionIdentifier{1,2} = condition_b;
cfg.study.conditionIdentifier{2,1} = condition_c;
cfg.study.conditionIdentifier{2,2} = condition_d;

% Data paths:
cfg.study.dataPaths{1,1} = 'E:\Mi unidad\Experimento competition\DATA\EEG\derivatives\';
cfg.study.dataPaths{1,2} = 'E:\Mi unidad\Experimento competition\DATA\EEG\derivatives\';
cfg.study.dataPaths{2,1} = 'E:\Mi unidad\Experimento competition\DATA\EEG\derivatives\';
cfg.study.dataPaths{2,2} = 'E:\Mi unidad\Experimento competition\DATA\EEG\derivatives\';

%cfg.study.dataPaths{1,1} = ['E:\Mi unidad/Experimento Competition/DATA/EEG/conditions4mat/cues_clasificadas/' condition_a '\'] ; %[ ]
%cfg.study.dataPaths{1,2} = ['E:\Mi unidad/Experimento Competition/DATA/EEG/conditions4mat/cues_clasificadas/' condition_b '\'];
%cfg.study.dataPaths{2,1} = ['E:\Mi unidad/Experimento Competition/DATA/EEG/conditions4mat/cues_clasificadas/' condition_c '\'] ; %[ ]
%cfg.study.dataPaths{2,2} = ['E:\Mi unidad/Experimento Competition/DATA/EEG/conditions4mat/cues_clasificadas/' condition_d '\'];

% Data files:
for sub=1:36
    cfg.study.dataFiles{1,1} {1,sub}= ['sub-' num2str(sub, '%.2d') '\eeg\conditions\sub-' num2str(sub, '%.2d') '_task-competition_eeg_' condition_a '.mat'];
    cfg.study.dataFiles{1,2} {1,sub}= ['sub-' num2str(sub, '%.2d') '\eeg\conditions\sub-' num2str(sub, '%.2d') '_task-competition_eeg_' condition_b '.mat'];
    cfg.study.dataFiles{2,1} {1,sub}= ['sub-' num2str(sub, '%.2d') '\eeg\conditions\sub-' num2str(sub, '%.2d') '_task-competition_eeg_' condition_c '.mat'];
    cfg.study.dataFiles{2,2} {1,sub}= ['sub-' num2str(sub, '%.2d') '\eeg\conditions\sub-' num2str(sub, '%.2d') '_task-competition_eeg_' condition_d '.mat'];
end  

% for d = 1: 36
%     datafiles{d} = [int2str(d) '.mat'];
% end
% 
% cfg.study.dataFiles{1,1} = datafiles;
% cfg.study.dataFiles{1,2} = datafiles;
% cfg.study.dataFiles{2,1} = datafiles;
% cfg.study.dataFiles{2,2} = datafiles;

%% FEATURE EXTRACTION:

cfg.feature = 'voltage';

% cfg.feature = 'voltage'  - Raw voltage as feature.
% cfg.feature = 'envelope' - Power evelope as feature.

% cfg.powenv.method = 'analytic';
% cfg.powenv.uplow  = 'upper';
% cfg.powenv.length = 5;

% cfg.powenv.method = 'analytic' - Envelope using the analytic signal.
% cfg.powenv.method = 'peak'     - Peak envelopes.

% cfg.powenv.uplow = 'upper' - Select upper envelope.
% cfg.powenv.uplow = 'lower' - Select lower envelope.

%% TRIAL AVERAGE:

cfg.trialaver.flag     = true;
cfg.trialaver.ntrials  = 3;
cfg.trialaver.order    = 'rand';

% cfg.trialaver.order = 'rand' - Random order.
% cfg.trialaver.order = 'seq'  - Secuential order.

%% BALANCED DATASETS:

cfg.classsize.match = true;
cfg.classsize.matchkfold = true;

%% DIMENSION REDUCTION:

% cfg.dimred.method = 'none' - Diemnsion reduction disabled.
% cfg.dimred.method = 'pca'  - Principal Component Analysis.

cfg.dimred.method = 'none';
cfg.dimred.ncomp  = 0;

%% DATA NORMALIZATION:

% cfg.normdata = 0 - raw data
% cfg.normdata = 1 - z-score (across features)
% cfg.normdata = 2 - z-score (across time)
% cfg.normdata = 3 - z-score (across trials)
% cfg.normdata = 4 - std_nor (across trials)

cfg.normdata = 4; 

%% DATA SMOOTHING:

% cfg.smoothdata.method = 'none'   - Data smooth disabled.
% cfg.smoothdata.method = 'moving' - Moving average method.

cfg.smoothdata.method   = 'moving';
cfg.smoothdata.window   = 5;

%% ANALYSIS TIMING:

cfg.tm.tpstart   = -100;
cfg.tm.tpend     = 1550;
cfg.tm.tpstart_   = -100;
cfg.tm.tpend_    = 1550;

cfg.tm.tpsteps   = 3;

%% CLASSIFICATION ALGORITHM:

% cfg.classmodel.method = 'svm' - Support Vector Machine.
cfg.classmodel.method = 'da'; % - Linear Discriminant Analysis.

% cfg.classmodel.kernel = 'linear'     - Support Vector Machine.
% cfg.classmodel.kernel = 'gaussian'   - Support Vector Machine.
% cfg.classmodel.kernel = 'rbf'        - Support Vector Machine.
% cfg.classmodel.kernel = 'polynomial' - Support Vector Machine.

% cfg.classmodel.kernel = 'linear' - Discriminant Analysis.
% cfg.classmodel.kernel = 'quadratic' - Discriminant Analysis.
% 
% cfg.classmodel.method = 'svm';
cfg.classmodel.kernel = 'linear';

%% HYPERPARAMETERS OPTIMIZATION:

cfg.classmodel.optimize.flag = false;
cfg.classmodel.optimize.params = {'BoxConstraint'};
cfg.classmodel.optimize.opt = struct('Optimizer','gridsearch',...
    'ShowPlots',false,'Verbose',0,'Kfold', 5);

%% PERFORMANCE METRICS:

cfg.classmodel.roc       = false;
cfg.classmodel.auc       = true;
cfg.classmodel.confmat   = false;
cfg.classmodel.precision = false;
cfg.classmodel.recall    = false;
cfg.classmodel.f1score   = false;
cfg.classmodel.wvector   = false;

%% EXTRA CONFIGURATION:

cfg.classmodel.tempgen = true;
cfg.classmodel.extdiag = true;
cfg.classmodel.parcomp = true;
cfg.classmodel.permlab = false;

%parallel computation
if license('test','Distrib_Computing_Toolbox')
    cfg.classmodel.parcomp = true;
else
    cfg.classmodel.parcomp = false;
end

%% CROSS-VALIDATIONN PROCEDURE:

% cfg.cv.method = 'kfold' - K-Fold cross-validation.
% cfg.cv.method = 'loo'   - Leave-one-out cross-validation.

cfg.cv.method  = 'kfold';
cfg.cv.nfolds  = 5;

%%SLIDING FILTER
cfg.sf.filesLocation = [cfg.location filesep 'filtered_datasets'];
cfg.sf.flag   = false;
cfg.sf.metric = 'auc';
cfg.sf.lfreq  = 0;
cfg.sf.hfreq  = 49;

cfg.sf.fspac  = 'log';
cfg.sf.nfreq  = 49;

%% PERMUTATION TEST

cfg.stats.flag   = 1;
cfg.stats.nper   = 100;
cfg.stats.nperg  = 1e5;
cfg.stats.pgroup = 95;
cfg.stats.pclust = 95;
cfg.stats.tails  = 2;
cfg.stats.shownulldis = 0;
