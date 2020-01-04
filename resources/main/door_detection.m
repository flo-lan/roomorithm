function [door_count,bin_img] = door_detection(bin_img, w_tc)
%DOORDETECTION Author: Hoertner Filip
%   Detects doors
    door_count=0;
    cornerDetection = corner_detection(bin_img);
    
    imshow(bin_img)
    hold on
    %plot(cornerDetection(:,1),cornerDetection(:,2),'r*');

    cornerDetection1 = sortrows(cornerDetection);
    cornerDetection2 = sortrows(cornerDetection,2);
   
    
    cornerDetection_filter = zeros(2);
    
     if ((abs(cornerDetection1(1,2)-cornerDetection1(2,2))<  w_tc *2 && abs(cornerDetection1(1,2)-cornerDetection1(2,2)) >  w_tc *0.35 )  &&  cornerDetection1(1,1) == cornerDetection1(2,1))
        cornerDetection_filter(end+1,:) = cornerDetection1(1,:);
    end
    for x = 2:(size(cornerDetection1)-1)
        if (((abs(cornerDetection1(x-1,2)-cornerDetection1(x,2)) < w_tc *2 && abs(cornerDetection1(x-1,2)-cornerDetection1(x,2)) >  w_tc *0.35 )  &&  cornerDetection1(x-1,1) == cornerDetection1(x,1)) || ((abs(cornerDetection1(x,2)-cornerDetection1(x+1,2)) < w_tc *2 && abs(cornerDetection1(x,2)-cornerDetection1(x+1,2)) >  w_tc *0.35 )  &&  cornerDetection1(x+1,1) == cornerDetection1(x,1)))
           cornerDetection_filter(end+1,:) = cornerDetection1(x,:); 
        end
    end
    if (((abs(cornerDetection1(end,2)-cornerDetection1(end-1,2)) <w_tc *2 && abs(cornerDetection1(end,2)-cornerDetection1(end-1,2)) >  w_tc *0.35 ))  &&  cornerDetection1(end,1) == cornerDetection1(end-1,1)) 
        cornerDetection_filter(end+1,:) = cornerDetection1(end,:);
    end

    
    if ((abs(cornerDetection2(1,1)-cornerDetection2(2,1))<  w_tc *2 && abs(cornerDetection2(1,1)-cornerDetection2(2,1)) >  w_tc *0.35 ) &&  cornerDetection2(1,2) == cornerDetection2(2,2))
        cornerDetection_filter(end+1,:) = cornerDetection(1,:);
    end
    for x = 2:(size(cornerDetection2)-1)
        if (((abs(cornerDetection2(x-1,1)-cornerDetection2(x,1)) < w_tc *2 && abs(cornerDetection2(x-1,1)-cornerDetection2(x,1)) >  w_tc *0.35 ) &&  cornerDetection2(x-1,2) == cornerDetection2(x,2)) || ((abs(cornerDetection2(x,1)-cornerDetection2(x+1,1)) < w_tc *2 && abs(cornerDetection2(x,1)-cornerDetection2(x+1,1)) >  w_tc *0.35 ) &&  cornerDetection2(x+1,2) == cornerDetection2(x,2)))
           cornerDetection_filter(end+1,:) = cornerDetection2(x,:); 
        end
    end
    if (((abs(cornerDetection2(end,1)-cornerDetection2(end-1,1)) < w_tc*2) && abs(cornerDetection2(end,1)-cornerDetection2(end-1,1)) >  w_tc *0.35 ) &&  cornerDetection2(end,2) == cornerDetection2(end-1,2)) 
        cornerDetection_filter(end+1,:) = cornerDetection2(end,:);
    end
    cornerDetection_filter = cornerDetection_filter(3:end, :)
    
    plot(cornerDetection_filter(:,1),cornerDetection_filter(:,2),'r*');
    
    center = zeros(2);
    
end

function cornerDetection = corner_detection(bin_img)
%DOORDETECTION Author: Hoertner Filip
%   Detects doors

    cornerDetection = zeros(2);
    
    for x = 1:size(bin_img,1)
        for y = 1:size(bin_img,2)
            if(bin_img(x,y)==1)
                if(xor(   bin_img(x-1,y)==1  , bin_img(x+1,y)==1  ) && xor( bin_img(x,y-1)==1  ,  bin_img(x,y+1)==1 ))
                    cornerDetection(end+1,1) = y;
                    cornerDetection(end, 2) = x;
                end
            end
        end
    end
    
    cornerDetection = cornerDetection(3:end,:)
end