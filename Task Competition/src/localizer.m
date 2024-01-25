%% DISPLAY OF THE TRIALS WITHIN A LOCALIZER BLOCK
% -------------------------------------------------------------------------
% CIMCYC - Universidad de Granada  - Code written by Paloma Díaz Gutiérrez y Chema G. Peñalver
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% This script goes across the matrix of the localizer block containing the trials and
% presents the sequence of stimuli in that trial
RestrictKeysForKbCheck([]);
Screen('FillRect', PTB.window, COL.grey)
Screen('TextFont', PTB.window, CONS.trialFontFamily);
Screen('Flip', PTB.window);

if isPracticeBlock
    trialNumber = EPROP.nPraTrials;
    feedback_Loc = true;
    stim_Loc = PRACT.StimLocAlt;
    stim_type_Loc = PRACT.StimTypeLocAlt;
    stimRes_Loc = PRACT.CorrResp;
    stim_go = PRACT.TrialTypeLocAlt;
else
    trialNumber = EPROP.nLocTrials;
    feedback_Loc = false;
    stim_Loc = EDATA.StimLocAlt;
    stim_type_Loc = EDATA.StimTypeLocAlt;
    stimRes_Loc = EDATA.CorrResp;
    stim_go = EDATA.TrialTypeLocAlt;
    stimLocTrigger = EDATA.LocTrigger;    
end

for trl = 1:trialNumber
    
    %% TRIAL RESET
    ACC = 1;
    rt = NaN;
    Resp = NaN;
    press = NaN;
    stimLocOnsetTime = NaN;
    extrafix = 0;
    
       %% 1. FIXATION
    if trl == 1 || ~isPracticeBlock
    Screen('TextSize', PTB.window, CONS.fixSize);
    DrawFormattedText(PTB.window, '+', 'center', 'center', COL.black );
    fixation1 = Screen('Flip', PTB.window);    
    WaitSecs(EPROP.fixLocDuration);
    end
    %% 2.STIMULUS PRESENTATION
    
    stimulusLoc = stim_Loc{trl, block};
    
        if stim_type_Loc{trl, block} == 1
            t = find(strcmp(stimulusLoc, IMG.name));
            Target = IMG.Texture{t};
            if strcmp(stim_go{trl,block}, 'go') == 1
             Screen('DrawTexture', PTB.window,Target, [], LocStim, 180);
            else
            Screen('DrawTexture', PTB.window,Target, [], LocStim);
            end
        else
            Target = stimulusLoc;
            Screen('TextSize', PTB.window, CONS.nameSize);
            if strcmp(stim_go{trl,block}, 'go') == 1
            DrawFormattedText(PTB.window, Target, 'center', PTB.centerY*4/5, COL.black, [], [], 1, [], []);
            else
            DrawFormattedText(PTB.window, Target, 'center', 'center', COL.black, [], [], [], [], [], LocWord);
            end
        end
        
        stimLocOnsetTime = Screen('Flip', PTB.window);
        if isPracticeBlock == false
           [TRIGHIST(end+1), TRIG_Onset(end+1)] = sendTrigger(PPORT, stimLocTrigger{trl,block});
        end
        %% --- GETTING RESPONSES ---
       while (GetSecs - stimLocOnsetTime) < (EPROP.stimLocDuration) 
            [keyIsDown, secs, keyCode] = KbCheck;
            if strcmp(stim_go{trl,block}, 'go')
                ACC = 0;
                resp = stimRes_Loc(trl, block);
                if keyIsDown
                    rt = secs - stimLocOnsetTime;
                    ACC = length(find(keyCode)) == 1 && find(keyCode) == resp;
                    Resp = find(keyCode);
                    if ACC
                    TRIGHIST(end+1) = sendTrigger(PPORT, TRIG.RSP_Corr);
                    else
                    TRIGHIST(end+1) = sendTrigger(PPORT, TRIG.RSP_Wrong);
                    end
                    break
                end
            else
                if keyIsDown
                    ACC = 0;
                    Resp = find(keyCode);
                    TRIGHIST(end+1) = sendTrigger(PPORT, TRIG.RSP_Wrong);
                    break
                end
            end
        end 
       
        WaitSecs((EPROP.stimLocDuration) - (GetSecs - stimLocOnsetTime));
        
        if isnan(Resp) %If there is still no answer
            extrafix = 0.5;
            Screen('TextSize', PTB.window, CONS.fixSize);
            DrawFormattedText(PTB.window, '+', 'center', 'center', COL.black);
            extrafixOnsetTime = Screen('Flip', PTB.window);
            
            while (GetSecs - extrafixOnsetTime) < (extrafix)
                [keyIsDown, secs, keyCode] = KbCheck;
                if strcmp(stim_go{trl,block}, 'go')
                    ACC = 0;
                    resp = stimRes_Loc(trl, block);
                    if keyIsDown
                        rt = secs - stimLocOnsetTime;
                        ACC = length(find(keyCode)) == 1 && find(keyCode) == resp;
                        Resp = find(keyCode);
                        if ACC
                        TRIGHIST(end+1) = sendTrigger(PPORT, TRIG.RSP_Corr);
                        else
                        TRIGHIST(end+1) = sendTrigger(PPORT, TRIG.RSP_Wrong);
                        end
                        break
                    end
                else
                    if keyIsDown
                        ACC = 0;
                        Resp = find(keyCode);
                        TRIGHIST(end+1) = sendTrigger(PPORT, TRIG.RSP_Wrong);
                        break
                    end
                    
                end
            end
            if strcmp(stim_go{trl,block}, 'go')
                if isnan(Resp)
                TRIGHIST(end+1) = sendTrigger(PPORT, TRIG.RSP_Wrong);
                end
            else
                if isnan(Resp)
                TRIGHIST(end+1) = sendTrigger(PPORT, TRIG.RSP_Corr);
                end
            end
            WaitSecs((extrafix) -  (GetSecs - extrafixOnsetTime));
        end
        
     %% 3. FIXATION -- Continuing the fixation the total time needed (EPROP.fixLocDuration)
    Screen('TextSize', PTB.window, CONS.fixSize);
    DrawFormattedText(PTB.window, '+', 'center', 'center', COL.black );
    fixation2 = Screen('Flip', PTB.window);    
    WaitSecs((EPROP.fixLocDuration)- extrafix);
        
            %% 3. FEEDBACK - For practice blocks
        
        if feedback_Loc
%             if keyIsDown
                if ACC == 1
                    feedColor = [0 1 0];
                    feedText = '¡CORRECTO!';
                else
                    feedColor = [1 0 0];
                    feedText = '¡INCORRECTO!';
%                     soundFeedback();
                end
%             
            Screen('TextSize', PTB.window, 22);
            DrawFormattedText(PTB.window, feedText, 'center', 'center', feedColor);
            Screen('Flip', PTB.window);
            WaitSecs(EPROP.feedbackDuration);
        else
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
            if trl == 1
            OUT_P.trialStart(trl,block) = fixation1 - initialTimeStamp;
            else
            OUT_P.trialStart(trl,block) = stimLocOnsetTime - initialTimeStamp;
            end
            OUT_P.stimLocOnset(trl,block) = stimLocOnsetTime - initialTimeStamp;
            OUT_P.stim{trl,block} = stimulusLoc;
            OUT_P.stimType(trl,block) = stim_type_Loc(trl,block);
            OUT_P.ACC(trl,block) = ACC;
            OUT_P.RT(trl,block) = rt;
            OUT_P.Resp(trl,block) = Resp;
            if extrafix ~= 0
            OUT_P.extrafix(trl,block) = extrafixOnsetTime - initialTimeStamp;
            end
            OUT_P.endofTrial(trl,block) = EndofTrial - initialTimeStamp;
            if trl == 1
            OUT_P.fixation1(trl,block) = fixation1 - initialTimeStamp;
            end
            OUT_P.fixation2(trl,block) = fixation2 - initialTimeStamp;
        else
            if trl == 1
            OUT_E.trialStart(trl,block) = fixation1 - initialTimeStamp;
            else
            OUT_E.trialStart(trl,block) = stimLocOnsetTime - initialTimeStamp;
            end
            OUT_E.stimLocOnset(trl,block) = stimLocOnsetTime - initialTimeStamp;
            OUT_E.stim{trl,block} = stimulusLoc;
            OUT_E.stimType(trl,block) = stim_type_Loc(trl,block);
            OUT_E.ACC(trl,block) = ACC;
            OUT_E.RT(trl,block) = rt;
            OUT_E.Resp(trl,block) = Resp;
            if extrafix ~= 0
            OUT_E.extrafix(trl,block) = extrafixOnsetTime - initialTimeStamp;
            end
            OUT_E.endofTrial(trl,block) = EndofTrial - initialTimeStamp;
            if trl == 1
            OUT_E.fixation1(trl,block) = fixation1 - initialTimeStamp;
            end
            OUT_E.fixation2(trl,block) = fixation2 - initialTimeStamp;
            OUT_E.stimTrigger{trl,block} = stimLocTrigger;
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



