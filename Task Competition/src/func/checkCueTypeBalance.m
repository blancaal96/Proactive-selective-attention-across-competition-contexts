function [ balance ] = checkCueTypeBalance( expCueMtx, expCueTypeMtx )


[blocks, trials] = size (expCueMtx);
balance = zeros (4, blocks);

for i = 1 : blocks
    nCirclesTop = 0;
    nSquaresTop = 0;
    nCirclesBottom = 0;
    nSquaresBottom = 0;
    
    for j = 1 : trials
        isTop = expCueMtx(i,j);
        isCircle = expCueTypeMtx(i,j);
        
        if isTop
            if isCircle
                nCirclesTop = nCirclesTop + 1;
            else
                nSquaresTop = nSquaresTop + 1;
            end
        else
            if isCircle
                nCirclesBottom = nCirclesBottom + 1;
            else
                nSquaresBottom = nSquaresBottom + 1;
            end
        end
    end
    
    balance(1,i) = nCirclesTop;
    balance(2,i) = nCirclesBottom;
    balance(3,i) = nSquaresTop;
    balance(4,i) = nSquaresTop;
    
end

end

