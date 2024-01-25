%% EEG-Competition Task (session.m)
% -------------------------------------------------------------------------
% CIMCYC - Universidad de Granada  - Code written by Paloma Díaz Gutiérrez y Chema G. Peñalver
% -------------------------------------------------------------------------
% This script opens a GUI to introduce the information about the
% participant and the session
%% 1. FOR 2016B+ MATLAB VERSIONS - START UI APP DESIGNER
% -------------------------------------------------------------------------
% sessionapp = expStart;
% guiFigureHandle = sessionapp.SessionconfigurationUIFigure;
% uiwait(guiFigureHandle);
% 
% if SUBJECT_INFO.id == false
%     error('Experiment cancelled.')
% end


 %% 1. FOR OLDER MATLAB VERSIONS - INPUT DIALOG
% % ----------------------------------------------------------
prompt = {
    'Subject''s ID:',...
    'Age', ...
    'Gender',...
    'Handedness',...
    'Vision',...
    'Researcher',...
    'Distance'
    };

defaultsData = {
    '001',... 
    '18',...
    'Female', ...
    'Righthanded',...
    'Normal',...
    'Blanca',...
    '60'
    };

numLines = [1 50];

wTitle = 'Session configuration:';


%% 2. SHOW INPUT DIALOG:
% ----------------------------------------------------------
sessionConf = inputdlg(prompt, wTitle, numLines, defaultsData);


%% 3. DATA MAPPING:
% ----------------------------------------------------------
[SUBJECT_INFO.id,...
    SUBJECT_INFO.age,... 
    SUBJECT_INFO.gender, ...
    SUBJECT_INFO.handedness, ...
    SUBJECT_INFO.vision,...    
    SUBJECT_INFO.researcher,...
    SUBJECT_INFO.distance] = deal(sessionConf{:});

SUBJECT_INFO.date = clock;


%% 4. CREATE DIRECTORY (if not exist):
% ----------------------------------------------------------

if str2double(SUBJECT_INFO.id) ~= 0
    SUBJECT_INFO.dirName = (['../DATA/DATA_S' SUBJECT_INFO.id]);
    if exist(SUBJECT_INFO.dirName,'dir') == 0
        mkdir (SUBJECT_INFO.dirName);
    else
        uiwait(errordlg('Upps! This directory already exist. Please delete it or change subject''s ID','Error: This directory already exist.','modal'));
        clear all
        
        error('Upps! This directory already exist. Please delete it or change subject''s ID');
    end
end

clear workspace
clear prompt defaultsData numLines wTitle sessionConf