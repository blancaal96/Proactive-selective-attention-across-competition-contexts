# Competition_EEG
This repository contains the codes used for the work "Proactive selective attention across competition contexts" by B. Aguado-López, A. F. Palenciano, J. M.G. Peñalver, P. Díaz-Gutiérrez, D. López-García, C. Avancini, L. F. Ciria, M. Ruz. 

Most of the code is written for Matlab, only the mediation code (/Analyses/Scripts time frequency/mediation theta.R) is for R.

 ## Analyses 
 The folder #### /Analyses contains subfolders for the behavioral and EEG analyses based on EEG data on BIDS format.
  ### Behavioral analysis
  Inside the subfolder /Script for extracting behavioral indexes you need to run the script "behav_2.m", it will give you the results of the sample to perform statistics.
  ### Multivariate analyses of EEG data
There is the subfolder /Scripts MVPA. These scripts use the toolbox MVPAlab (https://github.com/dlopezg/mvpalab) that you need to download to run the analyses. All the subfolders mvcc or mvpa contain a cfg file with the configuration, while the script to run is "mvpa_demo.m" or "mvcc....m"
The subfolder /comparing decoding curves ttest contains 3 files, the file to run is "ttest_vectors_3.m"
The subfolder /Extracting decoding for correlations contains the file "corrBehav.m" to calculate the mean of decoding indexes for each subject.
   ### Time-frequency analysis
There is the subfolder /Scripts time frequency. We use Eeglab and Fieldtrip toolboxes that you need to download to run the analyses. The first file to run is "extracting power time-freq.m", then to compute the significant cluster you need to run "clusterTheta.m". For the mediation analyses there are 4 files; first you need to run "TableForMediation.m" and it runs "ExtractCongrforcuesBIDS.m". After that you need to run "filteringtrialstheta.m" and with the final table you go to R and run the script "mediation theta.R".


  ## Task Competition
 The folder /Task Competition contains the code to run the task
 You need to download Psychtoolbox. The script you need to run is the "start.m" that calls the scripts inside the subfolder /src.
