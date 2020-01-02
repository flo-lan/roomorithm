function output = doordetection(bin_img)
%DOORDETECTION Author: Hoertner Filip
%   Detects doors

   
    C = corner(bin_img);
    imshow(bin_img)
    hold on
    plot(C(:,1),C(:,2),'r*');


end

