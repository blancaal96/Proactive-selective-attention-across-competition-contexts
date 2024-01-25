%% INSTRUCTIONS FOR EXPERIMENTAL SESSION
% -------------------------------------------------------------------------
% CIMCYC - Universidad de Granada  - Code written by Paloma Díaz Gutiérrez y Chema G. Peñalver
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------

RestrictKeysForKbCheck(KbName('space'));

inst{1} = 'BLOQUE EXPERIMENTAL';
inst{2} = 'A continuación vas a realizar el experimento.';

%% 1. Starting experimental session
% ----------------------------------------------------------------
Screen('TextFont', PTB.window, CONS.insTitleFamily);
Screen('TextSize', PTB.window, CONS.insTitleSize);
DrawFormattedText(PTB.window, inst{1},'center', PTB.centerY-50);

Screen('TextFont', PTB.window, CONS.insFontFamily);
Screen('TextSize', PTB.window, CONS.insTextSize);
DrawFormattedText(PTB.window, inst{2},'center', PTB.centerY+50);

Screen('TextSize', PTB.window, CONS.insSmallSize);
DrawFormattedText(PTB.window, '- PULSA LA BARRA ESPACIADORA PARA COMENZAR -',...
    'center', PTB.screenResY-50);

Screen('Flip', PTB.window);
      
KbWait;
WaitSecs(0.2);

% ----------------------------------------------------------------
clearvars inst;