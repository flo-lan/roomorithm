function output = doordetection(bin_img, w_t)
%DOORDETECTION Author: Hoertner Filip
%   Detects doors

    C = corner(bin_img);
    imshow(bin_img);
    hold on
    plot(C(:,1),C(:,2),'r*');

    C = sortrows(C)
    
    D = zeros(0);
    
    if (abs(C(1,1)-C(2,1))>w_t*0.5 & abs(C(1,1)-C(2,1))<w_t*1.5)
        D = [D,C(1,:)];
    end
    for i = 2:numel(C(1))-1
        if ((abs(C(i,1)-C(i-1,1))>w_t*0.5 & abs(C(i,1)-C(i-1,1))<w_t*1.5) | (abs(C(i,1)-C(i+1,1))>w_t*0.5 & abs(C(i,1)-C(i+1,1))<w_t*1.5))
           D = [D,C(i,:)]; 
        end
    end
    if (abs(C(end,1)-C(end-1,1))>w_t*0.5 & abs(C(end,1)-C(end-1,1))<w_t*1.5)
        D = [D,C(end,:)];
    end
    
    D

end

