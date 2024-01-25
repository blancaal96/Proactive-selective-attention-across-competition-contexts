%% INSTRUCTIONS AT THE END OF THE TASK- GOODBYE
% -------------------------------------------------------------------------
% CIMCYC - Universidad de Granada  - Code written by Paloma Díaz Gutiérrez y Chema G. Peñalver
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
RestrictKeysForKbCheck([]);
Screen('TextFont', PTB.window, 'Helvetica');

inst{1} = 'Ya has terminado el experimento \n MUCHISIMAS GRACIAS POR TU COLABORACION';

%% 1. GOODBYE, KEY TO QUIT
% ----------------------------------------------------------------
Screen('TextSize', PTB.window, CONS.insTitleSize);
DrawFormattedText(PTB.window, inst{1},'center', 'center',COL.black);
Screen('TextSize', PTB.window, CONS.insSmallSize);
DrawFormattedText(PTB.window, '- PRESS Q TO EXIT -',...
    'center', PTB.screenResY-50);
Screen('Flip', PTB.window);

KbWait;
WaitSecs(0.2);

%% 2. CLEARVARS 
% ----------------------------------------------------------------
clearvars inst;

%% 3. CLEAN PATH
% ----------------------------------------------------------------
[~,struc] = fileattrib;
PathCurrent = struc.Name;
rmpath([PathCurrent '/func']);
rmpath([PathCurrent '/mexf/io64']);

%% 4. CLOSE ALL
% ---------------------------------------------------------
Screen('CloseAll')          % Close all windows
