function w_tc = wall_thiccness(bin_img)
%WALL_THICCNESS Author: Alam Mark
%   Detects appr. average wall thickness

 hx = bin_img;
 hy = bin_img;
 Ax = zeros(size(bin_img));
 Ay = zeros(size(bin_img));
 
 Ax(:,:) = intmax;
 Ay(:,:) = intmax;
 
 
 for hrzntl = 1:size(hx,1)
     for vrtcl = 1:size(hy,2)
         if(hx(hrzntl, vrtcl)==1)
             count = 1;
             h=hrzntl+1;
             
             while(hx(h, vrtcl)==1)
                 count = count+1;
                 hx(h, vrtcl)= 0;
                 h = h+1;
             end
             Ax(hrzntl, vrtcl) = count;
         end
     end
 end
 
  for vrtcl = 1:size(hy,2)
     for hrzntl = 1:size(hx,1)
         if(hy(hrzntl, vrtcl)==1)
             count = 1;
             v=vrtcl+1;
             
             while(hy(hrzntl,v)==1)
                 count = count+1;
                 hy(hrzntl,v)= 0;
                 v = v+1;
             end
             Ay(hrzntl, vrtcl) = count;
         end
     end
  end
 
  Axy = min(Ax,Ay);
  Axy = Axy(Axy~=intmax);
  Axy_new = Axy(Axy<50);
  
  meanOfMatrices = mean(Axy_new, 'all');
  w_tc = meanOfMatrices;
  
end

