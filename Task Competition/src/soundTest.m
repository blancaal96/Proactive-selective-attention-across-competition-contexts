%% This script serves to test how the sound of the feedback sounds
% -------------------------------------------------------------------------
% David L�pez Garc�a
% dlopez@ugr.es
% CIMCYC - Universidad de Granada  - Adapted by Paloma D�az Guti�rrez
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
