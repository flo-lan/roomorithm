function [result] = findStairs(img, scale)
% returns 1 if the image contains stairs, 0 else
img2 = img;
img2 = img2(:,:,1);

% crop image to remove black border
minX = size(img2, 1);
minY = size(img2, 2);
maxX = 1;
maxY = 1;
for i = 1:size(img2, 1)
    for j = 1:size(img2, 2)
        if img2(i, j) ~= 0
            if i < minX
                minX = i;
            end
            if i > maxX
                maxX = i;
            end
            if j < minY
                minY = j;
            end
            if j > maxY
                maxY = j;
            end
        end
    end
end

img2 = img2(minX:maxX, minY:maxY);

% remove gray areas, create a mask in order to remove walls 
% and other thicker structures
wallMask = zeros(size(img2, 1), size(img2, 2));
img3 = zeros(size(img2, 1), size(img2, 2));
img3(img2 >= 80) = 1;
count = img3;

for i = 2:(size(img2, 1) - 1)
    for j = 2:(size(img2, 2) - 1)
        countSum = sum(sum(count((i - 1):(i + 1), (j - 1):(j + 1))));
        if countSum <= 3
            wallMask((i - 1):(i + 1), (j - 1):(j + 1)) = 1;
        end
    end
end

% apply erosion to make mask remove more
erodedMask = zeros(size(wallMask, 1), size(wallMask, 2));
for i = 5:(size(wallMask, 1) - 4)
    for j = 5:(size(wallMask, 2) - 4)
        if wallMask(i, j) == 1
            erodedMask((i - 4):(i + 4), (j - 4):(j + 4)) = 1;
        end
    end
end

% apply mask
img3 = img3 | erodedMask;

% apply dilation to create clusters from the remaining lines
img4 = 255 * (img3);
dilationGrade = round(scale * 9);
for i = dilationGrade:(size(img3, 1) - (dilationGrade - 1))
    for j = 9:(size(img3, 2) - (dilationGrade - 1))
        if img3(i, j) == 0
            img4((i - (dilationGrade - 1)):(i + (dilationGrade - 1)), (j - (dilationGrade - 1)):(j + (dilationGrade - 1))) = 0;
        end
    end
end

% find the stairs candidates (the biggest clusters)
img4 = img4 / 255;
img5 = zeros(size(img4));

clusterSize = round(scale * 40);
for i = clusterSize:(size(img4, 1) - (clusterSize - 1))
    for j = clusterSize:(size(img4, 2) - (clusterSize - 1))
        countSum = sum(sum(img4((i - (clusterSize - 1)):(i + (clusterSize - 1)),...
            (j - (clusterSize - 1)):(j + (clusterSize - 1)))));
        if countSum < 300
            img5((i - (clusterSize - 1)):(i + (clusterSize - 1)),...
                (j - (clusterSize - 1)):(j + (clusterSize - 1))) = 1;
        end
    end
end

result = max(max(img5));
end


