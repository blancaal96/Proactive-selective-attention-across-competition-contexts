%% PRACTICE SESSION
% -------------------------------------------------------------------------
% CIMCYC - Universidad de Granada  - Code written by Paloma Díaz Gutiérrez y Chema G. Peñalver
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% This script runs across the number of practice blocks and checks if the
% practice session needs to be repeated
%% 1. TRIAL-LIST
% -------------------------------------------------------------------------

if runPracticeBlock
    isPracticeBlock = true;
    practiceCounter = 0;
    rePractice = 0;
    res_hb_con = 0;
    res_hb_con = 0;
    res_lb_inc = 0;
    res_lb_inc = 0;
    res_loc = 0;
    
    while res_hb_con < .8 || res_hb_con < .8 || res_lb_inc < .8 || res_lb_inc < .8 || res_loc < .8
        if practiceCounter > 0
            run repeatPracticeBlockInst.m %instructions if the practice session needs to be repeated
            if ~repeatPractice
                break;
            end
%             while res_hb_con < .8 || res_hb_con < .8 || res_lb_inc < .8 || res_lb_inc < .8 
%                 if rePractice > 0
%                     run repeatPracticeBlockInst.m
%                 end 
%                 block = 1;
%                 while true
%                     if block == 4
%                         break
%                     else
%                         if PRACT.BlockType(block) ==1 || PRACT.BlockType(block) ==2
%                             run pra_blockInit.m
%                             run blockCounter.m
%                             run trial.m
%                             block = block +1;
%                         end
%                     end
%                       
%                 end
%                 [res_hb_con, res_hb_inc, res_lb_con, res_lb_inc, res_hb, res_lb] = ... 
%                     behavResults(OUT_P.ACC, PRACT.BlockType, OUT_P.interference);
%                 rePractice = rePractice +1;
%             end
        end
        
        for block = 1 : EPROP.nPraBlocks
            if PRACT.BlockType(block) == 1 || PRACT.BlockType(block) == 2
            run pra_blockInit.m %initializing the cues of that block
            run blockCounter.m %instructions for the block selected
            run trial.m %running the trials of that block
            else
                run blockLoc.m %instructions for localizer
                run localizer.m %running the trials of a localizer block
            end
        end
        [res_hb_con, res_hb_inc, res_lb_con, res_lb_inc, res_hb, res_lb, res_loc] = ... 
            behavResults(OUT_P.ACC, PRACT.BlockType, OUT_P.interference);
        practiceCounter = practiceCounter + 1;
    end
end