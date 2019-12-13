function[result] = threshold_otsu(img, x, invert)
%threshold_Otsu computes a RGB image to a binary image with the specified threshold x.
%
%   INPUT
%   input ... RGB image
%   x     ... scalar threshold
%   invert   ... if 1, the output should be inverted such that 1 becomes 0 
%             and 0 becomes 1.
%   OUTPUT
%   result... binary RGB image which must contain either zeros or ones. The
%             result has to be of type double! Make sure that all three 
%             channels are preserved (the operation has to be performed on 
%             every channel).
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