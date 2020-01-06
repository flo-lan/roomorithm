function [window_count] = windowdetection(img, w_tc)
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
 
 sElementUpWindow = [0 0 1 0 0
                      0 0 1 0 0 
                      0 0 1 0 0 
                      0 0 1 0 0
                      1 1 1 1 1
                      0 0 0 0 0
                      0 0 0 0 0];
 sElementUpWindowNegative = [1 0 0 1 1 
                             1 0 0 1 1
                             1 0 0 1 1 
                             1 0 0 1 1
                             0 0 0 0 0
                             0 0 0 0 0
                             1 1 1 1 1];
 hitImgUpWindow = hit_or_miss(threshold_img, sElementUpWindow, sElementUpWindowNegative);
 
 sElementDownWindow = [0 0 0 0 0
                       0 0 0 0 0 
                       1 1 1 1 1 
                       0 0 1 0 0
                       0 0 1 0 0
                       0 0 1 0 0
                       0 0 1 0 0];
 sElementDownWindowNegative = [1 1 1 1 1 
                               0 0 0 0 0
                               0 0 0 0 0 
                               1 0 0 1 1
                               1 0 0 1 1
                               1 0 0 1 1
                               1 0 0 1 1];
 hitImgDownWindow = hit_or_miss(threshold_img, sElementDownWindow, sElementDownWindowNegative);
 
 window_count = 0;
 % loop through annotated image
   for row = 1:size(threshold_img, 1)
        for col = 1:size(threshold_img, 2)
            % left side of window detected
            if (hitImgLeftWindow(row, col) == 1 && col < size(threshold_img,2))
                % go to the right until either no white pixel was found or
                % the correct right part of the window was found
                for windowCol = col+1:size(threshold_img,2)
                    if (hitImgRightWindow(row, windowCol) == 1)
                       % counterpart found
                       if ((windowCol - col) > w_tc * 2)
                           % distance needs to be larger than average wall
                           % thickness + extra
                           window_count = window_count + 1;
                       end
                       break
                    elseif (threshold_img(row, windowCol) == 0)
                        % no connected pixel (white line must go between
                        % annotated points
                        break
                    elseif ((size(threshold_img, 1) > (row + 2) && threshold_img(row + 2, windowCol) == 255) || ((row - 2) > 0 && threshold_img(row - 2, windowCol) == 255))
                       break
                    end
                end
            end
            
            % upper side of window detected
            if (hitImgDownWindow(row, col) == 1 && row < size(threshold_img,1))
               % go to the right until either no white pixel was found or
               % the correct right part of the window was found
               for windowRow = row+1:size(threshold_img,1)
                   if (hitImgUpWindow(windowRow, col) == 1)
                       % counterpart found
                       if ((windowRow - row) > w_tc * 2)
                           % distance needs to be larger than average wall
                           % thickness + extra
                           window_count = window_count + 1;
                       end
                       break
                   elseif (threshold_img(windowRow, col) == 0)
                       % no connected pixel (white line must go between
                       % annotated points
                       break
                   elseif ((size(threshold_img, 2) > (col + 2) && threshold_img(windowRow, col + 2) == 255) || ((col - 2) > 0 && threshold_img(windowRow, col - 2) == 255))
                       break
                   end                   
                end
            end
        end
   end
end