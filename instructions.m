%% EEG-Competition Task (instructions.m)
% -------------------------------------------------------------------------
% CIMCYC - Universidad de Granada  - Code written by Paloma Díaz Gutiérrez y Chema G. Peñalver
% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% This script contains the instructuins that the participant will read
initialTimeStamp = GetSecs;
TRIGHIST = 0;
TRIG_Onset = 0;
RestrictKeysForKbCheck(KbName('space'));

if strcmp(SUBJECT_INFO.gender, 'Male')
    inst{1} = '¡BIENVENIDO A ESTE EXPERIMENTO!';
else
    inst{1} = '¡BIENVENIDA A ESTE EXPERIMENTO!';
end

inst{2} = 'INSTRUCCIONES';
inst{3} = 'En este experimento vas a ver una serie de estímulos objetivo, que pueden ser: \n\n   CARAS                 o                 NOMBRES';
inst{4} = 'Tu tarea consistirá en indicar el GÉNERO del estímulo objetivo. \n\n Es decir, tendrás que indicar si está asociado a MUJER o a HOMBRE.';
inst{5} = 'A lo largo del experimento realizarás dos tipos de bloques: \n\n los de ALTA COMPETICIÓN y los de BAJA COMPETICIÓN. \n\n En los de ALTA COMPETICIÓN el estímulo objetivo aparecerá a la vez que otro estímulo. \n\n Por otro lado, en los de BAJA COMPETICIÓN verás primero el estímulo objetivo \n seguido de un segundo estímulo. \n\n\n\n Al inicio de cada bloque verás una instrucción que informa del tipo de bloque que va a continuación.';
inst{6} = 'Dentro de cada bloque, te aparecerá  una secuencia de ensayos \n compuestos por una señal que te indicará el tipo de estímulo objetivo, \n esto es, si tienes que responder ante CARAS o NOMBRES.';
inst{7} = 'Debes poner atención a la señal para tener claro si debes responder a CARAS o NOMBRES \n e intentar responder lo más rápido que puedas intentando no fallar.'; 
inst{8} = 'Las señales asociadas a cada tipo de estímulo son las siguientes aparecen abajo. \n Son las mismas en los bloques de alta y baja competición.';
inst{9} = 'Las teclas con las que debes responder en cada caso \n y DURANTE TODO EL EXPERIMENTO son las siguientes:'; 
inst{10} = 'ALTA COMPETICIÓN';
inst{11} = 'BAJA COMPETICIÓN';
inst{12} = 'CARAS';
inst{13} = 'NOMBRES';
inst{14} = 'TECLAS DE RESPUESTA';
inst{15} = 'Finalmente, en otras ocasiones te vas a encontrar con un tercer tipo de bloque,\n\n llamado LOCALIZADOR. \n\n\n En estos casos tu tarea consistirá en ver una serie de estímulos \n\n y responde ÚNICAMENTE cuando aparezca en la pantalla de arriba a abajo. \n\n\n Cuando sea este el caso, pulsa C. \n\n\n Recuerda, en los bloques LOCALIZADOR pulsa C cuando veas \n\n un estímulo presentado en posición INVERSA. \n\n En caso contario, no tienes que hacer nada.';
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
DrawFormattedText(PTB.window, '-  PULSA LA BARRA ESPACIADORA PARA COMENZAR LA PRÁCTICA -',...
    'center', PTB.screenResY-50);

Screen('Flip', PTB.window);

KbWait;
WaitSecs(0.2);



clearvars inst;