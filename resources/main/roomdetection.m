function [result] = roomdetection(img)
 threshold_img = threshold_otsu(img, 0.5, 1);
 result = im2double(bwdist(threshold_img));
end
