function output = doordetection(bin_img, w_t)
%DOORDETECTION Author: Hoertner Filip
%   Detects doors

    C = corner(bin_img);
    imshow(bin_img);
    hold on
    

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
    
    
    E = zeros(2);
    
    for i = 1:size(D)-1
        for j = 1:size(D)
            if(sqrt((D(i, 1)-D(j,1))^2 - (D(i,2)-D(j, 2))^2) > w_t*0.05 && sqrt((D(i, 1)-D(j,1))^2 - (D(i,2)-D(j, 2))^2) < w_t*2)
                E(end+1,:) = D(i,:);
                break 
            end
        end
    end
    
    E
    E = E(3:end, :)
    plot(E(:,1),E(:,2),'r*');
   
    
    

end

