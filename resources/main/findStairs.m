function [result] = findStairs(img)
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


% create a mask in order to remove walls and other thicker structures
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

% apply a dilate to make mask remove more
dilatedMask = zeros(size(wallMask, 1), size(wallMask, 2));
for i = 5:(size(wallMask, 1) - 4)
    for j = 5:(size(wallMask, 2) - 4)
        if wallMask(i, j) == 1
            dilatedMask((i - 4):(i + 4), (j - 4):(j + 4)) = 1;
        end
    end
end

% apply mask
img3 = img3 | dilatedMask;

% apply erosion to create clusters from the remaining lines
img4 = 255 * (img3);
for i = 13:(size(img3, 1) - 12)
    for j = 13:(size(img3, 2) - 12)
        if img3(i, j) == 0
            img4((i - 12):(i + 12), (j - 12):(j + 12)) = 0;
        end
    end
end

% find the stairs candidates (the biggest clusters)
img4 = img4 / 255;
img5 = zeros(size(img4));
for i = 40:(size(img4, 1) - 39)
    for j = 40:(size(img4, 2) - 39)
        countSum = sum(sum(img4((i - 39):(i + 39), (j - 39):(j + 39))));
        if countSum < 300
            img5((i - 39):(i + 39), (j - 39):(j + 39)) = 1;
        end
    end
end


stairMask = zeros(size(img, 1), size(img, 2));
stairMask(minX:maxX, minY:maxY) = img5;

result = stairMask;
end


