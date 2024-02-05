%% This script displays the instructions of the practice blocks on the screen
% -------------------------------------------------------------------------
% CIMCYC - Universidad de Granada  - Code written by Paloma D�az Guti�rrez y Chema G. Pe�alver
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------

RestrictKeysForKbCheck(KbName('space'));
inst{1} = 'BLOQUE DE PR�CTICAS';
inst{2} = 'En primer lugar vas a realizar \n una pr�ctica para que aprendas la din�mica de la tarea';

%% 1. STARTING PRACTICE BLOCK
% ----------------------------------------------------------------
Screen('TextFont', PTB.window, CONS.insTitleFamily);
Screen('TextSize', PTB.window, CONS.insTitleSize);
DrawFormattedText(PTB.window, inst{1},'center', 'center');


Screen('TextFont', PTB.window, CONS.insFontFamily);
Screen('TextSize', PTB.window, CONS.insSmallSize);
DrawFormattedText(PTB.window, '- PULSA LA BARRA ESPACIADORA PARA COMENZAR -',...
    'center', PTB.screenResY-50);

Screen('Flip', PTB.window);

while true
    [keyIsDown, secs, keyCode] = KbCheck;
    if keyIsDown
        runPracticeBlock = find(keyCode) == KbName('space');
        WaitSecs(0.2);
        break
    end
end

% ----------------------------------------------------------------
clearvars inst;
