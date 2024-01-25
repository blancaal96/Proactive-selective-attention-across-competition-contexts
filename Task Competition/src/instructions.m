%% EEG-Competition Task (instructions.m)
% -------------------------------------------------------------------------
% CIMCYC - Universidad de Granada  - Code written by Paloma D�az Guti�rrez y Chema G. Pe�alver
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% This script contains the instructuins that the participant will read
initialTimeStamp = GetSecs;
TRIGHIST = 0;
TRIG_Onset = 0;
RestrictKeysForKbCheck(KbName('space'));

if strcmp(SUBJECT_INFO.gender, 'Male')
    inst{1} = '�BIENVENIDO A ESTE EXPERIMENTO!';
else
    inst{1} = '�BIENVENIDA A ESTE EXPERIMENTO!';
end

inst{2} = 'INSTRUCCIONES';
inst{3} = 'En este experimento vas a ver una serie de est�mulos objetivo, que pueden ser: \n\n   CARAS                 o                 NOMBRES';
inst{4} = 'Tu tarea consistir� en indicar el G�NERO del est�mulo objetivo. \n\n Es decir, tendr�s que indicar si est� asociado a MUJER o a HOMBRE.';
inst{5} = 'A lo largo del experimento realizar�s dos tipos de bloques: \n\n los de ALTA COMPETICI�N y los de BAJA COMPETICI�N. \n\n En los de ALTA COMPETICI�N el est�mulo objetivo aparecer� a la vez que otro est�mulo. \n\n Por otro lado, en los de BAJA COMPETICI�N ver�s primero el est�mulo objetivo \n seguido de un segundo est�mulo. \n\n\n\n Al inicio de cada bloque ver�s una instrucci�n que informa del tipo de bloque que va a continuaci�n.';
inst{6} = 'Dentro de cada bloque, te aparecer�  una secuencia de ensayos \n compuestos por una se�al que te indicar� el tipo de est�mulo objetivo, \n esto es, si tienes que responder ante CARAS o NOMBRES.';
inst{7} = 'Debes poner atenci�n a la se�al para tener claro si debes responder a CARAS o NOMBRES \n e intentar responder lo m�s r�pido que puedas intentando no fallar.'; 
inst{8} = 'Las se�ales asociadas a cada tipo de est�mulo son las siguientes aparecen abajo. \n Son las mismas en los bloques de alta y baja competici�n.';
inst{9} = 'Las teclas con las que debes responder en cada caso \n y DURANTE TODO EL EXPERIMENTO son las siguientes:'; 
inst{10} = 'ALTA COMPETICI�N';
inst{11} = 'BAJA COMPETICI�N';
inst{12} = 'CARAS';
inst{13} = 'NOMBRES';
inst{14} = 'TECLAS DE RESPUESTA';
inst{15} = 'Finalmente, en otras ocasiones te vas a encontrar con un tercer tipo de bloque,\n\n llamado LOCALIZADOR. \n\n\n En estos casos tu tarea consistir� en ver una serie de est�mulos \n\n y responde �NICAMENTE cuando aparezca en la pantalla de arriba a abajo. \n\n\n Cuando sea este el caso, pulsa C. \n\n\n Recuerda, en los bloques LOCALIZADOR pulsa C cuando veas \n\n un est�mulo presentado en posici�n INVERSA. \n\n En caso contario, no tienes que hacer nada.';
%%Selecting and naming the cues for each block and stimulus
FaceHigh = EDATA.CueFaceHigh(1:2);
FH1 = FaceHigh(1);
FH2 = FaceHigh(2);
FaceLow = EDATA.CueFaceLow(1:2);
FL1 = FaceLow(1);
FL2 = FaceLow(2);
NameHigh = EDATA.CueNameHigh(1:2);
NH1 = NameHigh(1);
NH2 = NameHigh(2);
NameLow = EDATA.CueNameLow(1:2);
NL1 = NameLow(1);
NL2 = NameLow(2);
%% 1. PAGE-1. WELCOME 
% ----------------------------------------------------------------
% Title
Screen('TextSize', PTB.window, CONS.insTitleSize);
Screen('TextFont', PTB.window, CONS.insTitleFamily);
DrawFormattedText(PTB.window, inst{1},'center', 150);

% Image
Screen('DrawTexture', PTB.window, BRAIN.brainSmallTexture);

% PRESS THE SPACE BAR TO CONTINUE
Screen('TextFont', PTB.window, CONS.insFontFamily);
Screen('TextSize', PTB.window, CONS.insTextSize);
DrawFormattedText(PTB.window, '- PULSA LA BARRA ESPACIADORA PARA COMENZAR -',...
    'center', PTB.screenResY-50);

Screen('Flip', PTB.window);
      
KbWait;
WaitSecs(0.2);

%% 2. PAGE-2. INSTRUCTIONS 1 - INSTRUCCI?N GENERAL
% ----------------------------------------------------------------
% Title
Screen('TextSize', PTB.window, CONS.insTitleSize);
Screen('TextFont', PTB.window, CONS.insTitleFamily);
DrawFormattedText(PTB.window, inst{2},'center', PTB.centerY/4.5);

% Text
Screen('TextFont', PTB.window, CONS.insFontFamily);
Screen('TextSize', PTB.window, CONS.insTextSize);
DrawFormattedText(PTB.window, inst{3},'center',  PTB.centerY/2.5);

% Preloading the images of faces and names
Screen('DrawTexture', PTB.window, INS.stimuli_Texture, [], example_loc);

% Text
Screen('TextFont', PTB.window, CONS.insFontFamily);
Screen('TextSize', PTB.window, CONS.insTextSize);
DrawFormattedText(PTB.window, inst{4},'center',  PTB.centerY*1.5);

% PRESS THE SPACE BAR TO CONTINUE
Screen('TextSize', PTB.window, CONS.insSmallSize);
DrawFormattedText(PTB.window, '- PULSA LA BARRA ESPACIADORA PARA CONTINUAR -',...
    'center', PTB.screenResY-50);

Screen('Flip', PTB.window);

KbWait;
WaitSecs(0.2);

% -----

%% 3. PAGE-3. INSTRUCTIONS 3 - TYPES OF BLOCKS
% ----------------------------------------------------------------
% Title
Screen('TextFont', PTB.window, CONS.insTitleFamily);
Screen('TextSize', PTB.window, CONS.insTitleSize);
DrawFormattedText(PTB.window, inst{2},'center', PTB.centerY/4.5,  [],[],[],[],1.5);

% Text
Screen('TextFont', PTB.window, CONS.insFontFamily);
Screen('TextSize', PTB.window, CONS.insTextSize);
DrawFormattedText(PTB.window, inst{5},'center',  PTB.centerY/2,...
    [],[],[],[],1.5);

% PRESS THE SPACE BAR TO CONTINUE
Screen('TextSize', PTB.window, CONS.insSmallSize);
DrawFormattedText(PTB.window, '-  PULSA LA BARRA ESPACIADORA PARA VER UN EJEMPLO -',...
    'center', PTB.screenResY-50);

Screen('Flip', PTB.window);

KbWait;
WaitSecs(0.2);

%% 4. PAGE-4. INSTRUCTIONS 4 - EXAMPLES OF BLOCKS
% ----------------------------------------------------------------
% Title
Screen('TextFont', PTB.window, CONS.insTitleFamily);
Screen('TextSize', PTB.window, CONS.insTitleSize);
DrawFormattedText(PTB.window, inst{2},'center', PTB.centerY/4.5,  [],[],[],[],1.5);

% Image type of block
Screen('DrawTexture', PTB.window, INS.blocks_Texture);

% PRESS THE SPACE BAR TO CONTINUE
Screen('TextSize', PTB.window, CONS.insSmallSize);
DrawFormattedText(PTB.window, '-  PULSA LA BARRA ESPACIADORA PARA CONTINUAR -',...
    'center', PTB.screenResY-50);

Screen('Flip', PTB.window);

KbWait;
WaitSecs(0.2);

%% 5. PAGE-5. INSTRUCTIONS 5 -  EXPLAINING THE STIMULI SEQUENCE IN A TRIAL  
% ----------------------------------------------------------------
% Title
Screen('TextFont', PTB.window, CONS.insTitleFamily);
Screen('TextSize', PTB.window, CONS.insTitleSize);
DrawFormattedText(PTB.window, inst{2},'center', PTB.centerY/4.5,  [],[],[],[],1.5);

% Text
Screen('TextFont', PTB.window, CONS.insFontFamily);
Screen('TextSize', PTB.window, CONS.insTextSize);
DrawFormattedText(PTB.window, inst{6},'center',  PTB.centerY-200,...
    [],[],[],[],1.5);
Screen('TextSize', PTB.window, CONS.insTextSize);
DrawFormattedText(PTB.window, inst{7},'center',  PTB.centerY+150,...
    [],[],[],[],1.5);

% PRESS THE SPACE BAR TO CONTINUE
Screen('TextSize', PTB.window, CONS.insSmallSize);
DrawFormattedText(PTB.window, '-  PULSA LA BARRA ESPACIADORA PARA CONTINUAR -',...
    'center', PTB.screenResY-50);

Screen('Flip', PTB.window);

KbWait;
WaitSecs(0.2);

%% 6. PAGE-6. INSTRUCTIONS 6 -CUES, TARGET AND DISTRACTOR
% ----------------------------------------------------------------
% Title
Screen('TextFont', PTB.window, CONS.insTitleFamily);
Screen('TextSize', PTB.window, CONS.insTitleSize);
DrawFormattedText(PTB.window, inst{2},'center', PTB.centerY/4.5,  [],[],[],[],1.5);

% Text
Screen('TextFont', PTB.window, CONS.insFontFamily);
Screen('TextSize', PTB.window, CONS.insTextSize);
DrawFormattedText(PTB.window, inst{8},'center',  PTB.centerY-210,  [],[],[],[],1.5);

% DISPLAYING THE CUES FOR EACH STIMULI

Screen('DrawTexture', PTB.window, CUE.Texture{FH1}, [], UpLeft);
Screen('DrawTexture', PTB.window, CUE.Texture{FL1}, [], DownLeft);
Screen('DrawTexture', PTB.window, CUE.Texture{NH1}, [], UpRight);
Screen('DrawTexture', PTB.window, CUE.Texture{NL1}, [], DownRight);

% LABELS OF STIMULI ASSIGNED TO EACH CUE

Screen('TextSize', PTB.window, CONS.insTitleSize);
DrawFormattedText(PTB.window, inst{12},PTB.centerX/1.35,  PTB.centerY*1.6);
Screen('TextSize', PTB.window, CONS.insTitleSize);
DrawFormattedText(PTB.window, inst{13},PTB.centerX*1.05, PTB.centerY*1.6);



% PRESS THE SPACE BAR TO CONTINUE
Screen('TextSize', PTB.window, CONS.insSmallSize);
DrawFormattedText(PTB.window, '-  PULSA LA BARRA ESPACIADORA PARA CONTINUAR -',...
    'center', PTB.screenResY-50);

Screen('Flip', PTB.window);

KbWait;
WaitSecs(0.2);

%% 7. PAGE-7. INSTRUCTIONS 7 -RESPONSE KEYS
% ----------------------------------------------------------------
% Title
Screen('TextFont', PTB.window, CONS.insTitleFamily);
Screen('TextSize', PTB.window, CONS.insTitleSize);
DrawFormattedText(PTB.window, inst{14},'center', PTB.centerY/4.5);

% Text
Screen('TextFont', PTB.window, CONS.insFontFamily);
Screen('TextSize', PTB.window, CONS.insTextSize);
DrawFormattedText(PTB.window, inst{9},'center',  PTB.centerY/1.5,...
    [],[],[],[],1.5);

% Example responses
Screen('DrawTexture', PTB.window, INS.responses_Texture, [], resp_loc);

%  PRESS THE SPACE BAR TO CONTINUE
Screen('TextSize', PTB.window, CONS.insSmallSize);
DrawFormattedText(PTB.window, '-  PULSA LA BARRA ESPACIADORA PARA CONTINUAR -',...
    'center', PTB.screenResY-50);

Screen('Flip', PTB.window);

KbWait;
WaitSecs(0.2);


%% 8. PAGE-8. INSTRUCTIONS 8 -LOCALIZER
% Title
Screen('TextFont', PTB.window, CONS.insTitleFamily);
Screen('TextSize', PTB.window, CONS.insTitleSize);
DrawFormattedText(PTB.window, inst{2},'center', PTB.centerY/4.5,  [],[],[],[],1.5);

% Text
Screen('TextFont', PTB.window, CONS.insFontFamily);
Screen('TextSize', PTB.window, CONS.insTextSize);
DrawFormattedText(PTB.window, inst{15},'center',  'center');

%  PRESS THE SPACE BAR TO CONTINUE
Screen('TextSize', PTB.window, CONS.insSmallSize);
DrawFormattedText(PTB.window, '-  PULSA LA BARRA ESPACIADORA PARA COMENZAR LA PR�CTICA -',...
    'center', PTB.screenResY-50);

Screen('Flip', PTB.window);

KbWait;
WaitSecs(0.2);



clearvars inst;