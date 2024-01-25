for i = 1:24
    
    bloque(i) = (OUT_E.endofTrial(48,i)) - OUT_E.cueOnset(1,i);
%     bloque(i) = bloque(i)/60;
    for r= 1:48
    dur_ensayo(r,i) = (OUT_E.endofTrial(r,i))- OUT_E.cueOnset(r,i);
    end
    
end