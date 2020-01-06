function main
 files = dir('./resources/main/img/Datei0*.png');
 file = [];
 windowCount = zeros(size(files));
 doorCount = zeros(size(files));
 roomCount = zeros(size(files));
 stairs = zeros(size(files));
 rooms = [];
 for k=1:length(files)
     fileName = join(['./resources/main/img/' files(k).name]);

     img = imread(fileName, 'BackgroundColor',[1,1,1]);
     file = [file; fileName];
     % annotate windows
     %%%%%%%%%%%%%%%% FLO %%%%%%%%%%%%%%%
     img2 = remove_details(img);

     %%%%%%%%%%%%%%%% MARK %%%%%%%%%%%%%%%
     w_tc = wall_thiccness(img2);
     %%%%%%%%%%%%%%%% MARK %%%%%%%%%%%%%%%

     %%%%%%%%%%%%%%%% FLO %%%%%%%%%%%%%%%
     windowCountResult = windowdetection(img, w_tc);
     windowCount(k) = windowCountResult;

     [doorCountResult,img3] = doordetection(img2, w_tc);
     doorCount(k) = doorCountResult;
     
     %%%%%%%%%%%%%%%% MARK %%%%%%%%%%%%%%%
     roomResult = roomdetection(img3);
     rooms = [rooms, jsonencode(roomResult)];
    
     roomCount(k) = numel(roomResult)/2;
     %%%%%%%%%%%%%%%% MARK %%%%%%%%%%%%%%%
     stairs = findStairs(img, w_tc);
 end
 
 %%%%%%%%%%%%%%%% FLO %%%%%%%%%%%%%%%
 jsonencode(table(file, windowCount, doorCount, rooms, roomCount, stairs))
end