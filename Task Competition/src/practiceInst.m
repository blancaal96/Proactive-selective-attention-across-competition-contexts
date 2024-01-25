%% INSTRUCTIONS OF THE PRACTICE BLOCKS
% -------------------------------------------------------------------------
% CIMCYC - Universidad de Granada  - Code written by Paloma Díaz Gutiérrez y Chema G. Peñalver
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------

RestrictKeysForKbCheck(KbName('space'));
inst{1} = 'BLOQUE DE PRÁCTICAS';
inst{2} = 'En primer lugar vas a realizar \n una práctica para que aprendas la dinámica de la tarea';

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