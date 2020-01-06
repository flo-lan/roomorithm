function main
 files = dir('./img/*.png');
 file = [];
 windowCount = zeros(size(files));
 doorCount = zeros(size(files));
 roomCount = zeros(size(files));
 for k=1:length(files)
     fileName = join(['./img/' files(k).name]);

     img = imread(fileName, 'BackgroundColor',[1,1,1]);
     file = [file; fileName];
     % annotate windows
     img2 = remove_details(img);
     %img2 = imcomplement(img2);

     %w_t = wall_thickness(img2)

     %%%%%%%%%%%%%%%% MARK %%%%%%%%%%%%%%%
     w_tc = wall_thiccness(img2);
     %%%%%%%%%%%%%%%% MARK %%%%%%%%%%%%%%%

     %imshowpair(img,img2,'montage');
     windowCountResult = windowdetection(img, w_tc);
     windowCount(k) = windowCountResult;

     [doorCountResult,img3] = doordetection(img2, w_tc);
     doorCount(k) = doorCountResult;
     %{
     doorCount
     figure;
     imshow(img3);
     %}
     %%%%%%%%%%%%%%%% MARK %%%%%%%%%%%%%%%

     %[doorCount,img_3] = door_detection(img2, w_tc);

     figure;
     imshow(img3);

     rooms = roomdetection(img3)
     roomCount(k) = numel(rooms)/2;
     %%%%%%%%%%%%%%%% MARK %%%%%%%%%%%%%%%
     stairs = findStairs(img, w_tc);
 end
 jsonencode(table(file, windowCount, doorCount, roomCount, stairs))
end