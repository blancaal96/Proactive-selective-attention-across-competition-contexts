%This script is used to calculate the behavioral indexes of each of the subjects in the sample (here we have 36 subjects) and it uses the function Def_behavResults.m to calculate the ACC and RT
clear
tot_subs = 36;

dir_to_load = '..\..\DATA\Analisis Comportamental\Raw\';
dir_to_save = '..\..\DATA\Analisis Comportamental\Results\';

for i = 1: tot_subs

        subjects_to_load{i} = ['S0' int2str(i) '_OUTPUT.mat'];
end
res_acc = NaN(tot_subs, 7);
res_rt = NaN(tot_subs, 7);
for i = 1:tot_subs


    load ([dir_to_load subjects_to_load{i}]);


        [res_hi_val_face, res_hi_inv_face, res_hi_val_name, res_hi_inv_name, res_lo_val_face,...
        res_lo_inv_face, res_lo_val_name, res_lo_inv_name, res_hi_val, res_hi_inv, res_lo_val,...
        res_lo_inv, res_hi, res_lo, res_loc, res_val, res_inv, res_face, res_name,...
        res_hi_face, res_hi_name, res_lo_face, res_lo_name, res_val_face, res_val_name, res_inv_face, res_inv_name, res_Output] = Def_behavResults (OUT_E.ACC, OUT_E.RT,...
        EDATA.BlockType, OUT_E.interference, OUT_E.stimType, 'ACC');

        res_acc (i, 1) = res_hi;
        res_acc (i, 2) = res_lo;
        res_acc (i, 3) = res_loc;

        res_acc (i, 16) = res_val;
        res_acc (i, 17) = res_inv;
        res_acc (i, 18) = res_face;
        res_acc (i, 19) = res_name;
        res_acc (i, 20) = res_Output;


        res_acc (i, 21) = res_hi_face;
        res_acc (i, 22) = res_hi_name;
        res_acc (i, 23) = res_lo_face;
        res_acc (i, 24) = res_lo_name;

        res_acc (i, 25) = res_val_face;
        res_acc (i, 26) = res_val_name;
        res_acc (i, 27) = res_inv_face;
        res_acc (i, 28) = res_inv_name;



        res_acc (i, 4) = res_hi_val;
        res_acc (i, 5) = res_hi_inv;
        res_acc (i, 6) = res_lo_val;
        res_acc (i, 7) = res_lo_inv;
        res_acc (i, 8) = res_hi_val_face;
        res_acc (i, 9) = res_hi_inv_face;
        res_acc (i, 10) = res_hi_val_name;
        res_acc (i, 11) = res_hi_inv_name;
        res_acc (i, 12) = res_lo_val_face;
        res_acc (i, 13) = res_lo_inv_face;
        res_acc (i, 14) = res_lo_val_name;
        res_acc (i, 15) = res_lo_inv_name;

        [res_hi_val_face, res_hi_inv_face, res_hi_val_name, res_hi_inv_name, res_lo_val_face,...
        res_lo_inv_face, res_lo_val_name, res_lo_inv_name, res_hi_val, res_hi_inv, res_lo_val,...
        res_lo_inv, res_hi, res_lo, res_loc, res_val, res_inv, res_face, res_name,...
        res_hi_face, res_hi_name, res_lo_face, res_lo_name, res_val_face, res_val_name, res_inv_face, res_inv_name, res_Output, Fnumber] = Def_behavResults (OUT_E.ACC, OUT_E.RT,...
        EDATA.BlockType, OUT_E.interference, OUT_E.stimType, 'RT');

        res_rt (i, 1) = res_hi;
        res_rt (i, 2) = res_lo;
        res_rt (i, 3) = res_loc;

        res_rt (i, 16) = res_val;%This is for congruent trials
        res_rt (i, 17) = res_inv;%This is for incongruent trials
        res_rt (i, 18) = res_face;
        res_rt (i, 19) = res_name;
        res_rt (i, 20) = res_Output;

        res_rt (i, 21) = res_hi_face;
        res_rt (i, 22) = res_hi_name;
        res_rt (i, 23) = res_lo_face;
        res_rt (i, 24) = res_lo_name;

        res_rt (i, 25) = res_val_face;
        res_rt (i, 26) = res_val_name;
        res_rt (i, 27) = res_inv_face;
        res_rt (i, 28) = res_inv_name;
        res_rt (i, 29) = Fnumber; %Total number of trials deleted due to been outliers

        res_rt (i, 4) = res_hi_val;
        res_rt (i, 5) = res_hi_inv;
        res_rt (i, 6) = res_lo_val;
        res_rt (i, 7) = res_lo_inv;
        res_rt (i, 8) = res_hi_val_face;
        res_rt (i, 9) = res_hi_inv_face;
        res_rt (i, 10) = res_hi_val_name;
        res_rt (i, 11) = res_hi_inv_name;
        res_rt (i, 12) = res_lo_val_face;
        res_rt (i, 13) = res_lo_inv_face;
        res_rt (i, 14) = res_lo_val_name;
        res_rt (i, 15) = res_lo_inv_name;
        Outliers (i)= Fnumber;
end
subs = [1: tot_subs]';
res = [subs, res_acc, res_rt];
save ( [dir_to_save 'resultsfiltered.mat'], 'res', 'Outliers');
