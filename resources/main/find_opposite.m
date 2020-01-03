function possibleOpposites = find_opposite(centerpoint,normVec,centerpoints, w_t)
%FIND_OPPOSITE Author: Hoertner Filip
%   finds possible opposite wall edges

searchPoint = round(centerpoint+2*w_t*normVec);

centerpoints = round(centerpoints);

F = zeros(2);

for i=20:round(7*w_t)
    
    searchPoint = round(searchPoint+2*normVec);
    
    for j=-round(sqrt(i)):round(sqrt(i))
        for k=-round(sqrt(i)):round(sqrt(i))
            
            if (sum(centerpoints(:, 1) == (searchPoint(1)+j) & centerpoints(:, 2) == (searchPoint(2)+k)) > 0)
                
                if ((searchPoint(1)+j ~= round(centerpoint(1)) || (searchPoint(2)+k) ~= round(centerpoint(2))) && (sum(F(:, 1) == (searchPoint(1)+j) & F(:, 2) == (searchPoint(2)+k)) == 0))
                
                    F(end+1,:) = [searchPoint(1)+j, searchPoint(2)+k];
                
                end
            end
            
        end
    end
    
end
    
possibleOpposites = F(3:end,:);

end

