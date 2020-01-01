function H = hough(bin_img)
%HOUGH Author: Hoertner Filip and Raphaello
%   does a hough transformation

%Initializing other parameters
theta = ((-90:90)./180) .* pi;
D = sqrt(size(bin_img,1).^2 + size(bin_img,2).^2);
HS = zeros(ceil(2.*D),numel(theta));
[y,x] = find(bin_img);
y = y - 1;
x = x - 1;
figure;
rho = cell(1,numel(x));

%Calculating the Hough Transform
for i = 1: numel(x)
    rho{i} = x(i).*cos(theta) + y(i).*sin(theta); % [-sqrt(2),sqrt(2)]*D rho interval
    %plot(theta,-rho{i});
    %hold on;
end

%Creating the Hough Space as an Image
for i = 1:numel(x)
    rho{i} = rho{i} + D; % mapping rho from 0 to 2*sqrt(2)
    rho{i} = floor(rho{i}) + 1;
    for j = 1:numel(rho{i})
        HS(rho{i}(j),j) = HS(rho{i}(j),j) + 1; 
    end
end
%figure;
imshow(HS);

H = HS;
end

