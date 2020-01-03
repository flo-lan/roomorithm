function possibleOpposites = find_opposite(centerpoint,normVec,centerpoints)
%FIND_OPPOSITE Author: Hoertner Filip
%   finds opposite wall edge

searchStart = centerpoint;

F = zeros(2);

for i=1:7
    
    searchStart = searchStart+normVec;
    
    for j=-10:10
        for k=-10:10
            
            if (contains(centerpoints, [searchStart(1)+j, searchStart(2)+k]))
                
                F(end+1,:) = [searchStart(1)+j, searchStart(2)+k];
                
            end
            
        end
    end
    
end
    


end

