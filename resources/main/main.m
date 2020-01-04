function main
 img = imread('img/Datei0.png', 'BackgroundColor',[1,1,1]);
 % annotate windows
 img2 = remove_details(img);
 %img2 = imcomplement(img2);
 
 w_t = wall_thickness(img2)
 
 %%%%%%%%%%%%%%%% MARK %%%%%%%%%%%%%%%
 w_tc = wall_thiccness(img2)
 %%%%%%%%%%%%%%%% MARK %%%%%%%%%%%%%%%
  
 %imshowpair(img,img2,'montage');
 
 %[door_count,img3] = doordetection(img2, w_t);
 
 %door_count;
 %figure;
 %imshow(img3);
 
 %%%%%%%%%%%%%%%% MARK %%%%%%%%%%%%%%%
 [door_count,img_3] = door_detection(img2, w_tc);

 door_count;
 figure;
 imshow(img_3);
 %%%%%%%%%%%%%%%% MARK %%%%%%%%%%%%%%%
 

end