triggerVector = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 32 48 64 80 96 112 128 144 160 176 192 208 224 240];

if IsWin
    PPORT.OBJECT = io64;
    PPORT.ADDRESS = hex2dec('E800'); 
    PPORT.status = io64(PPORT.OBJECT);

    if PPORT.status
        uiwait(warndlg({'Parallel port connection error.';'Press OK to continue.'},'Warning!'));
    end
else
    PPORT.status = 1;
    PPORT.OBJECT = NaN;
    PPORT.ADDRESS = NaN;
    uiwait(warndlg({'No parallel port connection.';'Press OK to continue.'},'Warning!'));
end

for i = 1:length(triggerVector)
    if ~PPORT.status
        io64(PPORT.OBJECT, PPORT.ADDRESS, triggerVector(i));
        pause(0.1)
        io64(PPORT.OBJECT, PPORT.ADDRESS, 0);
        pause(0.1)
    end
end

