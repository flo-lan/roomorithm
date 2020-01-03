function main
 img = imread('img/Datei4.png', 'BackgroundColor',[1,1,1]);
 % annotate windows
 img2 = remove_details(img);
 %img2 = imcomplement(img2);
 
 w_t = wall_thickness(img2)
 %imshowpair(img,img2,'montage');
 
 [door_count,img3] = doordetection(img2, w_t);
 
 door_count
 figure;
 imshow(img3);



end