%% EEG-Competition Task- Experimental session
% -------------------------------------------------------------------------
% CIMCYC - Universidad de Granada  - Code written by Paloma Díaz Gutiérrez y Chema G. Peñalver
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% This script runs across the number of experimental blocks 
Screen('TextColor', PTB.window,  COL.black);
%% 1. TRIAL-LIST
% -------------------------------------------------------------------------
isPracticeBlock = false;
%% Trigger starting the experiment
 TRIGHIST = 0;
 TRIG_Onset = 0;
[TRIGHIST(end+1), TRIG_Onset(end+1)] = sendTrigger(PPORT, TRIG.EXP_STR);

for block = EPROP.firstBlock:EPROP.nTotalBlocks
    
    if EDATA.BlockType(block) == 1 || EDATA.BlockType(block) == 2
        run blockInit.m %initializing the cues of that block
    end
    or = EPROP.nTotalBlocks/6;
    stopblocks = [or, or*2, or*3, or*4, or*5];
    
    if ismember(block, stopblocks)
        run forcedStop.m %every 6 blocks there will be a compulsory pause
        if EDATA.BlockType(block) == 1 || EDATA.BlockType(block) == 2
            run blockCounter.m %instructions according to the block type
        else
            run blockLoc.m %instructions for the localizer blocks
        end
    else %the same but without the compulsory pause
        if EDATA.BlockType(block) == 1 || EDATA.BlockType(block) == 2
            run blockCounter.m
        else
            run blockLoc.m
        end
    end
    
    %% Triggers type of block
    if EDATA.BlockType(block) ==1
        [TRIGHIST(end+1), TRIG_Onset(end+1)] = sendTrigger(PPORT, TRIG.BLK_HIGH);
    elseif EDATA.BlockType(block) ==2
        [TRIGHIST(end+1), TRIG_Onset(end+1)] = sendTrigger(PPORT, TRIG.BLK_LOW);
    else
        [TRIGHIST(end+1), TRIG_Onset(end+1)] = sendTrigger(PPORT, TRIG.BLK_LOC);
    end
    %% Triggers number of block
    num_blocktrigger = (block + 43);
    [TRIGHIST(end+1), TRIG_Onset(end+1)] = sendTrigger(PPORT, num_blocktrigger);
    
    if EDATA.BlockType(block) == 1 || EDATA.BlockType(block) == 2
        run trial.m %running the trials of that block
    else
        run localizer.m %running the trials of a localizer block
    end
end

