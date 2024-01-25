%% EEG-Competition Task (ptb.m)
% -------------------------------------------------------------------------
% CIMCYC - Universidad de Granada  - Code written by Paloma Díaz Gutiérrez y Chema G. Peñalver
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% This script contains the psychtoolbox configuration and preloads the
% images that will be used
%% 1. PSYCHTOOLBOX GENERAL CONFIGURATION:
% -----------------------------------------------

PsychDefaultSetup(2);                                                       % Level 2 boilerplate setup           
rng('shuffle');                                                             % Matlab randomization
KbName('UnifyKeyNames');                                                    % Operating system specific key scheme

%% 2. PSYCHTOOLBOX SCREEN CONFIGURATION:
% -----------------------------------------------
if IsWin
    Screen('Preference', 'SkipSyncTests', 0);                               % Enable screen test
else
    Screen('Preference', 'SkipSyncTests', 1);                               % Disable screen test
end

PTB.screens = Screen('Screens');  
% All screen connected
PTB.screenNumber = max(PTB.screens);                                        % Select external screen
% Screen('Resolution', screenNumber, 1280,800);
[PTB.screenResX, PTB.screenResY] = Screen('WindowSize', ...
    PTB.screenNumber);
PTB.centerX = PTB.screenResX/2;                                             % Center horizontal
PTB.centerY = PTB.screenResY/2;                                             % Center vertical
AssertOpenGL; % AssertOpenGL

screenRect  = Screen(0, 'rect');

%% 3. PSYCHTOOLBOX WINDOW CONFIGURATION:
% ----------------------------------------------- 

if IsWin
    [PTB.window, PTB.windowRect] = PsychImaging('OpenWindow',...
        PTB.screenNumber, COL.grey, [0 0 PTB.screenResX PTB.screenResY]);                                       % Open an on screen window
else
    [PTB.window, PTB.windowRect] = PsychImaging('OpenWindow',...
     PTB.screenNumber, COL.grey, [0 0 PTB.screenResX PTB.screenResY]);                           % Nice for debugging
%      PTB.centerX = 960/2;%     PTB.centerX = 1440/2;                                                        % Nice for debugging
%      PTB.centerY = 600/2; %     PTB.centerY = 900/2;                                                       % Nice for debugging
end

Priority(MaxPriority(PTB.window));                                          % Maximum priority level
PTB.ifi = Screen('GetFlipInterval', PTB.window);                            % Interframe interval
 Screen('BlendFunction', PTB.window, ...
    'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');                              % Anti-aliased lines
 HideCursor(PTB.window);% Hide cursor
 
 
 %% 4. LOADING IMAGES
% -------------------------------------------------------------------------

%% Starting images
BRAIN.start = imread('img/start.jpg');
BRAIN.startTexture = Screen('MakeTexture', PTB.window, BRAIN.start);

BRAIN.brain = imread('img/brain.jpg'); 
BRAIN.brainTexture = Screen('MakeTexture', PTB.window, BRAIN.brain);

BRAIN.brainSmall = imread('img/brainSmall.png'); 
BRAIN.brainSmallTexture = Screen('MakeTexture', PTB.window, BRAIN.brainSmall);

%% Instructions images

INS.stimuli = imread('img/estimulos.png');
INS.stimuli_Texture = Screen('MakeTexture', PTB.window, INS.stimuli);

INS.blocks = imread('img/bloques.png');
INS.blocks_Texture = Screen('MakeTexture', PTB.window, INS.blocks);

if EDATA.Responses == 2
INS.responses = imread('img/respuestas1.png');
INS.responses_Texture(1) = Screen('MakeTexture', PTB.window, INS.responses);
else
INS.responses = imread('img/respuestas2.png');
INS.responses_Texture = Screen('MakeTexture', PTB.window, INS.responses);
end

%% Targets and distractors

imgs = {'F1', 'F2', 'F3', 'F4', 'F5', 'F6', 'F7', 'F8', 'F9', 'F10', 'F11', 'F12', 'M1', 'M2', 'M3', 'M4', 'M5', 'M6', 'M7', 'M8', 'M9', 'M10', 'M11', 'M12'};

for img = 1:24
    IMG.image{img,1} = imread(['stim/faces/', imgs{img}, '.png']);
    IMG.name{img,1} = imgs{img};
    IMG.Texture{img,1} = Screen ('MakeTexture', PTB.window, IMG.image{img,1});
end

%% CUES
for j = 1:8
    C{j,1} = imread(['cues/',num2str(j) '.png']);
    CUE.Texture{j,1} = Screen ('MakeTexture', PTB.window, C{j,1});
end

%% Position of the cues:
Ex_stim = [0 0 0.42*PTB.screenResX PTB.screenResY/3]; %Size of picture
Ex_resp = [0 0 0.43*PTB.screenResX 0.3*PTB.screenResY]; %Size of picture
RectDims = [0 0 150 140]; %Size of rect
Dim_stim = [0 0 PTB.screenResX/2.88 PTB.screenResY/1.29]; %Size of picture
Dim_word = [0 0 PTB.screenResX/2.88 PTB.screenResY/6]; %Size of word

% Position example stimuli
example_loc = CenterRectOnPointd(Ex_stim*0.9,PTB.centerX,PTB.centerY);
% Position example responses
resp_loc = CenterRectOnPointd(Ex_resp,PTB.centerX,PTB.centerY+50);
% Position cues at the begging of the experiment

UpLeft = CenterRectOnPointd(RectDims,PTB.centerX/1.25,PTB.centerY);
UpRight = CenterRectOnPointd(RectDims,PTB.centerX*1.15,PTB.centerY);
DownLeft = CenterRectOnPointd(RectDims,PTB.centerX/1.25,PTB.centerY+150);
DownRight = CenterRectOnPointd(RectDims,PTB.centerX*1.15,PTB.centerY+150);

% Position of cues at the beggining of each block
LocationFaceCue = CenterRectOnPointd(RectDims, PTB.centerX-170, PTB.centerY+150);
LocationNameCue = CenterRectOnPointd(RectDims, PTB.centerX+170, PTB.centerY+150);

% Position of stimuli images and size
LocStim = CenterRectOnPointd(Dim_stim*0.55, PTB.centerX, PTB.centerY);

% Position of names stimuli and size
LocWord = CenterRectOnPointd(Dim_word*0.8, PTB.centerX, PTB.centerY);
% Showing the welcome image
Screen('DrawTexture', PTB.window, BRAIN.startTexture);
Screen('Flip', PTB.window); 
WaitSecs(2);
