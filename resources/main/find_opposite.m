function possibleOpposites = find_opposite(centerpoint,normVec,centerpoints, w_t)
%FIND_OPPOSITE Author: Hoertner Filip
%   finds opposite wall edge

search = centerpoint+w_t*normVec;

F = zeros(2);

for i=w_t:7*w_t
    
    search = search+normVec;
    
    for j=-20:20
        for k=-20:20
            
            if (sum(centerpoints(:, 1) == (search(1)+j) & centerpoints(:, 2) == (search(2)+k))~=0)
                
                F(end+1,:) = [search(1)+j, search(2)+k];
                
            end
            
        end
    end
    
end
    
possibleOpposites = F(3:end,:);

end

