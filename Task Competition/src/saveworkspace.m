%% This script saves the relevant variables in the workspace
% -------------------------------------------------------------------------
% CIMCYC - Universidad de Granada  - Code written by Paloma D�az Guti�rrez y Chema G. Pe�alver
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% Script for saving all the data

%% 1. SET FINAL TIMESTAMP:
% ----------------------------------------------------------
finalTimeStamp = GetSecs;
date = clock;
SUBJECT_INFO.finalTimeStamp = [
    int2str(date(3)) '/'...
    int2str(date(2)) '/'...
    int2str(date(1)) ' '...
    int2str(date(4)) ':'...
    int2str(date(5))
    ];

%% 2. SAVE THE WORKSPACE:
% ----------------------------------------------------------
if str2double(SUBJECT_INFO.id) ~= 0
    save ([SUBJECT_INFO.dirName '/S' SUBJECT_INFO.id '_OUTPUT.mat'],...
        'SUBJECT_INFO',...
        'OUT_P',...
        'OUT_E',...
        'CTB',...
        'EDATA',...
        'EPROP',...
        'initialTimeStamp',...
        'finalTimeStamp',...
        'TRIGHIST');

end

%% 3. CLEAR THE WORKSPACE:
% ----------------------------------------------------------
clear ans block BlockCueFace BlockCueName Bloques BRAIN C CTB CUE;
clear date Dim_stim distractorOnsetTime DownLeft1 DownLeft2 DownRight1 DownRight2;
clear EPROP FaceCue FaceHigh FaceLow femResp FH1 FH2 finalTimeStamp;
clear FL1 FL2 guiFigureHandle i idx img IMG imgs initialTimeStamp;
clear INS j KEYS LocationFaceCue LocationNameCue LocStim maleResp;
clear NameCue NameHigh NameLow NH1 NH2 NL1 NL2 PathCurrent;
clear RectDims respfem respmal screenRect sessionapp struc SUBJECT_INFO t;
clear target_distractOnsetTime targetOnsetTime TRIGHIST;
clear UpLeft1 UpLeft2 UpRight1 UpRight2;
clear EndofExperiment isPracticeBlock;
clear PathCurrent PRACT struct
