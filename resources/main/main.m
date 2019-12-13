function main
 img = imread('img/Datei4.png');
 % annotate windows
 img2 = remove_details(img);
 imshowpair(img,img2,'montage')
 %imshow(img)
 %B = roomdetection(img);
 %imshow(B)
end
