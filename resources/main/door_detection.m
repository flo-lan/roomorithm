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
    cornerVertical = zeros(2);
    cornerHorizontal = zeros(2);
    
     if ((abs(cornerDetection1(1,2)-cornerDetection1(2,2))<  w_tc *2 && abs(cornerDetection1(1,2)-cornerDetection1(2,2)) >  w_tc *0.35 )  &&  cornerDetection1(1,1) == cornerDetection1(2,1))
        cornerDetection_filter(end+1,:) = cornerDetection1(1,:);
        cornerVertical(end+1,:) = cornerDetection1(1,:);
    end
    for x = 2:(size(cornerDetection1)-1)
        if (((abs(cornerDetection1(x-1,2)-cornerDetection1(x,2)) < w_tc *2 && abs(cornerDetection1(x-1,2)-cornerDetection1(x,2)) >  w_tc *0.35 )  &&  cornerDetection1(x-1,1) == cornerDetection1(x,1)) || ((abs(cornerDetection1(x,2)-cornerDetection1(x+1,2)) < w_tc *2 && abs(cornerDetection1(x,2)-cornerDetection1(x+1,2)) >  w_tc *0.35 )  &&  cornerDetection1(x+1,1) == cornerDetection1(x,1)))
           cornerDetection_filter(end+1,:) = cornerDetection1(x,:); 
           cornerVertical(end+1,:) = cornerDetection1(x,:);
        end
    end
    if (((abs(cornerDetection1(end,2)-cornerDetection1(end-1,2)) <w_tc *2 && abs(cornerDetection1(end,2)-cornerDetection1(end-1,2)) >  w_tc *0.35 ))  &&  cornerDetection1(end,1) == cornerDetection1(end-1,1)) 
        cornerDetection_filter(end+1,:) = cornerDetection1(end,:);
         cornerVertical(end+1,:) = cornerDetection1(end,:);
    end

    
    if ((abs(cornerDetection2(1,1)-cornerDetection2(2,1))<  w_tc *2 && abs(cornerDetection2(1,1)-cornerDetection2(2,1)) >  w_tc *0.35 ) &&  cornerDetection2(1,2) == cornerDetection2(2,2))
        cornerDetection_filter(end+1,:) = cornerDetection2(1,:);
        cornerHorizontal(end+1,:) = cornerDetection2(1,:);
    end
    for y = 2:(size(cornerDetection2)-1)
        if (((abs(cornerDetection2(y-1,1)-cornerDetection2(y,1)) < w_tc *2 && abs(cornerDetection2(y-1,1)-cornerDetection2(y,1)) >  w_tc *0.35 ) &&  cornerDetection2(y-1,2) == cornerDetection2(y,2)) || ((abs(cornerDetection2(y,1)-cornerDetection2(y+1,1)) < w_tc *2 && abs(cornerDetection2(y,1)-cornerDetection2(y+1,1)) >  w_tc *0.35 ) &&  cornerDetection2(y+1,2) == cornerDetection2(y,2)))
           cornerDetection_filter(end+1,:) = cornerDetection2(y,:); 
           cornerHorizontal(end+1,:) = cornerDetection2(y,:);
        end
    end
    if (((abs(cornerDetection2(end,1)-cornerDetection2(end-1,1)) < w_tc*2) && abs(cornerDetection2(end,1)-cornerDetection2(end-1,1)) >  w_tc *0.35 ) &&  cornerDetection2(end,2) == cornerDetection2(end-1,2)) 
        cornerDetection_filter(end+1,:) = cornerDetection2(end,:);
        cornerHorizontal(end+1,:) = cornerDetection2(end,:);
    end
    
    cornerDetection_filter = cornerDetection_filter(3:end, :)
    cornerVertical = cornerVertical(3:end, :)
    cornerHorizontal = cornerHorizontal(3:end, :)
    
    %plot(cornerDetection_filter(:,1),cornerDetection_filter(:,2),'r*');
    
    centerVertical = zeros(2);
    centerHorizontal = zeros(2);
    
    centerVerticalParent = zeros(2);
    centerHorizontalParent = zeros(2);
    others = zeros(2);
    
    for x = 1: (size(cornerVertical)-1)
        if ((abs(cornerVertical(x,2)-cornerVertical(x+1,2)) <  w_tc *2 && abs(cornerVertical(x,2)-cornerVertical(x+1,2)) >  w_tc *0.35 )  &&  cornerVertical(x,1) == cornerVertical(x+1,1))
            
            centerPoint = round(abs(cornerVertical(x,2)+cornerVertical(x+1,2))/2);
            
            if(bin_img(centerPoint,cornerVertical(x,1)+1)+ bin_img(centerPoint, cornerVertical(x,1)-1)== 1)
                centerVerticalParent(end+1,:) = cornerVertical(x,:);
                centerVerticalParent(end+1,:) = cornerVertical(x+1,:);
                centerVertical(end+1,1) = cornerVertical(x,1); 
                centerVertical(end,2) = centerPoint;
            
            else
                others(end+1,:) = cornerVertical(x,:);
                others(end+1,:) = cornerVertical(x+1,:);
            end
        
        end
    end
    
        for x = 1: (size(cornerHorizontal)-1)
            if ((abs(cornerHorizontal(x,1)-cornerHorizontal(x+1,1)) <  w_tc *2 && abs(cornerHorizontal(x,1)-cornerHorizontal(x+1,1)) >  w_tc *0.35 )  &&  cornerHorizontal(x,2) == cornerHorizontal(x+1,2))
                centerPoint = round(abs(cornerHorizontal(x,1)+cornerHorizontal(x+1,1))/2);
                if(bin_img(cornerHorizontal(x,2)+1,centerPoint) + bin_img( cornerHorizontal(x,2)-1,centerPoint)== 1)
                     centerHorizontalParent(end+1,:) = cornerHorizontal(x,:);
                     centerHorizontalParent(end+1,:) = cornerHorizontal(x+1,:);
                     centerHorizontal(end+1,2) = cornerHorizontal(x,2); 
                     centerHorizontal(end,1) = centerPoint;
            
                else
                    others(end+1,:) = cornerHorizontal(x,:);
                    others(end+1,:) = cornerHorizontal(x+1,:);
                end
        
            end
        end
    
    centerVertical = centerVertical(3:end,:)
    centerHorizontal = centerHorizontal(3:end,:)
    
    centerVerticalParent = centerVerticalParent(3:end,:)
    centerHorizontalParent = centerHorizontalParent(3:end,:)
    others = others(3:end,:);

    
    %%{
    plot(centerVerticalParent(:,1),centerVerticalParent(:,2),'rs');
    plot(centerVertical(:,1),centerVertical(:,2),'rx');
    
    plot(centerHorizontalParent(:,1), centerHorizontalParent(:,2),'bs');
    plot(centerHorizontal(:,1), centerHorizontal(:,2),'bx');
    
    plot(others(:,1),  others(:,2),'mo');
    %}
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