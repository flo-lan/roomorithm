function [result] = remove_details(img) 
 % Author: Florian Langedder
 blackWhiteImg = rgb2gray(img); 
 invertedImg = imcomplement(blackWhiteImg); 
 % remove objects smaller than threshold
 CC = bwconncomp(invertedImg, 4); 
 S = regionprops(CC, 'Area'); 
 L = labelmatrix(CC); 
 BW2 = ismember(L, find([S.Area] >= 10000)); 
 BW3 = imerode(BW2, [1 1 1; 1 1 1; 1 1 1]); 
   
 % Apply morphological opening to remove 1-pixel-width vertical line 
 se = strel('line',2,0); 
 BW4 = imopen(BW3,se); 
 BW5 = zeros(size(BW4,1)+200,size(BW4,2)+200); 

 BW5(101:end-100,101:end-100) = BW4;
 BW5 = bwareaopen(BW5, 500); 
 result = BW5; 
end