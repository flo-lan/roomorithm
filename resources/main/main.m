function main
 img = imread('img/Datei3.png', 'BackgroundColor',[1,1,1]);
 % annotate windows
 img2 = remove_details(img);
 %img2 = imcomplement(img2);
 
 w_t = wall_thickness(img2)
 %imshowpair(img,img2,'montage');
 
 
end

