function main
 file = [];
 windowCount = [];
 doorCount = [];
 roomCount = [];
 fileName = "img/Datei3.png";
 img = imread(fileName, 'BackgroundColor',[1,1,1]);
 file = [file, fileName];
 % annotate windows
 img2 = remove_details(img);
 %img2 = imcomplement(img2);
 
 %w_t = wall_thickness(img2)
 
 %%%%%%%%%%%%%%%% MARK %%%%%%%%%%%%%%%
 w_tc = wall_thiccness(img2)
 %%%%%%%%%%%%%%%% MARK %%%%%%%%%%%%%%%
  
 %imshowpair(img,img2,'montage');
 windowCountResult = windowdetection(img, w_tc);
 windowCount = [windowCount, windowCountResult];
 
 [doorCountResult,img3] = doordetection(img2, w_tc);
 doorCount = [doorCount, doorCountResult];
 %{
 doorCount
 figure;
 imshow(img3);
 %}
 %%%%%%%%%%%%%%%% MARK %%%%%%%%%%%%%%%
 
 %[doorCount,img_3] = door_detection(img2, w_tc);

 figure;
 imshow(img3);
 
 rooms = roomdetection(img3);
 roomCount = [roomCount, numel(rooms)/2];
 %%%%%%%%%%%%%%%% MARK %%%%%%%%%%%%%%%
 jsonencode(table(file, windowCount, doorCount, roomCount))
end