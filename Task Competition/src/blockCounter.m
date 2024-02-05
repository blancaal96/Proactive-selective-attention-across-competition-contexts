%% This script displays the instructions on the screen according to the block type
% -------------------------------------------------------------------------
% CIMCYC - Universidad de Granada  - Code written by Paloma D�az Guti�rrez y Chema G. Pe�alver
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
RestrictKeysForKbCheck(KbName('space'));
Screen('TextColor', PTB.window,  COL.black);
%% INSTRUCTIONS TYPE OF BLOCK

if EDATA.BlockType(block) == 1
    inst{1} = 'BLOQUE DE ALTA COMPETICI�N';
else
    inst{1} = 'BLOQUE DE BAJA COMPETICI�N';
end

inst{2} = 'En este bloque, las claves asociadas con \n\n cada tipo de est�mulo son las siguientes:';
inst{3} = ['Pulsa ' [respmal] ' si el est�mulo es HOMBRE y ' [respfem] ' si es MUJER'];

Screen('TextFont', PTB.window, CONS.insTitleFamily);
Screen('TextSize', PTB.window, CONS.insTitleSize);
DrawFormattedText(PTB.window, inst{1},'center', PTB.centerY-250);

Screen('TextFont', PTB.window, CONS.insFontFamily);
Screen('TextSize', PTB.window, CONS.insTextSize);
DrawFormattedText(PTB.window, inst{2},'center', PTB.centerY-150);

%% Reminder of the cues of that block
Screen('TextSize', PTB.window, CONS.insTitleSize);
    DrawFormattedText(PTB.window, 'CARAS',...
    PTB.centerX-250, PTB.centerY+50);
Screen('TextSize', PTB.window, CONS.insTitleSize);
    DrawFormattedText(PTB.window, 'NOMBRES',...
    PTB.centerX+60, PTB.centerY+50);

Screen('DrawTexture', PTB.window,BlockCueFace, [], LocationFaceCue);
Screen('DrawTexture', PTB.window,BlockCueName, [], LocationNameCue);

%% Remider of the keys of response

Screen('TextSize', PTB.window, CONS.insTextSize);
    DrawFormattedText(PTB.window, inst{3},...
    PTB.centerX-300, PTB.centerY+350);


%% PRESS THE SPACE BAR TO CONTINUE

Screen('TextSize', PTB.window, CONS.insSmallSize);
DrawFormattedText(PTB.window, '- PULSA LA BARRA ESPACIADORA PARA CONTINUAR -',...
    'center', PTB.screenResY-50);

Screen('Flip', PTB.window);
KbWait;
WaitSecs(0.2);
