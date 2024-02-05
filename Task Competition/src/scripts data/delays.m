%This script calculates whether there were delays between two events that needed to be presented sequentially.
for c= 1:48

    for i = 1:48

        Delay_cue_jit1(i,c) = ((OUT_E.jitter1Onset(i,c))-(OUT_E.cueOnset(i,c))) - 0.2;
        Delay_jit1_stim(i,c) = (OUT_E.stimOnset(i,c)) - ((OUT_E.jitter1Onset(i,c)) + (EDATA.Jitter1(i,c)));

        if BlockType(c)
            if OUT_E.extrafixOnset(i,c) == 0
                Delay_stim_jit2(i,c) = ((OUT_E.jitter2Onset(i,c)) - (OUT_E.stimOnset(i,c))) - 1;
            else
                Delay_stim_extrafix(i,c) = ((OUT_E.extrafixOnset(i,c)) - (OUT_E.stimOnset(i,c))) - 1;
                Delay_extrafix_jit2(i,c) = ((OUT_E.jitter2Onset(i,c)) - (OUT_E.extrafixOnset(i,c))) - 0.5;
            end
        else
            Delay_stim_dis(i,c) = ((OUT_E.distractorOnset(i,c)) - (OUT_E.stimOnset(i,c))) - 0.5;
            if OUT_E.extrafixOnset(i,c) == 0
                Delay_dis_jit2(i,c) = ((OUT_E.jitter2Onset(i,c)) - (OUT_E.distractorOnset(i,c))) - 0.5;
            else
                Delay_dis_extrafix(i,c) = ((OUT_E.extrafixOnset(i,c)) - (OUT_E.distractorOnset(i,c))) - 0.5;
                Delay_extrafix_jit2(i,c) = ((OUT_E.jitter2Onset(i,c)) - (OUT_E.extrafixOnset(i,c))) - 0.5;
            end
            Dif_dur_jit2(i,c) = (OUT_E.endofTrial(i,c)) - ((OUT_E.jitter2Onset(i,c)) + (EDATA.Jitter2(i,c)));

        end
    end
end
min_delay_cue_jit = min(Delay_cue_jit1);
max_delay_cue_jit = max(Delay_cue_jit1);
prom_delay_cue_jit = mean(Delay_cue_jit1);

min_delay_jit_stim = min(Delay_jit1_stim);
max_delay_jit_stim = max(Delay_jit1_stim);
prom_delay_jit_stim = mean(Delay_jit1_stim);

min_delay_end = min(Dif_dur_jit2);
max_delay_end = max(Dif_dur_jit2);
prom_delay_end = mean(Dif_dur_jit2);

min_delay_stim_jit2 = min(Delay_stim_jit2);
max_delay_stim_jit2 = max(Delay_stim_jit2);
prom_delay_stim_jit2 = mean(Delay_stim_jit2);

min_delay_stim_extrafix = min(Delay_stim_extrafix);
max_delay_stim_extrafix = max(Delay_stim_extrafix);
prom_delay_stim_extrafix = mean(Delay_stim_extrafix);

min_delay_extrafix_jit2 = min(Delay_extrafix_jit2);
max_delay_extrafix_jit2 = max(Delay_extrafix_jit2);
prom_delay_extrafix_jit2 = mean(Delay_extrafix_jit2);

min_delay_stim_dis = min(Delay_stim_dis);
max_delay_stim_dis = max(Delay_stim_dis);
prom_delay_stim_dis = mean(Delay_stim_dis);

min_delay_dis_jit2 = min(Delay_dis_jit2);
max_delay_dis_jit2 = max(Delay_dis_jit2);
prom_delay_dis_jit2 = mean(Delay_dis_jit2);

min_delay_dis_extrafix = min(Delay_dis_extrafix);
max_delay_dis_extrafix = max(Delay_dis_extrafix);
prom_delay_dis_extrafix = mean(Delay_dis_extrafix);


save(['S', num2str(SUBJECT_INFO.id), '_OUTPUT.Delays'], 'Delay_cue_jit1','Delay_jit1_stim', 'Delay_stim_jit2', 'Delay_stim_extrafix', 'Delay_extrafix_jit2', ...
    'Delay_stim_dis', 'Delay_dis_jit2', 'Delay_dis_extrafix', 'Dif_dur_jit2', 'min_delay_cue_jit', 'max_delay_cue_jit', 'prom_delay_cue_jit', 'min_delay_jit_stim',...
    'max_delay_jit_stim', 'prom_delay_jit_stim', 'min_delay_end', 'max_delay_end', 'prom_delay_end', 'min_delay_stim_jit2', 'max_delay_stim_jit2', 'prom_delay_stim_jit2',...
    'min_delay_stim_extrafix', 'max_delay_stim_extrafix', 'prom_delay_stim_extrafix', 'min_delay_extrafix_jit2', 'max_delay_extrafix_jit2', 'prom_delay_extrafix_jit2',...
    'min_delay_stim_dis', 'max_delay_stim_dis', 'prom_delay_stim_dis', 'min_delay_dis_jit2','max_delay_dis_jit2', 'max_delay_dis_jit2', 'prom_delay_dis_jit2', 'min_delay_dis_extrafix',...
    'max_delay_dis_extrafix', 'prom_delay_dis_extrafix');
