%Script written by Blanca Aguado-López (blancaal@ugr.es)
%This script is used to generate a table with all the trial information for the mediation: competition- theta- RT
%We already selected the time window of interest from the graph of time-freq averaging high and low (from the script extracting power time-freq.m)


%The indexes of theta will also be used to correlate with decoding.
%To extract theta indexes we select 3 hz to lower than 8 hz frequency from the data.

clear
%We do a table with the data: limiting the number of trials to which there are less than one class
theta= []; %Concatenating in a column all subjects and alternating face high, name high, face low, name low

dir = 'E:\Mi unidad\Experimento competition\DATA\EEG\derivatives';
RT= [];

for sub=1:36
    %loading a subject data of cue face high
    tffacehi= load ([dir filesep 'sub-' num2str(sub, '%.2d') filesep 'eeg\conditions\' 'sub-' num2str(sub,'%.2d') '_task-competition_eeg_cue_face_hi_timefreq.mat']);

    tfnamehi= load ([dir filesep 'sub-' num2str(sub, '%.2d') filesep 'eeg\conditions\' 'sub-' num2str(sub,'%.2d') '_task-competition_eeg_cue_name_hi_timefreq.mat']);
    meanch= mean(tffacehi.tf.powspctrm,2,'omitnan');%mean across channels
    meanch=squeeze(meanch);
    timewd= [tffacehi.tf.time>0.1 & tffacehi.tf.time<= 0.9]; %time window from 100 to 900ms
    n_min_trial_hi=min([size(tffacehi.tf.trialinfo,1), size(tfnamehi.tf.trialinfo,1)]);
    n_hi(sub)=n_min_trial_hi;
    for trial= 1:n_min_trial_hi
        for freq= 1:size(meanch,2)
            meantp(trial,freq)= mean(meanch(trial,freq,timewd), 'omitnan');%mean across time
        end
    end
    freq_index= [tffacehi.tf.freq >=3 & tffacehi.tf.freq<8];

    for trial= 1:n_min_trial_hi %number of trials equivalent for faces and names
        meanfacehigh(trial)= mean(meantp(trial,freq_index));
    end
    theta= [theta; meanfacehigh'];
    RT= [RT; tffacehi.tf.trialinfo.RT(1:n_min_trial_hi)];
    clear meanch meantp meanfacehigh


    %%mean name high
    meanch= mean(tfnamehi.tf.powspctrm,2,'omitnan');
    meanch=squeeze(meanch);
    timewd= [tfnamehi.tf.time>0.1 & tfnamehi.tf.time<= 0.9];
    for trial= 1:n_min_trial_hi
        for freq= 1:size(meanch,2)
            meantp(trial,freq)= mean(meanch(trial,freq,timewd), 'omitnan');
        end
    end
    freq_index= [tfnamehi.tf.freq >=3 & tfnamehi.tf.freq<8];

    for trial= 1:n_min_trial_hi
        meannamehigh(trial)= mean(meantp(trial,freq_index));
    end
    theta= [theta; meannamehigh'];
    RT= [RT; tfnamehi.tf.trialinfo.RT(1:n_min_trial_hi)];
    clear meanch meantp meannamehigh


   % mean face low
    tffacelow= load ([dir filesep 'sub-' num2str(sub, '%.2d') filesep 'eeg\conditions\' 'sub-' num2str(sub,'%.2d') '_task-competition_eeg_cue_face_lo_timefreq.mat']);
    tfnamelow= load ([dir filesep 'sub-' num2str(sub, '%.2d') filesep 'eeg\conditions\' 'sub-' num2str(sub,'%.2d') '_task-competition_eeg_cue_name_lo_timefreq.mat']);
    n_min_trial_lo=min([size(tffacelow.tf.trialinfo,1), size(tfnamelow.tf.trialinfo,1)]);
    n_lo(sub)=n_min_trial_lo;

    meanch= mean(tffacelow.tf.powspctrm,2,'omitnan');
    meanch=squeeze(meanch);
    timewd= [tffacelow.tf.time>0.1 & tffacelow.tf.time<= 0.9];
    for trial= 1:n_min_trial_lo
        for freq= 1:size(meanch,2)
            meantp(trial,freq)= mean(meanch(trial,freq,timewd), 'omitnan');
        end
    end
    freq_index= [tffacelow.tf.freq >=3 & tffacelow.tf.freq<8];

    for trial= 1:n_min_trial_lo
        meanfacelow(trial)= mean(meantp(trial,freq_index));
    end
    theta= [theta; meanfacelow'];
    RT= [RT; tffacelow.tf.trialinfo.RT(1:n_min_trial_lo)];
    clear meanch meantp meanfacelow

    %mean names low
    meanch= mean(tfnamelow.tf.powspctrm,2,'omitnan');
    meanch=squeeze(meanch);
    timewd= [tfnamelow.tf.time>0.1 & tfnamelow.tf.time<= 0.9];
    for trial= 1:n_min_trial_lo
        for freq= 1:size(meanch,2)
            meantp(trial,freq)= mean(meanch(trial,freq,timewd), 'omitnan');
        end
    end
    freq_index= [tfnamelow.tf.freq >=3 & tfnamelow.tf.freq<8];

    for trial= 1:n_min_trial_lo
        meannamelow(trial)= mean(meantp(trial,freq_index));
    end

    theta= [theta; meannamelow'];
    RT= [RT; tfnamelow.tf.trialinfo.RT(1:n_min_trial_lo)];
    clear meanch meantp meannamelow

end
%%

%For extracting the theta index for mediation we make the mean across theta
%frequencies


%we create a table to have all the information available for R
subject=[];

for i=1:36
    subject= [subject; (repelem(i, ((n_hi(i)*2)+(n_lo(i)*2)))')]; %length high + low
end
task= [];
for i=1:36
    task= [task; (repelem('H', (n_hi(i))*2)')];
    task= [task; (repelem('L', (n_lo(i))*2)')];
end
category= [];
for i=1:36
    category= [category; (repelem('F', (n_hi(i)))')];
    category= [category; (repelem('N', (n_hi(i)))')];
    category= [category; (repelem('F', (n_lo(i)))')];
    category= [category; (repelem('N', (n_lo(i)))')];
end

run ExtractCongrforcuesBIDS.m %

% Congrnamelow=cell2table(Congruencynamelow);
% Congrnamehigh= cell2table(Congruencynamehigh);
% Congrfacelow= cell2table(Congruencyfacelow);
% Congrfacehigh= cell2table (Congruencyfacehigh);
%%

Congruency= [];
for i=1:36
    Congruency= [Congruency, Congruencyfacehigh{1:n_hi(i),i}]; %all subjects in the same row
    Congruency= [Congruency, Congruencynamehigh{1:n_hi(i),i}];
    Congruency= [Congruency, Congruencyfacelow{1:n_lo(i),i}];
    Congruency= [Congruency, Congruencynamelow{1:n_lo(i),i}];
end
Congruency= Congruency';
%%

modeltheta= table(subject,task, category, Congruency, RT, theta);
writetable(modeltheta,'modelpredictRTtheta.csv','Delimiter',',');


%% Changing 0 1 congruency by C, I.
data=readtable('modelpredictRTtheta.csv','Delimiter',',');
for i=1:size(data,1)
    if data.Congruency(i)==1
        Congruency(i)=['C'];
    else
        Congruency(i)=['I'];
    end
end
Congruency= Congruency';
Congruencystr=Congruency;
Congrtable= table(Congruencystr);
model= [data Congrtable];
writetable(model,'modelpredictRTtheta.csv','Delimiter',',');

%after that we delete the rows with NaN values and we filter the data by 2SD in the script filteringtrialstheta
