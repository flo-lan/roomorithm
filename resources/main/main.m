function main
 img = imread('img/Datei4.png');
 % annotate windows
 img2 = window_detection(img);
 %imshowpair(img,img2,'montage')
 imshow(img)
 %B = roomdetection(img);
 %imshow(B)
 end