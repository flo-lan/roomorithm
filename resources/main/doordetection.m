function output = doordetection(bin_img, w_t)
%DOORDETECTION Author: Hoertner Filip
%   Detects doors

    C = corner(bin_img);
    imshow(bin_img);
    hold on
    %plot(C(:,1),C(:,2),'r*');

    C = sortrows(C);
    
    D = zeros(2);

    if (abs(C(1,1)-C(2,1))<w_t*1.5)
        D(end+1,:) = C(1,:);
    end
    for i = 2:(size(C)-1)
        if ((abs(C(i,1)-C(i-1,1))<w_t*1.5) | (abs(C(i,1)-C(i+1,1))<w_t*1.5))
           D(end+1,:) = C(i,:); 
        end
    end
    if (abs(C(end,1)-C(end-1,1))<w_t*1.5)
        D(end+1,:) = C(end,:);
    end
    D = D(3:end, :);
    
    %plot(D(:,1),D(:,2),'r*');
    
    E = zeros(2);
    F = zeros(2);
    G = zeros(2);
    
    for i = 1:size(D)-1
        for j = 1:size(D)
            if(sqrt((D(i, 1)-D(j,1))^2 + (D(i,2)-D(j, 2))^2) > w_t*0.003 && sqrt((D(i, 1)-D(j,1))^2 + (D(i,2)-D(j, 2))^2) < w_t*2)
              %if((ismember(D(i, :), E)) == 0)
                  line = [D(i,1)-D(j,1); D(i,2)-D(j,2)];
                  normal1 = [line(2); -line(1)];
                  normal1 = normal1./norm(normal1);
                  normal2 = [-line(2); line(1)];
                  normal2 = normal2./norm(normal2);
                  center = (D(i, :) + D(j, :)).'/2;
                  search1 = round(center+3.*normal1);
                  search2 = round(center+3.*normal2);
                  if (bin_img(search1(2), search1(1))==0 && bin_img(search2(2), search2(1))==1)
       
                      
                      E(end+1,:) = D(i,:);
                      E(end+1,:) = D(j,:);
                      F(end+1,:) = center;
                      G(end+1,:) = search1;
                      G(end+1,:) = search2;
                      
                      
                     
                  
                  elseif (bin_img(search1(2), search1(1))==1 && bin_img(search2(2), search2(1))==0)
                          
                      E(end+1,:) = D(i,:);
                      E(end+1,:) = D(j,:);
                      F(end+1,:) = center;
                      G(end+1,:) = search1;
                      G(end+1,:) = search2;
                            
                  end
              %end       
            end
        end
    end
    
    E = E(3:end, :);
    F = F(3:end, :);
    G = G(3:end, :);
    plot(E(:,1),E(:,2),'r*');
    plot(F(:,1),F(:,2),'g*');
    plot(G(:,1),G(:,2),'b*');
   
    
    

end

