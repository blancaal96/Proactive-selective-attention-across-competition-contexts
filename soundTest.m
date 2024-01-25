%% EVENT-RELATED POTENTIALS TEST (soundTest.m)
% -------------------------------------------------------------------------
% David López García       
% dlopez@ugr.es
% CIMCYC - Universidad de Granada  - Adapted by Paloma Díaz Gutiérrez
% -------------------------------------------------------------------------

%% 1. SET PATH
% -------------------------------------------------------------------------
[~,struc] = fileattrib;
PathCurrent = struc.Name;
path(path,[PathCurrent '/func']);

%% 2. SOUND TEST
% -------------------------------------------------------------------------
for i = 1 : 20
    soundFeedback();
    pause(0.5);
end

%% 3. SET PATH
% -------------------------------------------------------------------------
rmpath([PathCurrent '/func']);
clear PathCurrent