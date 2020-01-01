function size = wall_thickness(bin_img)
%WALL_THICKNESS Author: Hoertner Filip
%   Detects appr. average wall thickness

[M,T,R] = hough(bin_img, 'RhoResolution', 0.5, 'Theta', -90:0.5:89);

imshow(imadjust(rescale(M)), 'XData', T, 'YData', R);

colormap(gca,hot);

size = 7;

end

