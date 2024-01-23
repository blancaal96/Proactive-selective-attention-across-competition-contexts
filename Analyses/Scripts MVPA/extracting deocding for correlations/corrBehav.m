%averaging decoding for correlations
clear;
%HIGH COMPETITION
%Load decoding results
%load ('E:\Mi unidad\Experimento competition\DATA\EEG\Analisis multi\cross class (c1 n1 c2 n2) y (c1 n2 c2 n1) hi media direcciones\results\time_resolved\auc\result.mat');


%% Mean of each participant auc entre el 1150ms y el 1550ms M tiene que ser 36x1
for i=1:36
%M(i)= mean(result(1,108:142,i)); %This window is for category specific
%anticipation from 1150 to 1550ms
M(i)= mean(result(1,19:142,i)); %This window from 100ms to 1550 ms for the competition level anticipation
end
M=M';






