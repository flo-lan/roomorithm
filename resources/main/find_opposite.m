function possibleOpposites = find_opposite(centerpoint,normVec,centerpoints, w_t)
%FIND_OPPOSITE Author: Hoertner Filip
%   finds opposite wall edge

searchPoint = round(centerpoint+w_t*normVec);

centerpoints = round(centerpoints);

F = zeros(2);

for i=w_t:7*w_t
    
    searchPoint = round(searchPoint+normVec);
    
    for j=-20:20
        for k=-20:20
            
            if (sum(centerpoints(:, 1) == (searchPoint(1)+j) & centerpoints(:, 2) == (searchPoint(2)+k)) > 0)
                
                F(end+1,:) = [searchPoint(1)+j, searchPoint(2)+k];
                
            end
            
        end
    end
    
end
    
possibleOpposites = F(3:end,:);

end

