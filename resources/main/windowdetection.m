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
 hitImgLeftWindow = hit_or_miss(threshold_img, sElementLeftWindow, sElementLeftWindowNegative);
 
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
 hitImgRightWindow = hit_or_miss(threshold_img, sElementRightWindow, sElementRightWindowNegative);
 annotatedWindows = imoverlay(threshold_img, hitImgLeftWindow, 'red');
 annotatedWindows = imoverlay(annotatedWindows, hitImgRightWindow, 'green');
 %imshowpair(redHitImg,annotatedWindows,'montage');
 imshow(annotatedWindows);
 sum(hitImgRightWindow(:) == 1)
 window_count = sum(hitImgLeftWindow(:) == 1);
end