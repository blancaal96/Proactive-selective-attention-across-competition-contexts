%% EEG-Competition Task (conf.m)
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% CIMCYC - Universidad de Granada  - Code written by Paloma Díaz Gutiérrez y Chema G. Peñalver
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% This script introduces all the experiment's parameters
%% 1. EXPERIMENT'S PARAMETERS : BLOCKS AND TRIALS PER BLOCK
% ----------------------------------------------------------
EPROP.nExpBlocks = 48;
EPROP.nPraBlocks = 6;
EPROP.nLocBlocks = 24;
EPROP.nTotalBlocks = 72;
EPROP.nTaskBlocks = 24;
generate_nan = true; %Turn to false if you need to start from the middle of the task
EPROP.firstBlock = 1; %Block where the task starts, normally block 1 but if the task fails in the middle, start where it stopped (there are 72 blocks)



EPROP.nExpTrials = 24;
EPROP.nPraTrials = 24; %Always multiple of 4
EPROP.nLocTrials = 24;
%% 2. EXPERIMENT'S PARAMETERS : DURATIONS
% ----------------------------------------------------------
EPROP.cueDuration = 0.05;
EPROP.targetHBDuration = 0.75;
EPROP.targetLBDuration = 0.5;
EPROP.distractorLBDuration = 0.5;
EPROP.target_distDuration = 0.25;
EPROP.distractorDuration = 0.75;
EPROP.stimLocDuration = 0.75;
EPROP.fixLocDuration = 0.5;
EPROP.feedbackDuration = 1;
EPROP.respTime = 1.5;

%% 3. EXPERIMENT'S PARAMETERS : COLORS
% ----------------------------------------------------------
COL.black = [0, 0, 0];
COL.grey = [0.5, 0.5, 0.5];

%% 4. EXPERIMENT'S PARAMETERS : TEXT SIZE AND FONTS
% ----------------------------------------------------------
CONS.insSmallSize = 20 ;
CONS.insTextSize = 25;
CONS.insTitleSize = 40;

CONS.fixSize = 50;
CONS.nameSize = 80;

CONS.insTitleFamily = 'Helvetica';
CONS.insFontFamily = 'Arial';
CONS.trialFontFamily = 'Arial';


% %% 5. EXPERIMENT'S PARAMETERS : PARALLEL PORT CONFIGURATION
% % ----------------------------------------------------------
% % Note 1: PPORT.object is an instance of the object io64.
% % Note 2: PPORT.addres correspond to a LPT3 port.
% % Note 3: PPORT.status 0 == Ready for read\write data.
% % Note 4: This function (io64) is only supported on Windows 64-bits.
% % Note 5: Download & instr: http:\\apps.usd.edu\coglab\psyc770\IO64.html
% 
% if IsWin
%     addpath('C:\Users\Usuario\Desktop\EEG_Competition Task_def\src\mexf\io64');
%     PPORT.OBJECT = io64;
%     PPORT.ADDRESS = hex2dec('DEFC'); 
%     PPORT.status = io64(PPORT.OBJECT);
% 
%     if PPORT.status
%         uiwait(warndlg({'Parallel port connection error.';'Press OK to continue.'},'Warning!'));
%     end
% else
%     PPORT.status = 1;
%     PPORT.OBJECT = NaN;
%     PPORT.ADDRESS = NaN;
%     uiwait(warndlg({'No parallel port connection.';'Press OK to continue.'},'Warning!'));
% end
% 
%% 6. EXPERIMENT'S PARAMETERS : TRIGGERS DEFINITION
% % ----------------------------------------------------------
% % Note 1: Configuration for BrainVision and PyCoder.
 
%% CUES:
TRIG.CUE_FACE_SQUARE = 1;
TRIG.CUE_FACE_CIRCLE = 2;
TRIG.CUE_FACE_DROP = 3;
TRIG.CUE_FACE_DIAMOND = 4;
TRIG.CUE_NAME_SQUARE = 5;
TRIG.CUE_NAME_CIRCLE = 6;
TRIG.CUE_NAME_DROP = 7;
TRIG.CUE_NAME_DIAMOND = 8;
 
%% TARGET
TRIG.TAR_FACE_F_C = 17;
TRIG.TAR_FACE_F_I = 18;
TRIG.TAR_FACE_M_C = 19;
TRIG.TAR_FACE_M_I = 20;
TRIG.TAR_NAME_F_C = 21;
TRIG.TAR_NAME_F_I = 22;
TRIG.TAR_NAME_M_C = 23;
TRIG.TAR_NAME_M_I = 24;
 
%% DISTRACTOR
TRIG.DIS_FACE_F_C = 25;
TRIG.DIS_FACE_F_I = 26;
TRIG.DIS_FACE_M_C = 27;
TRIG.DIS_FACE_M_I = 28;
TRIG.DIS_NAME_F_C = 29;
TRIG.DIS_NAME_F_I = 30;
TRIG.DIS_NAME_M_C = 31;
TRIG.DIS_NAME_M_I = 32;

%% LOCALIZER
TRIG.LOC_FACE_GO = 33;
TRIG.LOC_FACE_NOGO = 34;
TRIG.LOC_NAME_GO = 35;
TRIG.LOC_NAME_NOGO = 36;

%% TARGET RESPONSES
TRIG.RSP_Resp = 37;
TRIG.RSP_Corr = 38;
TRIG.RSP_Wrong = 39;
% 
%% BLOCKS AND OTHERS
TRIG.EXP_STR = 40; %Start of the experiment
TRIG.BLK_HIGH = 41;	% Start of high competition block
TRIG.BLK_LOW = 42;	% Start of low competition block
TRIG.BLK_LOC = 43;	% Start of localizer block
TRIG.BLK_1 = 44;	% Block1
TRIG.BLK_2 = 45;	% Block2
TRIG.BLK_3 = 46;	% Block3
TRIG.BLK_4 = 47;	% Block4
TRIG.BLK_5 = 48;	% Block5
TRIG.BLK_6 = 49;	% Block6
TRIG.BLK_7 = 50;	% Block7
TRIG.BLK_8 = 51;	% Block8
TRIG.BLK_9 = 52;	% Block9
TRIG.BLK_10 = 53;	% Block10
TRIG.BLK_11 = 54;	% Block11
TRIG.BLK_12 = 55;	% Block12
TRIG.BLK_13 = 56;	% Block13
TRIG.BLK_14 = 57;	% Block14
TRIG.BLK_15 = 58;	% Block15
TRIG.BLK_16 = 59;	% Block16
TRIG.BLK_17 = 60;	% Block17
TRIG.BLK_18 = 61;	% Block18
TRIG.BLK_19 = 62;	% Block19
TRIG.BLK_20 = 63;	% Block20
TRIG.BLK_21 = 64;	% Block21
TRIG.BLK_22 = 65;	% Block22
TRIG.BLK_23 = 66;	% Block23
TRIG.BLK_24 = 67;	% Block24
TRIG.BLK_25 = 68;	% Block25
TRIG.BLK_26 = 69;	% Block26
TRIG.BLK_27 = 70;	% Block27
TRIG.BLK_28 = 71;	% Block28
TRIG.BLK_29 = 72;	% Block29
TRIG.BLK_30 = 73;	% Block30
TRIG.BLK_31 = 74;	% Block31
TRIG.BLK_32 = 75;	% Block32
TRIG.BLK_33 = 76;	% Block33
TRIG.BLK_34 = 77;	% Block34
TRIG.BLK_35 = 78;	% Block35
TRIG.BLK_36 = 79;	% Block36

%% 7. EXPERIMENT'S PARAMETERS : KEY NUMBER (DEPEND ON OS)
% ----------------------------------------------------------
% Note: Using KbDemo you can get the correct key number depending on the
% operative system you are running.

if ismac
    KEYS.a = KbName('a');
    KEYS.l = KbName('l');
    KEYS.c = KbName('c');
elseif IsWin
    KEYS.a = KbName('a');
    KEYS.l = KbName('l');
    KEYS.c = KbName('c');
elseif IsLinux
    KEYS.a = KbName('a');
    KEYS.l = KbName('l');
    KEYS.c = KbName('c');
end

if generate_nan
    OUT_P.ACC = NaN(EPROP.nPraTrials, EPROP.nPraBlocks);
    OUT_P.interference = cell(EPROP.nPraTrials, EPROP.nPraBlocks);
    OUT_P.RT = NaN(EPROP.nPraTrials, EPROP.nPraBlocks);
    OUT_E.ACC = NaN(EPROP.nLocTrials, EPROP.nTotalBlocks);
    OUT_E.interfence = cell(EPROP.nLocTrials, EPROP.nTotalBlocks);
    OUT_E.RT = NaN(EPROP.nLocTrials, EPROP.nTotalBlocks);
end