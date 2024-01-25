%% DISPLAY OF THE TRIALS WITHIN A BLOCK
% -------------------------------------------------------------------------
% CIMCYC - Universidad de Granada  - Code written by Paloma Díaz Gutiérrez y Chema G. Peñalver
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% This script goes across the matrix of the block containing the trials of high or low competition blocks and
% presents the sequence of stimuli in that trial
RestrictKeysForKbCheck([]);
Screen('FillRect', PTB.window, COL.grey)
Screen('TextFont', PTB.window, CONS.trialFontFamily);
Screen('Flip', PTB.window);

if isPracticeBlock
    trialNumber = EPROP.nPraTrials;
    feedback = true;
    jit1 = EDATA.Jitter1;
    jit2 = EDATA.Jitter2;
    blocktype = PRACT.BlockType;
    cue = PRACT.Cues;
    stim = PRACT.TargetsAlt;
    stimRes = PRACT.CorrResp;
    distrac = PRACT.DistractorsAlt;
    stim_type = PRACT.TypeStimuliAlt;
    gender = PRACT.GenderAlt;
    interference = PRACT.InterferenceAlt;
else
    trialNumber = EPROP.nExpTrials;
    feedback = false;
    jit1 = EDATA.Jitter1;
    jit2 = EDATA.Jitter2;
    blocktype = EDATA.BlockType;
    cue = EDATA.Cues;
    stim = EDATA.TargetsAlt;
    stimRes = EDATA.CorrResp;
    distrac = EDATA.DistractorsAlt;
    stim_type = EDATA.TypeStimuliAlt;
    gender = EDATA.GenderAlt;
    interference = EDATA.InterferenceAlt;
    cueTrigger = EDATA.CueTrigger;
    targTrigger = EDATA.TargTrigger;
    distTrigger = EDATA.DistTrigger;
    
end

%% Fixation point at the beggining of the block
    Screen('TextSize', PTB.window, CONS.fixSize);
    DrawFormattedText(PTB.window, '+', 'center', 'center', COL.black );
    marg = Screen('Flip', PTB.window);    
    WaitSecs(2);

for trl = 1:trialNumber
    
    %% TRIAL RESET
    ACC = 0;
    rt = NaN;
    Resp = NaN;
    press = NaN;
    stimOnsetTime = NaN;
    CueSelect = NaN;
    TrialCue = NaN;
    cueOnsetTime = NaN;
    Target = NaN;
    Distractor =NaN;
    extrafix = 0;
    
    %% 1. CUE PRESENTATION
    
    CueSelect = cue{trl, block};
    TrialCue = CUE.Texture{CueSelect};
    Screen('DrawTexture', PTB.window,TrialCue);
    cueOnsetTime = Screen('Flip', PTB.window);
    
    if isPracticeBlock == false
    [TRIGHIST(end+1), TRIG_Onset(end+1)] = sendTrigger(PPORT, cueTrigger{trl, block});
    end
    
    WaitSecs(EPROP.cueDuration);
    
    %% 2. ISI1
    
    Screen('TextSize', PTB.window, CONS.fixSize);
    DrawFormattedText(PTB.window, '+', 'center', 'center', COL.black );
    jitter1 = Screen('Flip', PTB.window);    
    WaitSecs(jit1(trl, block));
    
    %% 3.TARGET and DISTRACTOR PRESENTATION
    
    stimulus = stim{trl, block};
    distractor = distrac{trl, block};
    
    %The sequence of stimuli varies depeding on the type of block and type of stimuli
    
    if blocktype(block) == 1  %% HIGH COMPETITION BLOCKS
        
        if stim_type{trl, block} == 1
            t = find(strcmp(stimulus, IMG.name));
            Target = IMG.Texture{t};
            Screen('DrawTexture', PTB.window,Target, [], LocStim);
            
            Distractor = distractor;
            Screen('TextSize', PTB.window, CONS.nameSize);
            DrawFormattedText(PTB.window, Distractor, 'center', 'center', COL.black, [], [], [], [], [], LocWord);
        else
            d = strcmp(distractor, IMG.name);
            Distractor = IMG.Texture{d};
            Screen('DrawTexture', PTB.window, Distractor, [], LocStim);
            
            Target = stimulus;
            Screen('TextSize', PTB.window, CONS.nameSize);
            DrawFormattedText(PTB.window, Target, 'center', 'center', COL.black, [], [], [], [], [], LocWord);
        end
        
        target_distractOnsetTime = Screen('Flip', PTB.window);
        if isPracticeBlock == false
        [TRIGHIST(end+1), TRIG_Onset(end+1)] = sendTrigger(PPORT, targTrigger{trl,block});
        end
        %% --- GETTING RESPONSES from HIGH COMP BLOCKS ---
        
        while (GetSecs - target_distractOnsetTime) < (EPROP.targetHBDuration) 
            [keyIsDown, secs, keyCode] = KbCheck;
            if keyIsDown
                rt = secs - target_distractOnsetTime;
                ACC = length(find(keyCode)) == 1 && (find(keyCode) == stimRes(trl, block));
                 if isPracticeBlock == false
                     [TRIGHIST(end+1), TRIG_Onset(end+1)] = sendTrigger(PPORT, TRIG.RSP_Resp);
                 end
                if length(find(keyCode)) == 1 
                    Resp = find(keyCode);
                else
                    Resp = NaN;
                end
                if isPracticeBlock == false
                if ACC
                [TRIGHIST(end+1), TRIG_Onset(end+1)] = sendTrigger(PPORT, TRIG.RSP_Corr);
                else
                [TRIGHIST(end+1), TRIG_Onset(end+1)] = sendTrigger(PPORT, TRIG.RSP_Wrong);
                end
                end
                break
            end
        end
       
        WaitSecs((EPROP.targetHBDuration) - (GetSecs - target_distractOnsetTime));
        
        if isnan(Resp) %If the participant has not yet answered
            extrafix = 0.75;
            Screen('TextSize', PTB.window, CONS.fixSize);
            DrawFormattedText(PTB.window, '+', 'center', 'center');
            extrafixOnsetTime = Screen('Flip', PTB.window);
            
            while (GetSecs - extrafixOnsetTime) < (extrafix)
                [keyIsDown, secs, keyCode] = KbCheck;
                if keyIsDown
                    rt = secs - target_distractOnsetTime;
                    ACC = length(find(keyCode)) == 1 && (find(keyCode) == stimRes(trl, block));
                    if isPracticeBlock == false
                        [TRIGHIST(end+1), TRIG_Onset(end+1)] = sendTrigger(PPORT, TRIG.RSP_Resp);
                    end
                    if length(find(keyCode)) == 1
                        Resp = find(keyCode);
                    else
                        Resp = NaN;
                    end
                    if isPracticeBlock == false
                    if ACC
                    [TRIGHIST(end+1), TRIG_Onset(end+1)] = sendTrigger(PPORT, TRIG.RSP_Corr);
                    else
                    [TRIGHIST(end+1), TRIG_Onset(end+1)] = sendTrigger(PPORT, TRIG.RSP_Wrong);
                    end
                    end
                    break
                end
            end
            if isnan(Resp)  && isPracticeBlock == false
                TRIGHIST(end+1) = sendTrigger(PPORT, TRIG.RSP_Wrong);
            end
            WaitSecs((extrafix) -  (GetSecs - extrafixOnsetTime));
        end
           
        
    else %% LOW COMPETITION BLOCKS
        %% A) First only the target is presented
        if stim_type{trl, block} == 1
            t = find(strcmp(stimulus, IMG.name));
            Target = IMG.Texture{t};
            Screen('DrawTexture', PTB.window,Target, [], LocStim);
        else
            Target = stimulus;
            Screen('TextSize', PTB.window, CONS.nameSize);
            DrawFormattedText(PTB.window, Target, 'center', 'center', COL.black, [], [], [], [], [], LocWord);
        end
        
        targetOnsetTime = Screen('Flip', PTB.window);
        if isPracticeBlock == false
        [TRIGHIST(end+1), TRIG_Onset(end+1)] = sendTrigger(PPORT, targTrigger{trl,block});
        end
       
        %% ---GETTING RESPONSES DURING THE TARGET ALONE---
        
        while (GetSecs - targetOnsetTime) < (EPROP.targetLBDuration)
            [keyIsDown, secs, keyCode] = KbCheck;
            if keyIsDown
                rt = secs - targetOnsetTime;
                ACC = length(find(keyCode)) == 1 && (find(keyCode) == stimRes(trl, block));
                if isPracticeBlock == false
                    [TRIGHIST(end+1), TRIG_Onset(end+1)] = sendTrigger(PPORT, TRIG.RSP_Resp);
                end
                if length(find(keyCode)) == 1 
                    Resp = find(keyCode);
                else
                    Resp = NaN;
                end
                if isPracticeBlock == false
                    if ACC
                    [TRIGHIST(end+1), TRIG_Onset(end+1)] = sendTrigger(PPORT, TRIG.RSP_Corr);
                    else
                    [TRIGHIST(end+1), TRIG_Onset(end+1)] = sendTrigger(PPORT, TRIG.RSP_Wrong);
                    end
                end
                break
            end
        end
        WaitSecs((EPROP.targetLBDuration) - (GetSecs - targetOnsetTime));
        
        %% B) Next, we display target and distractor together
        if stim_type{trl, block} == 1
            t = find(strcmp(stimulus, IMG.name));
            Target = IMG.Texture{t};
            Screen('DrawTexture', PTB.window,Target, [], LocStim);
            
            Distractor = distractor;
            Screen('TextSize', PTB.window, CONS.nameSize);
            DrawFormattedText(PTB.window, Distractor, 'center', 'center', COL.black, [], [], [], [], [], LocWord);
        else
            d = strcmp(distractor, IMG.name);
            Distractor = IMG.Texture{d};
            Screen('DrawTexture', PTB.window, Distractor, [], LocStim);
            
            Target = stimulus;
            Screen('TextSize', PTB.window, CONS.nameSize);
            DrawFormattedText(PTB.window, Target, 'center', 'center', COL.black, [], [], [], [], [], LocWord);
        end
        
        distractorOnsetTime = Screen('Flip', PTB.window, targetOnsetTime + EPROP.targetLBDuration);
        
        if isPracticeBlock == false
        [TRIGHIST(end+1), TRIG_Onset(end+1)] = sendTrigger(PPORT, distTrigger{trl,block});
        end
        
        if ~isnan(Resp) %If the participant answered during target presentation, the distractor is displayed
            WaitSecs(EPROP.target_distDuration);
        else %If there is still no responses
            
            %% GETTING RESPONSES DURING TARGET + DISTRACTOR-----------------
            
            while (GetSecs - distractorOnsetTime) < (EPROP.target_distDuration)
                [keyIsDown, secs, keyCode] = KbCheck;
                if keyIsDown
                    rt = secs - targetOnsetTime;
                    ACC = length(find(keyCode)) == 1 && (find(keyCode) == stimRes(trl, block));
                    if isPracticeBlock == false
                    [TRIGHIST(end+1), TRIG_Onset(end+1)] = sendTrigger(PPORT, TRIG.RSP_Resp);
                    end
                    if length(find(keyCode)) == 1
                        Resp = find(keyCode);
                    else
                        Resp = nan;
                    end
                    if isPracticeBlock == false
                    if ACC
                    [TRIGHIST(end+1), TRIG_Onset(end+1)] = sendTrigger(PPORT, TRIG.RSP_Corr);
                    else
                    [TRIGHIST(end+1), TRIG_Onset(end+1)] = sendTrigger(PPORT, TRIG.RSP_Wrong);
                    end
                    end
                    break
                end
            end
        end
            
            %% C) Finally we display only the distractor
            
        if stim_type{trl, block} == 1
            Distractor = distractor;
            Screen('TextSize', PTB.window, CONS.nameSize);
            DrawFormattedText(PTB.window, Distractor, 'center', 'center', COL.black, [], [], [], [], [], LocWord);
        else
            d = strcmp(distractor, IMG.name);
            Distractor = IMG.Texture{d};
            Screen('DrawTexture', PTB.window, Distractor, [], LocStim);
        end
        
        distractLBOnsetTime = Screen('Flip', PTB.window);
        
        if ~isnan(Resp) %If there si already an answer, the distractor is displayed during its duration
            WaitSecs(EPROP.distractorLBDuration);
        else
            %% Getting anwsers during distractor alone presentation
        while (GetSecs - distractLBOnsetTime) < (EPROP.distractorLBDuration)
                [keyIsDown, secs, keyCode] = KbCheck;
                if keyIsDown
                    rt = secs - targetOnsetTime;
                    ACC = length(find(keyCode)) == 1 && (find(keyCode) == stimRes(trl, block));
                    if isPracticeBlock == false
                    [TRIGHIST(end+1), TRIG_Onset(end+1)] = sendTrigger(PPORT, TRIG.RSP_Resp);
                    end
                    if length(find(keyCode)) == 1
                        Resp = find(keyCode);
                    else
                        Resp = Nan;
                    end
                    if isPracticeBlock == false
                    if ACC
                    [TRIGHIST(end+1), TRIG_Onset(end+1)] = sendTrigger(PPORT, TRIG.RSP_Corr);
                    else
                    [TRIGHIST(end+1), TRIG_Onset(end+1)] = sendTrigger(PPORT, TRIG.RSP_Wrong);
                    end
                    end
                    break
                end
        end
        if isnan(Resp) && isPracticeBlock == false
            TRIGHIST(end+1) = sendTrigger(PPORT, TRIG.RSP_Wrong);
        end
        WaitSecs((EPROP.distractorLBDuration) - (GetSecs - distractorOnsetTime));
        end
    end       
        %% 4. ISI2
        
        Screen('TextSize', PTB.window, CONS.fixSize);
        DrawFormattedText(PTB.window, '+', 'center', 'center', COL.black );
        jitter2 = Screen('Flip', PTB.window);
              
        if blocktype(block) ==1  
        WaitSecs((jit2(trl,block)) - (extrafix));
        else
        WaitSecs(jit2(trl,block)-0.5);  
        end
        
        %% 5. FEEDBACK 
        addpath ('func')
        if feedback
            if keyIsDown
                if ACC == 1
                    feedColor = [0 1 0];
                    feedText = '¡CORRECTO!';
                else
                    feedColor = [1 0 0];
                    feedText = '¡INCORRECTO!';
                    soundFeedback();
                end
            else
                feedColor = [1 1 1];
                feedText = 'NO SE HA DETECTADO RESPUESTA';
                soundFeedback();
            end
            
            Screen('TextSize', PTB.window, 22);
            DrawFormattedText(PTB.window, feedText, 'center', 'center', feedColor);
            Screen('Flip', PTB.window);
            WaitSecs(EPROP.feedbackDuration);
        else %only sound feedback in incorrect trials during the experimental session (not practice)
            if ACC == 0
                Beeper(450, .7, .3);

                Screen('TextSize', PTB.window, CONS.fixSize);
                DrawFormattedText(PTB.window, '+', 'center', 'center', COL.black );
                Screen('Flip', PTB.window);
                WaitSecs(EPROP.feedbackDuration);
            end
        end
        
        %% 6. The moment of the end of trial
        EndofTrial = GetSecs;
        
        %% 7. OUT DATA
        if isPracticeBlock
            OUT_P.trialStart(trl,block) = cueOnsetTime - initialTimeStamp;
            OUT_P.cueOnset(trl,block) = cueOnsetTime - initialTimeStamp;
            if blocktype(block) == 1
                OUT_P.target_distOnset(trl,block) = target_distractOnsetTime - initialTimeStamp;
            else
                OUT_P.targetOnset(trl,block) = targetOnsetTime - initialTimeStamp;
                OUT_P.distractorOnset(trl,block) = distractorOnsetTime - initialTimeStamp;
            end
            if extrafix == 0.5
                OUT_P.extrafixOnset(trl,block) = extrafixOnsetTime - initialTimeStamp;
                OUT_P.stimOffset(trl,block) = extrafixOnsetTime - initialTimeStamp;
            else
                OUT_P.stimOffset(trl,block) = jitter2 - initialTimeStamp;
            end
            OUT_P.stim{trl,block} = stimulus;
            OUT_P.stimType(trl,block) = stim_type(trl,block);
            OUT_P.cue(trl, block) = CueSelect;
            OUT_P.interference(trl, block) = interference(trl,block);
            OUT_P.gender(trl, block) = gender(trl,block);
            OUT_P.jitter1Onset(trl,block) = jitter1 - initialTimeStamp;
            OUT_P.jitter2Onset(trl,block) = jitter2 - initialTimeStamp;
            OUT_P.ACC(trl,block) = ACC;
            OUT_P.RT(trl,block) = rt;
            OUT_P.Resp(trl,block) = Resp;
            OUT_P.endofTrial(trl,block) = EndofTrial - initialTimeStamp;
            OUT_P.endofTrial(trl,block) = EndofTrial - initialTimeStamp;
            
        else
            OUT_E.trialStart(trl,block) = cueOnsetTime - initialTimeStamp;
            OUT_E.cueOnset(trl,block) = cueOnsetTime - initialTimeStamp;
            if blocktype(block) == 1
                OUT_E.target_distOnset(trl,block) = target_distractOnsetTime - initialTimeStamp;
            else
                OUT_E.targetOnset(trl,block) = targetOnsetTime - initialTimeStamp;
                OUT_E.distractorOnset(trl,block) = distractorOnsetTime - initialTimeStamp;             
            end
            if extrafix == 0.5
                OUT_E.extrafixOnset(trl,block) = extrafixOnsetTime - initialTimeStamp;
                OUT_E.stimOffset(trl,block) = extrafixOnsetTime - initialTimeStamp;
            else
                OUT_E.extrafixOnset(trl,block) = 0;
                OUT_E.stimOffset(trl,block) = jitter2 - initialTimeStamp;
            end
            OUT_E.stim{trl,block} = stimulus;
            OUT_E.stimType(trl,block) = stim_type(trl,block);
            OUT_E.cue(trl, block) = CueSelect;
            OUT_E.interference(trl, block) = interference(trl,block);
            OUT_E.gender(trl, block) = gender(trl,block);
            OUT_E.jitter1Onset(trl,block) = jitter1 - initialTimeStamp;
            OUT_E.jitter2Onset(trl,block) = jitter2 - initialTimeStamp;
            OUT_E.ACC(trl,block) = ACC;
            OUT_E.RT(trl,block) = rt;
            OUT_E.Resp(trl,block) = Resp;
            OUT_E.endofTrial(trl,block) = EndofTrial - initialTimeStamp;
            OUT_E.stimTrigger{trl,block} = stimTrigger;
            OUT_E.cueTrigger{trl,block} = cueTrigger;
        end
end

Screen('FillRect', PTB.window, COL.grey)
Screen('Flip', PTB.window);
        
%% CLEAN WORKSPACE
clear trialNumber feedback jit1 jit2 blocktype cue stim stimRes distrac stim_type gender;
clear trl ACC rt Resp stimOnsetTime stimOffsetTime trg;
clear CueSelect TrialCue cueOnsetTime extrafix interference;
clear jitter1 jitter2 stimulus distractor T Target d Distractor Trgt Distract;
clear keyIsDown secs keyCode KbCheck;



