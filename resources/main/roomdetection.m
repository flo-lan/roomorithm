function [numOfRooms] = roomdetection(img)
    %WALL_THICKNESS Author: Schimmerl Raphael
    h = imcomplement(img);
    L = connectedComponentLabeling(h);
    L2 = L>0;

     L = L(L2);
     numberOfObjects = max(L,[],'all');

      A = zeros(M,1);


    
    
    numOfRooms = numberOfObjects - 1;
end
