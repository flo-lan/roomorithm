function [numOfRoom space] = roomdetection(img)
    %WALL_THICKNESS Author: Schimmerl Raphael
    h = imcomplement(img);
    L = connectedComponentLabeling(h);
    L2 = L>0;

     L = L(L2);
     numberOfObjects = max(L,[],'all');
     L = sort(L);
      
    A = zeros(numberOfObjects - 1,1);
    sum = 0;
    
  for k = 1:length(L)
     if (L(k) < numberOfObjects)
     A(L(k)) = A(L(k))+1;
     sum = sum + 1;
     end
  end
    A = sort(A); 
    B = zeros(numberOfObjects - 1,2);
    
    for k = 1:numberOfObjects - 1
     B(k, :) = [round(k) A(k)/sum];
    end
    
    numOfRoom = B;
end
