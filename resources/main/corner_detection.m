function cornerDetection = corner_detection(bin_img)
%DOORDETECTION Author: Alam Mark
%   Detects corners

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
    
    cornerDetection = cornerDetection(3:end,:);
end