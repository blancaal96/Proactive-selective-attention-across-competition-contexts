%% EEG-Competition Tas (ctb.m)
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% CIMCYC - Universidad de Granada  - Code written by Paloma Díaz Gutiérrez y Chema G. Peñalver
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% This script is for the counterbalance configuration of the experiment
%% COLUMNS: 1--> Response Mappings, 2 --> BlockOrder, 3 --> BlockHigh, 4-->BlockLow

%% 1. LOAD COUNTERBALANCE MATRIX and CONDITIONS BLOCKS:
% ----------------------------------------------------------
load ctb\ctbMatrix;
load ctb\Cues

%% 2. SUBJECT ID:
% ----------------------------------------------------------
if str2double(SUBJECT_INFO.id)
    idx = mod(str2double(SUBJECT_INFO.id),length(ctb(:,1)));
    if idx == 0
        idx = length(ctb(:,1));
    end
else
    idx = 1;
end

%% 3. COUNTERBALANCE INITIALIZATION:
% ----------------------------------------------------------
CTB.Responses = ctb(idx, 1);
CTB.BlockOrder = ctb(idx, 2);
CTB.HighBlocks = ctb(idx, 3);
CTB.LowBlocks = ctb(idx, 4);
CTB.CueFaceHigh = cues_faces_high(idx,:);
CTB.CueFaceLow = cues_faces_low(idx,:);
CTB.CueNameHigh = cues_names_high(idx,:);
CTB.CueNameLow = cues_names_low(idx, :);
CTB.BlockType = BlockTypeMtx(idx, :);

clear ctb cues_faces_high cues_faces_low cues_names_high cues_names_low BlockTypeMtx