%% INSTRUCTIONS TO REPEAT THE PRACTICE
% -------------------------------------------------------------------------
% CIMCYC - Universidad de Granada  - Code written by Paloma Díaz Gutiérrez y Chema G. Peñalver
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------

RestrictKeysForKbCheck([KbName('space')]);

inst{1} = '- BLOQUE DE PRÁCTICAS -';
inst{2} = 'No hemos conseguido alcanzar el objetivo de precisión. \n Vamos a repetir el bloque de prácticas.';


%% 1. INSTRUCTIONS
% ----------------------------------------------------------------
Screen('TextFont', PTB.window, CONS.insTitleFamily);
Screen('TextSize', PTB.window, CONS.insTitleSize);
DrawFormattedText(PTB.window, inst{1},'center', 150, [0 0 0]);

Screen('TextFont', PTB.window, CONS.insFontFamily);
Screen('TextSize', PTB.window, CONS.insTextSize);
DrawFormattedText(PTB.window, inst{2},'center','center', [0 0 0],...
    [],[],[],1.5);

% SPACE BAR TO CONTINUE
Screen('TextSize', PTB.window, CONS.insSmallSize);
DrawFormattedText(PTB.window, '- PULSA LA BARRA ESPACIADORA PARA CONTINUAR -',...
    'center', PTB.screenResY-50, [0 0 0]);

Screen('Flip', PTB.window);

for i = 1 : 5
    WaitSecs(1);
    soundFeedback();
    WaitSecs(1);
end

while true
    [keyIsDown, secs, keyCode] = KbCheck;
    if keyIsDown
        repeatPractice = find(keyCode) == KbName('space');
        WaitSecs(0.2);
        break
    end
end

clearvars inst;