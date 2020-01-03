function output = doordetection(bin_img, w_t)
%DOORDETECTION Author: Hoertner Filip
%   Detects doors

    C = corner(bin_img)
    imshow(bin_img);
    bi_img = bin_img;
    hold on
    %plot(C(:,1),C(:,2),'r*');

    C = sortrows(C)
    T = zeros(2);
      for i = 1:size(C)
        if(bi_img(C(i,1), C(i,2))==0)
                T(end+1,:) = C(i,:);
        end
      end
    T = T(3:end, :)
    D = zeros(2);

    if (abs(T(1,1)-T(2,1))<w_t*1.5)
        D(end+1,:) = T(1,:);
    end
    for i = 2:(size(T)-1)
        if ((abs(T(i,1)-T(i-1,1))<w_t*1.5) | (abs(T(i,1)-T(i+1,1))<w_t*1.5))
           D(end+1,:) = T(i,:); 
        end
    end
    if (abs(T(end,1)-T(end-1,1))<w_t*1.5)
        D(end+1,:) = T(end,:);
    end
    D = D(3:end, :)
    
    %plot(D(:,1),D(:,2),'r*');
    
    E = zeros(2);
    F = zeros(2);
    
    for i = 1:size(D)-1
        for j = 1:size(D)
            if(sqrt((D(i, 1)-D(j,1))^2 + (D(i,2)-D(j, 2))^2) > w_t*0.3 && sqrt((D(i, 1)-D(j,1))^2 + (D(i,2)-D(j, 2))^2) < w_t*2)
              %if((ismember(D(i, :), E)) == 0)
                  vec = [D(i,:) D(j,:)];
                  normal = norm(vec);
                  center = (D(i, :) + D(j, :)).'/2;
                  %if (bin_img(round(center(1)), round(center(2))) == 1)
                  
                  
                  E(end+1,:) = D(i,:);
                  E(end+1,:) = D(j,:);
                  F(end+1,:) = center;
                       
                 % end
              %end       
            end
        end
    end
    
    E = E(3:end, :)
    F = F(3:end, :)
    plot(E(:,1),E(:,2),'r*');
    plot(F(:,1),F(:,2),'g*');
   
    
    

end

