%% FORCED STOP EVERY 6 BLOCKS
% -------------------------------------------------------------------------
% CIMCYC - Universidad de Granada  - Code written by Paloma Díaz Gutiérrez and Chema G. Peñalver
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------

%% 1. PAUSE
% ----------------------------------------------------------------
RestrictKeysForKbCheck(KEYS.c);
Screen('TextFont', PTB.window, CONS.insFontFamily);
inst{1} = 'Tiempo de descanso \n\n Espera al experimentador para poder continuar';

%% 2. PRESS C TO CONTINUE
% ----------------------------------------------------------------
Screen('TextSize', PTB.window, CONS.insTextSize);
DrawFormattedText(PTB.window, inst{1},'center', PTB.centerY*1.5, [0 0 0],...
    [],[],[],1.5);

Screen('DrawTexture', PTB.window, BRAIN.brainSmallTexture);
Screen('Flip', PTB.window);

for i = 1 : 5
    WaitSecs(1);
    soundFeedback();
    WaitSecs(1);
end
      
KbWait;
WaitSecs(0.2);

clearvars inst;