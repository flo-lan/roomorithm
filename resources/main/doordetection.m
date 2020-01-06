function [door_count,bin_img] = doordetection(bin_img, w_t)
%DOORDETECTION Author: Hoertner Filip
%   Detects doors

    door_count=0;

    C = corner_detection(bin_img);
    %imshow(bin_img);
    hold on
    %plot(C(:,1),C(:,2),'r*');

    C = sortrows(C);
    
    D = zeros(2);

    if (abs(C(1,1)-C(2,1)) < w_t*1.5)
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
    I = zeros(2);
    J = zeros(2);
    
    for i = 1:size(D)-1
        for j = 1:size(D)
            if(sqrt((D(i, 1)-D(j,1))^2 + (D(i,2)-D(j, 2))^2) > w_t*0.003 && sqrt((D(i, 1)-D(j,1))^2 + (D(i,2)-D(j, 2))^2) < w_t*2)
              %if((ismember(D(i, :), E)) == 0)
                  line = [D(i,1)-D(j,1) D(i,2)-D(j,2)];
                  normal1 = [line(2) -line(1)];
                  normal1 = normal1./norm(normal1);
                  normal2 = [-line(2) line(1)];
                  normal2 = normal2./norm(normal2);
                  center = (D(i, :) + D(j, :))./2;
                  search1 = round(center+3.*normal1);
                  search2 = round(center+3.*normal2);
                  
                  % to the sides of search 1/2
                  search1_1 = round(search1+0.75*line);
                  search1_2 = round(search1-0.75*line);
                  search2_1 = round(search2+0.75*line);
                  search2_2 = round(search2-0.75*line);
                  
                  if (bin_img(search1(2), search1(1))==0 && bin_img(search2(2), search2(1))==1 && bin_img(search2_1(2), search2_1(1))==0 && bin_img(search2_2(2), search2_2(1))==0)
       
                      
                      E(end+1,:) = D(i,:);
                      E(end+1,:) = D(j,:);
                      F(end+1,:) = round(center);
                      G(end+1,:) = search1;
                      I(end+1,:) = normal1;
                      J(end+1,:) = search2_1;
                      J(end+1,:) = search2_2;
                      
                      
                      H = find_opposite(round(center), normal1, F, w_t);
                      
                      for k=1:numel(H(:,1))
                          normal_op = [0 0];
                          
                          for l=1:numel(F(:,1))
                              if (F(l,:)==H(k,:))
                                  normal_op = I(l,:);
                              end
                          end
                          
                          fo = find_opposite(H(k,:),normal_op, round(center), w_t);
                      
                          if (sum(fo(:, 1) == round(center(1)) & fo(:, 2) == round(center(2))) >0)
                              
                              door_count = door_count+1;
                              center;
                              H(k,:);
                              
                              bin_img = dda(bin_img, round(center(1)), round(center(2)), H(k,1), H(k,2));
                              
                              break;
                          end
                          
                      end
                     
                  
                  elseif (bin_img(search1(2), search1(1))==1 && bin_img(search2(2), search2(1))==0 && bin_img(search1_1(2), search1_1(1))==0 && bin_img(search1_2(2), search1_2(1))==0)
                          
                      E(end+1,:) = D(i,:);
                      E(end+1,:) = D(j,:);
                      F(end+1,:) = round(center);
                      
                      G(end+1,:) = search2;
                      I(end+1,:) = normal2;
                      J(end+1,:) = search1_1;
                      J(end+1,:) = search1_2;
                      
                      
                      H = find_opposite(round(center), normal2, F, w_t);
                      
                      for k=1:numel(H(:,1))
                          normal_op = [0 0];
                          
                          for l=1:numel(F(:,1))
                              if (F(l,:)==H(k,:))
                                  normal_op = I(l,:);
                              end
                          end
                          
                          fo = find_opposite(H(k,:),normal_op, round(center), w_t);
                           
                          if (sum(fo(:, 1) == round(center(1)) & fo(:, 2) == round(center(2)))>0)
                              
                              door_count = door_count+1;
                              center;
                              H(k,:);
                              
                              bin_img = dda(bin_img, round(center(1)), round(center(2)), H(k,1), H(k,2));
                              
                              break;
                          end
                      end
                           
                      
                  end
              %end       
            end
        end
    end
    
    E = E(3:end, :);
    F = F(3:end, :);
    G = G(3:end, :);
    J = J(3:end, :);
    plot(E(:,1),E(:,2),'r*');
    plot(F(:,1),F(:,2),'g*');
    plot(G(:,1),G(:,2),'b*');
    plot(J(:,1),J(:,2),'y*');
   
    
    

end
