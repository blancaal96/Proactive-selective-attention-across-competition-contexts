%% EEG-Competition Task (main.m)
% -------------------------------------------------------------------------
% CIMCYC - Universidad de Granada  - Code written by Paloma D�az Guti�rrez and Chema G. Pe�alver
% Adapted by Blanca Aguado L�pez (blancaal@ugr.es)
% -------------------------------------------------------------------------

clc

%% 1. EXPERIMENT INITIALIZATION
% ----------------------------------------------------------
run src\session.m           % Session initialization
run src\conf.m              % Experiment configuration
run src\ctb.m               % Counterbalance configuration
run src\init2.m             % Experiment initialization
run src\ptb.m

%% 2. INSTRUCTIONS
% ----------------------------------------------------------
run src\instructions.m

%% 3. PRACTICE
% ----------------------------------------------------------
 run src\practiceInst.m
 run src\practice.m

%% 4. EXPERIMENT
% ----------------------------------------------------------
run src\experimentalInst.m
run src\experimental.m

%% 5. SAVE DATA
% ---------------------------------------------------------
run src\saveworkspace.m     % Save output data

%% 5. GOODBYE
% ---------------------------------------------------------
run src\goodbye.m           % Goodbye!
