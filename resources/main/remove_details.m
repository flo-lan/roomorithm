function [result] = remove_details(img)
 blackWhiteImg = rgb2gray(img);
 invertedImg = imcomplement(blackWhiteImg);
 % remove objects smaller than 50 pixel
 CC = bwconncomp(invertedImg, 4);
 S = regionprops(CC, 'Area');
 L = labelmatrix(CC);
 BW2 = ismember(L, find([S.Area] >= 10000));
 BW3 = imerode(BW2, [0 1 0; 1 1 1; 0 1 0]);
 
 % Apply morphological opening to remove 1-pixel-width vertical line
se = strel('line',2,0);
BW4 = imopen(BW3,se);
result = BW4;
end