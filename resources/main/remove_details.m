function [result] = remove_details(img) 
 blackWhiteImg = rgb2gray(img); 
 invertedImg = imcomplement(blackWhiteImg); 
 % remove objects smaller than 50 pixel 
 CC = bwconncomp(invertedImg, 4); 
 S = regionprops(CC, 'Area'); 
 L = labelmatrix(CC); 
 BW2 = ismember(L, find([S.Area] >= 10000)); 
 BW3 = imerode(BW2, [1 1 1; 1 1 1; 1 1 1]); 
 BW3 = bwareaopen(BW3, 200); 
  
 % Apply morphological opening to remove 1-pixel-width vertical line 
se = strel('line',2,0); 
BW4 = imopen(BW3,se); 
BW5 = zeros(size(BW4,1)+200,size(BW4,2)+200); 
%for i = 1:size(BW4,1) 
%    for j = 1:size(BW4,2) 
%        BW5(i+100,j+100) = BW4(i,j); 
%    end 
%end 
BW5(101:end-100,101:end-100) = BW4;
result = BW5; 
end