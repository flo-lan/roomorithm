function[result] = threshold_otsu(img, x, invert)
%THRESHOLD_OTSU Author: Alam Mark
 input = im2double(img);
 input2 = input;
 less = 0.0;
 greater = 1.0;
     
    if invert == 1
        input2(input <= x) = greater;
        input2(input > x) = less;
    else
        input2(input > x) = greater;
        input2(input <= x) = less;
    end
    result = input2;
end