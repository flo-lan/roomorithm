function dda = dda(matrix) 
% Source: https://de.mathworks.com/matlabcentral/fileexchange/62308-matlab-dda-digital-differential-analyzer-algorithm-implementation?focused=7464672&s_tid=gn_loc_drop&tab=function
close all, grid on ,hold on;axis([-5 5 -5 5]);
    dx = abs(matrix(1,1) - matrix(end,1));
    dy = abs(matrix(1,2) - matrix(end,2));
    
    if dx == 0 && dy == 0
        return;
    end
    
    signX = sign(x2-x1);
    signY = sign(y2-y1);
    if dx >= dy
        pixel = dx;
    else
        pixel = dy;
    end
    dx = dx/pixel;
    dy = dy/pixel;
    x = x1;
    y = y1;
    i = 0;
    
    xActual = round(x);
    yActual = round(y);
    
    matrix2 = zeros(matrix(:,1), matrix(:,2));
    while i <= pixel
        % do something with that pixel
        matrix2(xActual,yActual) = 1;
        
        x = x + dx*signX;
        y = y + dy*signY;
        i = i + 1;
        
        xActual = round(x);
        yActual = round(y);
    end
    matrix2 = matrix2(3:end,:);
    dda = matrix2;
end