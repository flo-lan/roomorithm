function main
 img = imread('img/Datei4.png', 'BackgroundColor',[1,1,1]);
 % annotate windows
 img2 = remove_details(img);
 %img2 = imcomplement(img2);
 
 w_t = wall_thickness(img2)
 imshowpair(img,img2,'montage');
 
 sz = size(img2);
 doors = 0;
 countb = 0;
 for i= 1:sz(1)
    for j = 1:sz(2)
    
    if(img2(i,j) == 0)
        countb = countb + 1;
    end
    
    if(img2(i,j) == 1 && countb > 0)
     if(countb > w_t*2 && countb < w_t*5)
         doors = doors + 1;
     end
     countb = 0;
    end
    
    end
    countb = 0;
 end
 doors

 
end