function main
 files = dir('./img/*.png');
 file = [];
 windowCount = zeros(size(files));
 doorCount = zeros(size(files));
 roomCount = zeros(size(files));
 stairs = zeros(size(files));
 roomsCells = {};
 for k=1:length(files)
     fileName = join(['./img/*.png' files(k).name]);

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
     roomsCells(k) = {roomResult};
     roomCount(k) = numel(roomResult)/2;
     %%%%%%%%%%%%%%%% MARK %%%%%%%%%%%%%%%
     
     stairs(k) = findStairs(img, w_tc);
 end
 %%%%%%%%%%%%%%%% FLO %%%%%%%%%%%%%%%
  
 result = jsonencode(table(file, windowCount, doorCount, roomCount, stairs))
 rooms = jsonencode(roomsCells)
end