function output = doordetection(bin_img, w_t)
%DOORDETECTION Author: Hoertner Filip
%   Detects doors

    C = corner(bin_img);
    imshow(bin_img);
    hold on
    plot(C(:,1),C(:,2),'r*');

    C = sortrows(C)
    
    D = zeros(2);

    if (abs(C(1,1)-C(2,1))<w_t*1.5)
        D(end+1,:) = C(1,:);
    end
    for i = 2:(size(C)-1)
        if ((abs(C(i,1)-C(i-1,1))<w_t*1.5) | (abs(C(i,1)-C(i+1,1))<w_t*1.5))
           D(end+1,:) = C(i,:); 
        end
    end
    if (abs(C(end,1)-C(end-1,1))<w_t*1.5)
        D(end+1,:) = C(end,:);
    end
    D = D(3:end, :);
    
    D

end

