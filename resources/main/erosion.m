function erodedImg = erosion(img, se)
% Author: Florian Langeder
    erodedImg = zeros(size(img));
    centerY = ceil(size(se, 1) / 2);
    centerX = ceil(size(se, 2) / 2);
    for y = centerY:size(img,1) - centerY - 1
        for x = centerX:size(img,2) - centerX - 1
            breakFlag = 0;
            for sy = 1:size(se,1)
                for sx = 1:size(se,2)
                     if (se(sy,sx) == 1 && img(y + sy - 1 - centerY + 1, x + sx - 1 - centerX + 1) == 0)
                        breakFlag = 1;
                        break;
                     end
                end
                if (breakFlag == 1)
                    break
                end
            end
            if (breakFlag == 0)
                erodedImg(y,x) = 1;
            end
        end
    end
end