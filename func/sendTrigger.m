function [ TRIGGER, time] = sendTrigger( PPORT, TRIGGER)
%SENDTRIGGER This function writes the specified value on the parallel port if it is available. 
%   This function return true if the trigger was sent.
if ~PPORT.status
    io64(PPORT.OBJECT, PPORT.ADDRESS, TRIGGER);
    time = GetSecs();
    pause(0.01);
    io64(PPORT.OBJECT, PPORT.ADDRESS, 0);
    pause(0.001);
end
end

