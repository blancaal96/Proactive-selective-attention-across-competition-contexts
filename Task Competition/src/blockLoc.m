%% INSTRUCTIONS FOR LOCALIZER BLOCKS
% -------------------------------------------------------------------------
% CIMCYC - Universidad de Granada  - Code written by Paloma Díaz Gutiérrez y Chema G. Peñalver
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
RestrictKeysForKbCheck(KbName('space'));
Screen('TextColor', PTB.window,  COL.black);
%% INSTRUCTION TYPE OF BLOCK %%
inst{1} = 'BLOQUE DE LOCALIZADOR';

inst{2} = 'En este bloque, pulsa la tecla C \n\n cuando el estímulo aparezca invertido.  \n\n En caso contrario, no tienes que hacer nada';

Screen('TextFont', PTB.window, CONS.insTitleFamily);
Screen('TextSize', PTB.window, CONS.insTitleSize);
DrawFormattedText(PTB.window, inst{1},'center', PTB.centerY-250);

Screen('TextFont', PTB.window, CONS.insFontFamily);
Screen('TextSize', PTB.window, CONS.insTextSize);
DrawFormattedText(PTB.window, inst{2},'center', 'center');

%% SPACE BAR TO START THE BLOCK

Screen('TextSize', PTB.window, CONS.insSmallSize);
DrawFormattedText(PTB.window, '- PULSA LA BARRA ESPACIADORA PARA CONTINUAR -',...
    'center', PTB.screenResY-50);

Screen('Flip', PTB.window);
KbWait;
WaitSecs(0.2);

