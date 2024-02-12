%Script written by Blanca Aguado-López (blancaal@ugr.es)

%This script is used to assign the congruency condition of the trial to the cue in that trial.
%This info is used for the mediation of theta
dir = 'E:\Mi unidad\Experimento competition\DATA\EEG\derivatives';

Congruencyfacehigh= cell(max(n_hi), 36); %the max number of trials although some subjects will not have values for those trials
for i= 1:36
    load ([dir filesep 'sub-' num2str(i, '%.2d') filesep 'eeg\conditions\' 'sub-' num2str(i,'%.2d') '_task-competition_eeg_cue_face_hi.mat']);
for j=1:length(EEG.event)
        if EEG.event(j).type(1:3)=='CUE'
            if EEG.event(j+1).type(8:10)=='CON'
                n =EEG.event(j).epoch;
                %Congruencyfacehigh {n, i}= ['CON'];
                Congruencyfacehigh {n, i}= 1; %1 congruent, 0 incongruent
            elseif EEG.event(j+1).type(8:10)=='INC'
                n =EEG.event(j).epoch;
                %Congruencyfacehigh {n, i}= ['INC'];
                Congruencyfacehigh {n, i}= 0;
            else %if the data collection was cut off or it is a different epoch
                n =EEG.event(j).epoch;
                Congruencyfacehigh {n, i}= nan;
            end
        end
    end
end

%save ('E:\Mi unidad\Experimento competition\DATA\EEG\Analisis multi\ultimisima limpieza con rts\d values high\Congruencynamehigh.mat', 'Congruencynamehigh');

Congruencynamehigh= cell(max(n_hi), 36);
for i= 1:36
    load ([dir filesep 'sub-' num2str(i, '%.2d') filesep 'eeg\conditions\' 'sub-' num2str(i,'%.2d') '_task-competition_eeg_cue_name_hi.mat']);
for j=1:length(EEG.event)
        if EEG.event(j).type(1:3)=='CUE'
            if EEG.event(j+1).type(8:10)=='CON'
                n =EEG.event(j).epoch;

                Congruencynamehigh {n, i}= 1; %1 congruent, 0 incongruent
            elseif EEG.event(j+1).type(8:10)=='INC'
                n =EEG.event(j).epoch;

                Congruencynamehigh {n, i}= 0;
            else
                n =EEG.event(j).epoch;
                Congruencynamehigh {n, i}= nan;
            end
        end
    end
end

Congruencyfacelow= cell(max(n_lo), 36);
for i= 1:36
    load ([dir filesep 'sub-' num2str(i, '%.2d') filesep 'eeg\conditions\' 'sub-' num2str(i,'%.2d') '_task-competition_eeg_cue_face_lo.mat']);
for j=1:length(EEG.event)
        if EEG.event(j).type(1:3)=='CUE'
            if EEG.event(j+1).type(8:10)=='CON'
                n =EEG.event(j).epoch;

                Congruencyfacelow {n, i}= 1; %1 congruent, 0 incongruent
            elseif EEG.event(j+1).type(8:10)=='INC'
                n =EEG.event(j).epoch;

                Congruencyfacelow {n, i}= 0;
            else
                n =EEG.event(j).epoch;
                Congruencyfacelow {n, i}= nan;
            end
        end
    end
end

Congruencynamelow= cell(max(n_hi), 36);
for i= 1:36
    load ([dir filesep 'sub-' num2str(i, '%.2d') filesep 'eeg\conditions\' 'sub-' num2str(i,'%.2d') '_task-competition_eeg_cue_name_lo.mat']);
    for j=1:length(EEG.event)
        if EEG.event(j).type(1:3)=='CUE'
            if EEG.event(j+1).type(8:10)=='CON'
                n =EEG.event(j).epoch;

                Congruencynamelow {n, i}= 1; %1 congruent, 0 incongruent
            elseif EEG.event(j+1).type(8:10)=='INC'
                n =EEG.event(j).epoch;

                Congruencynamelow {n, i}= 0;
            else
                n =EEG.event(j).epoch;
                Congruencynamelow {n, i}= nan;
            end
        end
    end
end
