%% This script displays the instructions on the screen for the localizer blocks
% -------------------------------------------------------------------------
% CIMCYC - Universidad de Granada  - Code written by Paloma D�az Guti�rrez y Chema G. Pe�alver
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
RestrictKeysForKbCheck(KbName('space'));
Screen('TextColor', PTB.window,  COL.black);
%% INSTRUCTION TYPE OF BLOCK %%
inst{1} = 'BLOQUE DE LOCALIZADOR';

inst{2} = 'En este bloque, pulsa la tecla C \n\n cuando el est�mulo aparezca invertido.  \n\n En caso contrario, no tienes que hacer nada';

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
