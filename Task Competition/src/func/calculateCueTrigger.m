%This function calculates the trigger that is needed for that specific cue
function [ triggerCode ] = calculateCueTrigger( isForced, colorComb, maxProbCong, isTop, cueType, TRIG)


if isForced
    if colorComb
        if cueType
            if maxProbCong == isTop
                triggerCode = TRIG.FOR_CIR_RV_EAS;
            else
                triggerCode = TRIG.FOR_CIR_RV_DIF;
            end
        else
            if maxProbCong == isTop
                triggerCode = TRIG.FOR_SQR_RV_EAS;
            else
                triggerCode = TRIG.FOR_SQR_RV_DIF;
            end
        end
    else
        if cueType
            if maxProbCong == isTop
                triggerCode = TRIG.FOR_CIR_AA_EAS;
            else
                triggerCode = TRIG.FOR_CIR_AA_DIF;
            end
        else
            if maxProbCong == isTop
                triggerCode = TRIG.FOR_SQR_AA_EAS;
            else
                triggerCode = TRIG.FOR_SQR_AA_DIF;
            end
        end
    end

else
    if colorComb
        if cueType
            triggerCode = TRIG.VOL_CIR_RV;
        else
            triggerCode = TRIG.VOL_SQR_RV;
        end
    else
        if cueType
            triggerCode = TRIG.VOL_CIR_AA;
        else
            triggerCode = TRIG.VOL_SQR_AA;
        end
    end
end

end
