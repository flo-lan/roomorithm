function possibleOpposites = find_opposite(centerpoint,normVec,centerpoints, w_t)
%FIND_OPPOSITE Author: Hoertner Filip
%   finds opposite wall edge

searchStart = centerpoint;

F = zeros(2);

for i=1:7
    
    searchStart = searchStart+w_t*normVec;
    
    for j=-10:10
        for k=-10:10
            
            if ((find(ismember([searchStart(1)+j, searchStart(2)+k], centerpoints))==1)~=0)
                
                F(end+1,:) = [searchStart(1)+j, searchStart(2)+k];
                
            end
            
        end
    end
    
end
    
possibleOpposites = F;

end

