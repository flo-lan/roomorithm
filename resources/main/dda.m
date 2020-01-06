function res_mat = dda(matrix, x1, y1, x2, y2)
%DDA Author: Alam Mark
%   Draws Lines
% Source: https://de.mathworks.com/matlabcentral/fileexchange/62308-matlab-dda-digital-differential-analyzer-algorithm-implementation?focused=7464672&s_tid=gn_loc_drop&tab=function
%close all, grid on ,hold on;axis([-5 5 -5 5]);
    dx = abs(x2 - x1);
    dy = abs(y2 - y1);
    
    if dx == 0 && dy == 0
        res_mat = matrix;
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
    
    while i <= pixel
        % do something with that pixel
        matrix(yActual,xActual) = 0.5;
        
        x = x + dx*signX;
        y = y + dy*signY;
        i = i + 1;
        
        xActual = round(x);
        yActual = round(y);
    end
    res_mat = matrix;
end