%% EEG-Competition Task (init.m)
% -------------------------------------------------------------------------
% CIMCYC - Universidad de Granada  - Code written by Paloma Díaz Gutiérrez y Chema G. Peñalver
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% This script creates the matrices of the trials that correspond to the
% specific subject in the session
%%                          ** CONDITIONS IN BLOCKS **
%% 1-> Targets / 2-> Distractors / 3-> Interference (1 = C; 2 = I)/ 4-> Gender (1 = F, 2 = M) /5--> Type of stimuli (1 = F; 2 = N)


%% 1. ISI
% -------------------------------------------------------------------------
Jitter1 = 1.5*ones(EPROP.nExpTrials, EPROP.nExpBlocks);
Jitter2 = 1.5*ones(EPROP.nExpTrials, EPROP.nExpBlocks);

P_Jitter1 = 1.5*ones(EPROP.nPraTrials, EPROP.nPraBlocks);
P_Jitter2 = 1.5*ones(EPROP.nPraTrials, EPROP.nPraBlocks);


%% 2. COUNTERBALANCE
% -------------------------------------------------------------------------
EDATA.Responses = CTB.Responses;
EDATA.BlockOrder = CTB.BlockOrder;
EDATA.HighBlocks = CTB.HighBlocks;
EDATA.LowBlocks = CTB.LowBlocks; 
EDATA.CueFaceHigh = CTB.CueFaceHigh;
EDATA.CueFaceLow = CTB.CueFaceLow;
EDATA.CueNameHigh = CTB.CueNameHigh;
EDATA.CueNameLow = CTB.CueNameLow;
%% 3. BLOCKS DEFINITION 
% -------------------------------------------------------------------------
%% 3.a. Counterbalanced order of high (1), low competition (2) and localizer (3)
EDATA.BlockType = CTB.BlockType;
       
%% 3.b. Allocating ISI in high and low competition blocks 
b = 0;

for c = 1:EPROP.nTotalBlocks
if EDATA.BlockType(c) == 1 || EDATA.BlockType(c) == 2
    b = b +1;
EDATA.Jitter1(:,c) = Jitter1(:,b);
EDATA.Jitter2(:,c) = Jitter2(:,b);
end
end

clear b c
%% 3.c. Specific block number (randomly ordered) that has to assign to high or low competition
    if EDATA.HighBlocks == 1 && EDATA.LowBlocks == 2  %Blocks type 1 (high in this example) are numbered from 1 to 12 and type 2 from 13 to 24
        EDATA.hb = randperm(EPROP.nTaskBlocks);
        lb = (EPROP.nTaskBlocks+1):(EPROP.nTaskBlocks*2);
        EDATA.lb = lb(randperm(length(lb)));
    elseif EDATA.HighBlocks == 2 && EDATA.LowBlocks == 1
        hb = (EPROP.nTaskBlocks+1):(EPROP.nTaskBlocks*2);
        EDATA.hb = hb(randperm(length(hb)));
        EDATA.lb = randperm(EPROP.nTaskBlocks);
    end

    EDATA.loc = randperm(EPROP.nLocBlocks);
clear lb hb

%% 3.d. Now arranging EPROP.nTotalBlocks blocks according to a) Order type of block, and b) Order blocks randomized
   counter_h = 0;%Counters to go across  EDATA.hb, EDATA.lb y EDATA.loc(size = 12)
   counter_l = 0;
   counter_loc = 0;
   for block = 1:EPROP.nTotalBlocks  %Going across block types to have the definitive block order
       if EDATA.BlockType(block) == 1 
           counter_h = counter_h + 1;
           EDATA.BlockDef(block) = EDATA.hb(counter_h); 
       elseif EDATA.BlockType(block) == 2
           counter_l = counter_l + 1;
           EDATA.BlockDef(block) = EDATA.lb(counter_l);
       else 
           counter_loc = counter_loc + 1;
           EDATA.BlockDef(block) = EDATA.loc(counter_loc);
       end
   end
   
clear counter_h counter_l counter_loc block
  
%% 4. TARGETS, DISTRACTORS, AND CONDITIONS DEFINITION 
% ------------------------------------------------------------------------- 
load ctb/Stim_Loc;
load ctb/Bloques

% Initializing all variables to use

EDATA.TypeStimuliAlt = num2cell(NaN(EPROP.nExpTrials, EPROP.nExpBlocks+EPROP.nLocBlocks));
EDATA.Cues = num2cell(NaN(EPROP.nExpTrials, EPROP.nExpBlocks+EPROP.nLocBlocks));
EDATA.GenderAlt = num2cell(NaN(EPROP.nExpTrials, EPROP.nExpBlocks+EPROP.nLocBlocks));
EDATA.InterferenceAlt = num2cell(NaN(EPROP.nExpTrials, EPROP.nExpBlocks+EPROP.nLocBlocks));
for c = 1:EPROP.nTotalBlocks %As many columns as blocks
    
    b = EDATA.BlockDef(c); %b stands for the number of the block after the randomization I did in 3.d.
    if EDATA.BlockType(c) == 1 || EDATA.BlockType(c) == 2
        EDATA.Targets(:,c) = Bloques{1,b}(:,1); %Looking for the targets assigned to the number of block in b
        EDATA.Distractors(:,c) = Bloques{1,b}(:,2); %Same for the rest of the variables
        EDATA.Interference(:,c) = Bloques{1,b}(:,3);
        EDATA.Gender(:,c) = Bloques{1,b}(:,4);
        EDATA.TypeStimuli(:,c)= Bloques{1,b}(:,5);
    else
        EDATA.StimLoc(:,c) = Stim_Loc{1,b}(:,1);%Looking for the specific stimuli in localizer blocks
        EDATA.TrialTypeLoc(:,c) = Stim_Loc{1,b}(:,2);%Type of trial in the localizer blocks (go/no go)
        EDATA.StimTypeLoc(:,c) = Stim_Loc{1,b}(:,3);%Type of category (face/name) of the stimuli in the localizer
    end
    
end

for c = 1:EPROP.nTotalBlocks
    aleat = randperm(EPROP.nExpTrials); %Random order for the trials, the same index will be used for the target, distractor, etc in the same trial
    for a = 1:length(aleat)
        pos = aleat(a); %Number of specific trial in each loop
        if EDATA.BlockType(c) == 1 || EDATA.BlockType(c) == 2
            EDATA.TargetsAlt{a,c} = EDATA.Targets{pos,c};
            EDATA.DistractorsAlt{a,c} = EDATA.Distractors{pos,c};
            EDATA.InterferenceAlt{a,c} = EDATA.Interference{pos,c};
            EDATA.GenderAlt{a,c} = EDATA.Gender{pos,c};
            EDATA.TypeStimuliAlt{a,c} = EDATA.TypeStimuli{pos,c};
        else
            EDATA.StimLocAlt{a,c} = EDATA.StimLoc{pos,c};
            EDATA.TrialTypeLocAlt{a,c} = EDATA.TrialTypeLoc{pos,c};
            EDATA.StimTypeLocAlt{a,c} = EDATA.StimTypeLoc{pos,c};
        end
    end
end

clear a b c aleat pos

%% 5. DEFINE CORRECT RESPONSES
% -------------------------------------------------------------------------

    if EDATA.Responses == 1 %Responses associated to male and females
        femResp = KEYS.a;
        maleResp = KEYS.l;
        respfem = 'A';
        respmal = 'L';
    else
        femResp = KEYS.a;
        maleResp = KEYS.l;
        respfem = 'A';
        respmal = 'L';
    end

    goResp = KEYS.c;
    respGo = 'C';
    respnoGo = NaN;
    
    for c = 1:EPROP.nTotalBlocks %We create a matrix with the correct responses of each trial in all the experiment
        for r = 1:EPROP.nExpTrials
            if EDATA.BlockType(c) == 1 || EDATA.BlockType(c) == 2
                if EDATA.GenderAlt{r,c} == 1
                    EDATA.CorrResp(r,c) = femResp;
                else
                    EDATA.CorrResp(r,c) = maleResp;
                end
            else
                if strcmp(EDATA.TrialTypeLocAlt{r,c}, 'go') == 1
                    EDATA.CorrResp(r,c) = respGo;
                else
                    EDATA.CorrResp(r,c) = respnoGo;
                end
            end
        end
    end
    
clear c r

%% 6. CUE DEFINITION
% -------------------------------------------------------------------------
%We assign the cues for each trial, according to the type of block and
%stimulus

   
counth = 0;
countl = 0;

    for c = 1:EPROP.nTotalBlocks
        if EDATA.BlockType(c) == 1
            counth = counth +1;
            for r = 1:EPROP.nExpTrials
                if EDATA.TypeStimuliAlt{r,c} == 1
                    EDATA.Cues{r,c} = EDATA.CueFaceHigh(counth);
                else
                    EDATA.Cues{r,c} = EDATA.CueNameHigh(counth);
                end
            end
            EDATA.BlockCuesFace{c} = EDATA.CueFaceHigh(counth);
            EDATA.BlockCuesName{c} = EDATA.CueNameHigh(counth);
        elseif EDATA.BlockType(c) == 2
            countl = countl + 1;
            for r = 1:EPROP.nExpTrials
                if EDATA.TypeStimuliAlt{r,c} == 1
                    EDATA.Cues{r,c} = EDATA.CueFaceLow(countl);
                else
                    EDATA.Cues{r,c} = EDATA.CueNameLow(countl);
                end
            end
            EDATA.BlockCuesFace{c} = EDATA.CueFaceLow(countl);
            EDATA.BlockCuesName{c} = EDATA.CueNameLow(countl);
        end
    end

clear counth countl c r 
%% 7. SELECTING BLOCKS AND TRIALS FOR THE PRACTICE

for c = 1:EPROP.nPraBlocks
    
    PRACT.BlockType(c) = EDATA.BlockType(c);
    
    ff = randperm(EPROP.nExpTrials/4,EPROP.nPraTrials/4); fm = randperm(EPROP.nExpTrials/4,EPROP.nPraTrials/4); fm = fm+EPROP.nExpTrials/4;
    nf = randperm(EPROP.nExpTrials/4,EPROP.nPraTrials/4); nf = nf+EPROP.nExpTrials/2; nm = randperm(EPROP.nExpTrials/4,EPROP.nPraTrials/4); nm = nm + EPROP.nExpTrials/4*3;
    t = [ff fm nf nm]';
    
    for i = 1:length(t)
        pos = t(i);
        if  PRACT.BlockType(c) == 1 ||  PRACT.BlockType(c) == 2
            PRACT.Targets{i,c} = EDATA.Targets{pos,c};
            PRACT.Distractors{i,c} = EDATA.Distractors{pos,c};
            PRACT.Interference{i,c} = EDATA.Interference{pos,c};
            PRACT.Gender{i,c} = EDATA.Gender{pos,c};
            PRACT.TypeStimuli{i,c} = EDATA.TypeStimuli{pos,c};
        else
            PRACT.StimLoc{i,c} = EDATA.StimLoc{pos,c}; 
            PRACT.StimTypeLoc{i,c} =  EDATA.StimTypeLoc{pos,c};
        end
    end
end

clear c r ff fm nf nm t i pos 

%% 7.b For the practice we also randomize the conditions and cues
load ctb/Stim_Loc 

    for c = 1:EPROP.nPraBlocks
        aleat = randperm(EPROP.nPraTrials); %Randomizing the same way as before
        for a = 1:length(aleat)
            pos = aleat(a); 
            if  PRACT.BlockType(c) == 1 ||  PRACT.BlockType(c) == 2
                PRACT.TargetsAlt{a,c} = PRACT.Targets{pos,c};
                PRACT.DistractorsAlt{a,c} = PRACT.Distractors{pos,c};
                PRACT.InterferenceAlt{a,c} = PRACT.Interference{pos,c};
                PRACT.GenderAlt{a,c} = PRACT.Gender{pos,c};
                PRACT.TypeStimuliAlt{a,c} = PRACT.TypeStimuli{pos,c};
            else
                PRACT.StimLocAlt{a,c} = PRACT.StimLoc{pos,c};
                PRACT.StimTypeLocAlt{a,c} = PRACT.StimTypeLoc{pos,c};    
                 tr  = randperm(EPROP.nPraTrials);
                 for j = 1:EPROP.nPraTrials
                     t = tr(j);
                     PRACT.TrialTypeLocAlt{j,c} = Type_trial_Loc{t,1};
                 end
            end
        end
    
    
    %Assigning cues for the practice 
    if PRACT.BlockType(c) == 1 || PRACT.BlockType(c) == 2
        for r = 1:EPROP.nPraTrials
            if PRACT.TypeStimuliAlt{r,c} == 1
                PRACT.Cues(r,c) = EDATA.BlockCuesFace(c);
            else
                PRACT.Cues(r,c) = EDATA.BlockCuesName(c);
            end
        end
        PRACT.BlockCuesFace(c) = EDATA.BlockCuesFace(c);
        PRACT.BlockCuesName(c) = EDATA.BlockCuesName(c);
    end
    end

clear c r aleat a pos 

%Defining the answers for the practice
for c = 1:EPROP.nPraBlocks %Matrix for the correct responses
    for r = 1:EPROP.nPraTrials
        if PRACT.BlockType(c) == 1 || PRACT.BlockType(c) == 2
            if PRACT.GenderAlt{r,c} == 1
                PRACT.CorrResp(r,c) = femResp;
            else
                PRACT.CorrResp(r,c) = maleResp;
            end
        else
            if strcmp(PRACT.TrialTypeLocAlt{r,c}, 'go') == 1
                PRACT.CorrResp(r,c) = respGo;
            else
                PRACT.CorrResp(r,c) = respnoGo;
            end
        end
    end
end

clear c r


%% We make matrices for the triggers of the cue, targets and distractors

% Triggers CUE

for c = 1:EPROP.nTotalBlocks
    for r = 1:EPROP.nExpTrials
        if EDATA.TypeStimuliAlt{r,c} == 1
            if EDATA.Cues{r,c} == 1
             EDATA.CueTrigger{r,c} = 1;   
            elseif EDATA.Cues{r,c} == 2
                EDATA.CueTrigger{r,c} = 2;
            elseif EDATA.Cues{r,c} == 3
                EDATA.CueTrigger{r,c} = 3;
            elseif EDATA.Cues{r,c} == 4
                EDATA.CueTrigger{r,c} = 4;
            end
        else
            if EDATA.Cues{r,c} == 1
                EDATA.CueTrigger{r,c} = 5; 
            elseif EDATA.Cues{r,c} == 2
                EDATA.CueTrigger{r,c} = 6;
            elseif EDATA.Cues{r,c} == 3
                EDATA.CueTrigger{r,c} = 7;
            elseif EDATA.Cues{r,c} == 4
                EDATA.CueTrigger{r,c} = 8;
            end
        end
    end
end
clear c r

% Triggers TARGET
for c = 1:EPROP.nTotalBlocks
    for r = 1:EPROP.nExpTrials
        if EDATA.TypeStimuliAlt{r,c} == 1
            if EDATA.GenderAlt{r,c} == 1
                if EDATA.InterferenceAlt{r,c} == 1
                    EDATA.TargTrigger{r,c} = 17;
                else
                    EDATA.TargTrigger{r,c} = 18;
                end
            else
                if EDATA.InterferenceAlt{r,c} == 1
                    EDATA.TargTrigger{r,c} = 19;
                else
                    EDATA.TargTrigger{r,c} = 20;
                end
            end
        else
            if EDATA.GenderAlt{r,c} == 1
                if EDATA.InterferenceAlt{r,c} == 1
                    EDATA.TargTrigger{r,c} = 21;
                else
                    EDATA.TargTrigger{r,c} = 22;
                end
            else
                if EDATA.InterferenceAlt{r,c} == 1
                    EDATA.TargTrigger{r,c} = 23;
                else
                    EDATA.TargTrigger{r,c} = 24;
                end
            end
        end
    end
end
clear c r

% Triggers DISTRACTOR

for c = 1:EPROP.nTotalBlocks
    for r = 1:EPROP.nExpTrials
        if EDATA.TypeStimuliAlt{r,c} == 1
            if EDATA.GenderAlt{r,c} == 1
                if EDATA.InterferenceAlt{r,c} == 1
                    EDATA.DistTrigger{r,c} = 25;
                else
                    EDATA.DistTrigger{r,c} = 26;
                end
            else
                if EDATA.InterferenceAlt{r,c} == 1
                    EDATA.DistTrigger{r,c} = 27;
                else
                    EDATA.DistTrigger{r,c} = 28;
                end
            end
        else
            if EDATA.GenderAlt{r,c} == 1
                if EDATA.InterferenceAlt{r,c} == 1
                    EDATA.DistTrigger{r,c} = 29;
                else
                    EDATA.DistTrigger{r,c} = 30;
                end
            else
                if EDATA.InterferenceAlt{r,c} == 1
                    EDATA.DistTrigger{r,c} = 31;
                else
                    EDATA.DistTrigger{r,c} = 32;
                end
            end
        end
    end
end
clear c r

% Triggers LOCALIZER

for c = 1:EPROP.nTotalBlocks
    for r = 1:EPROP.nExpTrials
        if EDATA.BlockType(c) == 3
            if EDATA.StimTypeLocAlt{r,c} ==  1
                if strcmp(EDATA.TrialTypeLocAlt{r,c}, 'go') == 1
                    EDATA.LocTrigger{r,c} = 33;
                else
                    EDATA.LocTrigger{r,c} = 34;
                end
            else
                if strcmp(EDATA.TrialTypeLocAlt{r,c}, 'go') == 1
                    EDATA.LocTrigger{r,c} = 35;
                else
                    EDATA.LocTrigger{r,c} = 36;
                end
            end
        end
    end
end

clear c r