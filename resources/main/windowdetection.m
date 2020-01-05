function [window_count] = windowdetection(img)
%DOORDETECTION Author: Florian Langeder
 blackWhiteImg = rgb2gray(img); 
 threshold_img = threshold_otsu(blackWhiteImg, 0.7, 1);
 
 sElementLeftWindow = [0 0 1 0 0 0 0
                       0 0 1 0 0 0 0
                       0 0 1 1 1 1 1
                       0 0 1 0 0 0 0
                       0 0 1 0 0 0 0];
 sElementLeftWindowNegative = [1 0 0 1 1 1 1
                               1 0 0 0 0 0 0
                               1 0 0 0 0 0 0
                               1 0 0 1 1 1 1
                               1 0 0 1 1 1 1];
 hitImgLeftWindow = hitOrMiss(threshold_img, sElementLeftWindow, sElementLeftWindowNegative);
 
 sElementRightWindow = [0 0 0 0 1 0 0
                        0 0 0 0 1 0 0
                        1 1 1 1 1 0 0
                        0 0 0 0 1 0 0
                        0 0 0 0 1 0 0];
 sElementRightWindowNegative = [1 1 1 1 0 0 1
                                0 0 0 0 0 0 1
                                0 0 0 0 0 0 1
                                1 1 1 1 0 0 1
                                1 1 1 1 0 0 1];
 hitImgRightWindow = hitOrMiss(threshold_img, sElementRightWindow, sElementRightWindowNegative);
 annotatedWindows = imoverlay(threshold_img, hitImgLeftWindow, 'red');
 annotatedWindows = imoverlay(annotatedWindows, hitImgRightWindow, 'green');
 %imshowpair(redHitImg,annotatedWindows,'montage');
 imshow(annotatedWindows);
 sum(hitImgRightWindow(:) == 1)
 window_count = sum(hitImgLeftWindow(:) == 1);
end

% A⊛B=(A⊖B1)∩(Ac⊖B2)
% https://docs.opencv.org/master/db/d06/tutorial_hitOrMiss.html
function [hitImg] = hitOrMiss(binImg, sElementFg, sElementBg)
    % erode img with first structure element (A⊖B)
    erodedImg = imerode(binImg,sElementFg);
    
    % img complement
    imageComp = ~binImg;
    
    % erode complemented img Ac with second structure element.
    erodedImg2 = imerode(imageComp,sElementBg);
    
    % intersection between erodedImg and erodedImg2
    hitImg = zeros(size(binImg, 1), size(binImg,2));
    for row = 1:size(erodedImg, 1)
        for col = 1:size(erodedImg2, 2)
            hitImg(row, col) = erodedImg(row,col) & erodedImg2(row,col);
        end
    end
end