%clear 
clc

%Load first condition high
dir1 = 'E:\Mi unidad\Experimento competition\DATA\EEG\Analisis multi\cross class (c1 n1 c2 n2) y (c1 n2 c2 n1) hi media direcciones\results\temporal_generalization\';
load([dir1 'auc\result.mat']);
cond1.res = result; 

% load second condition (low)
dir1 = 'E:\Mi unidad\Experimento competition\DATA\EEG\Analisis multi\cross class (c1 n1 c2 n2) y (c1 n2 c2 n1) lo media direcciones\results\temporal_generalization\';
load([dir1 'auc\result.mat']);
cond2.res = result; %save results and permaps before loading second condition
cond2.loc = cfg.location;

nper =5000;
fprintf (['Attention! \n'])
[res,per] = ttest_res3(cond1,cond2,nper);  %performs the analysis and generates permutations. 
%Output res stores t and p values of each timepoint. Output per stores 5000 values (from the permutations) x number of timepoints
stats = ttest_permtest3(res,per);  %estimates significant cluster sizes

savedir = ['E:\Mi unidad\Experimento competition\DATA\EEG\Analisis multi\ttest hi vs lo\temp_generalization\'];
if ~isdir (savedir)
    mkdir (savedir)
end
save([savedir 'result'], 'cfg', 'stats','res', 'per'); 
