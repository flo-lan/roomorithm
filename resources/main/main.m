function main
 img = imread('img/Datei3.png', 'BackgroundColor',[1,1,1]);
 % annotate windows
 img2 = remove_details(img);
 %img2 = imcomplement(img2);
 
 %w_t = wall_thickness(img2)
 h = hough_tr(img2);
 h = imcomplement(h);
 [y0,x0] = find(h);
 
 L = bwlabel(h, 8);
 L2 = L>0;
 L = L(L2);
 L_sort = sort(L);
 
 M = max(L_sort,[],'all')
 A = zeros(M,1);
 for k = 1:length(L_sort)
     A(L_sort(k)) = A(L_sort(k))+1;
 end
 
 A_max = max(A, [], 'all')/15
 

 %imshowpair(img,img2,'montage');
 
 
end

