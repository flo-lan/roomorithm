% A⊛B=(A⊖B1)∩(Ac⊖B2)
% https://docs.opencv.org/master/db/d06/tutorial_hitOrMiss.html
function [hitImg] = hit_or_miss(binImg, sElementFg, sElementBg)
    % Author: Florian Langeder
    % erode img with first structure element (A⊖B)
    erodedImg = erosion(binImg,sElementFg);
    
    % img complement
    imageComp = ~binImg;
    
    % erode complemented img Ac with second structure element.
    erodedImg2 = erosion(imageComp,sElementBg);
    
    % intersection between erodedImg and erodedImg2
    hitImg = zeros(size(binImg, 1), size(binImg,2));
    for row = 1:size(erodedImg, 1)
        for col = 1:size(erodedImg2, 2)
            hitImg(row, col) = erodedImg(row,col) & erodedImg2(row,col);
        end
    end
end