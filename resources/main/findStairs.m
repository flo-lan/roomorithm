function [result] = findStairs(img)
img = imread('img/Datei0.png');
img2 = img;
img2 = img2(:,:,1);

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

% imshow(wallMask);
dilatedMask = zeros(size(wallMask, 1), size(wallMask, 2));
for i = 5:(size(wallMask, 1) - 4)
    for j = 5:(size(wallMask, 2) - 4)
        if wallMask(i, j) == 1
            dilatedMask((i - 4):(i + 4), (j - 4):(j + 4)) = 1;
        end
    end
end

img3 = img3 | dilatedMask;

img3 = img3(400:700, 750:900);
% img4 = hough(img3);
% maximum = max(max(img4));
% img4 = img4 / maximum;
% img4(img4 < 0.89) = 0;
% img4(img4 > 0.9) = 0;
% imshow(img4);

limit = 60;
% img3 = [1, 1, 1, 1, 1, 1, 1;
%         1, 0, 1, 1, 1, 1, 1;
%         1, 0, 0, 1, 1, 1, 1;
%         1, 1, 0, 0, 1, 1, 1;
%         1, 1, 1, 0, 1, 1, 1;
%         1, 1, 1, 1, 0, 1, 1;
%         1, 1, 1, 1, 1, 0, 1;
%         1, 1, 1, 1, 1, 0, 1;
%         1, 1, 1, 1, 1, 1, 1];
     
lines = startLines(img3, limit)

% img4 = 255 * repmat(uint8(img3), 1, 1, 3);
% img4(45:53, 11:19, 1) = 80;
% img4(45:53, 11:19, 2) = 180;
% img4(45:53, 11:19, 3) = 110;
% img4(45:53, 88:94, 1) = 80;
% img4(45:53, 88:94, 2) = 180;
% img4(256:264, 99:105, 3) = 110;
% imshow(img4);

end
function [result] = startLines(img, limit)

imgsize = size(img);
visited = zeros(imgsize);
lines = [];
count = 0;
for i = 2:imgsize(1) - 1
    for j = 2:imgsize(2) - 1
        if visited(i, j) == 0 && img(i, j) == 0
           count = count + 1
           start = [i, j];
           [lastX, lastY, visited] = findLines(limit, visited, img, start,...
               start, start, start, pi / 4, true, [start; start; start]);
           last = [lastX, lastY];
           distance = euclidean(start, last);
           if distance ~= 0 && distance <= limit && distance >= limit / 2
             lines = cat(1, lines, [start, last]);   
           end
          imshow(visited);
        end
    end
end
result = lines;
end

function [lastX, lastY, visited] = findLines(limit, visited, img, start,...
    last, current, previous, deviation, valid, steps)
lastX = last(1);
lastY = last(2);
if valid && (current(1) > 1 && current(1) < size(img, 1) && current(2) > 1 ...
  && current(2) < size(img, 2) && (euclidean(current, last) < 5))
        x1 = current(1) - previous(1);
        y1 = current(2) - previous(2);
        if steps(1, 1) == steps(2, 1) && steps(1, 2) == steps(2, 2)
        x2 = (previous(1) - start(1));
        y2 = (previous(2) - start(2));
        else
            x2 = (previous(1) - steps(1, 2));
            y2 = (previous(2) - steps(2, 2));
        end
        dotProd = x1 * x2 + y1 * y2;
        length1 = sqrt(x1^2 + y1^2);
        length2 = sqrt(x2^2 + y2^2);
        if (current(1) == previous(1) && current(2) == previous(2))...
                || (previous(1) == start(1) && previous(2) == start(2))
            angle = 0;
        elseif dotProd == 0
            angle = pi / 2;
        else
            angle = acos(dotProd / (length1 * length2));
        end
%             previous
%             last
%             current
%             angle
%             deviation
%   
%     angle
%     deviation
% %     distance1
%     distance2
%     current
%     previous
%     last
%   
    if abs(angle) <= deviation
            if img(current(1), current(2)) == 0
                visited(current(1), current(2)) = 1;
                last = current;
            end
            
        [lastX1, lastY1, visited1] = findLines(limit, visited, img, start, last,...
            [current(1) - 1, current(2) - 1], current, deviation,...
            (current(1) - 1 ~= previous(1) || current(2) - 1 ~= previous(2)),...
            [steps(2,:); steps(3,:); current]);
        visited = visited | visited1;
        [lastX2, lastY2, visited2] = findLines(limit, visited, img, start, last,...
             [current(1) - 1, current(2)], current, deviation,...
             (current(1) - 1 ~= previous(1) || current(2) ~= previous(2)),...
             [steps(2,:); steps(3,:); current]);
        visited = visited | visited2;
        [lastX3, lastY3, visited3] = findLines(limit, visited, img, start, last,...
             [current(1) - 1, current(2) + 1], current, deviation,...
             (current(1) - 1 ~= previous(1) || current(2) + 1 ~= previous(2)),...
             [steps(2,:); steps(3,:); current]);
        visited = visited | visited3;
        [lastX4, lastY4, visited4] = findLines(limit, visited, img, start, last,...
             [current(1), current(2) - 1], current, deviation,...
             (current(1) ~= previous(1) || current(2) - 1 ~= previous(2)),...
             [steps(2,:); steps(3,:); current]);
        visited = visited | visited4;
        [lastX5, lastY5, visited5] = findLines(limit, visited, img, start, last,...
              [current(1), current(2) + 1], current, deviation,...
              (current(1) ~= previous(1) || current(2) + 1 ~= previous(2)),...
              [steps(2,:); steps(3,:); current]);
        visited = visited | visited5;
        [lastX6, lastY6, visited6] = findLines(limit, visited, img, start, last,...
              [current(1) + 1, current(2) - 1], current, deviation,...
              (current(1) + 1 ~= previous(1) || current(2) - 1 ~= previous(2)),...
              [steps(2,:); steps(3,:); current]);
        visited = visited | visited6;
        [lastX7, lastY7, visited7] = findLines(limit, visited, img, start, last,...
              [current(1) + 1, current(2)], current, deviation,...
              (current(1) + 1 ~= previous(1) || current(2) ~= previous(2)),...
              [steps(2,:); steps(3,:); current]);
        visited = visited | visited7;
        [lastX8, lastY8, visited8] = findLines(limit, visited, img, start, last,...
               [current(1) + 1, current(2) + 1], current, deviation,...
               (current(1) + 1 ~= previous(1) || current(2) + 1 ~= previous(2)),...
               [steps(2,:); steps(3,:); current]);
        visited = visited | visited8;
        
        endX = [lastX1, lastX2, lastX3, lastX4, lastX5, lastX6, lastX7, lastX8];
        endY = [lastY1, lastY2, lastY3, lastY4, lastY5, lastY6, lastY7, lastY8];
        distances = [euclidean([lastX1 lastY1], start), euclidean([lastX2 lastY2], start),...
                    euclidean([lastX3 lastY3], start), euclidean([lastX4 lastY4], start),...
                    euclidean([lastX5 lastY5], start), euclidean([lastX6 lastY6], start),...
                    euclidean([lastX7 lastY7], start), euclidean([lastX8 lastY8], start)];
        [longest, index] = max(distances);
            lastX = endX(index);
            lastY = endY(index);
    end
end
end


function [result] = euclidean(point1, point2)
result = abs(sqrt((point1(1) - point2(1))^2 + (point1(2) - point2(2))^2));
end
