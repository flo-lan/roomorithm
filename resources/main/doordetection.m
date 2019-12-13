function output = doordetection()
%DOORDETECTION Summary of this function goes here
%   Detailed explanation goes here

%Read an Image A(Template)
A1 = imread('img/Datei1.png');

%Read the Target Image
B1 = imread('img/door1.png');

A = A1(:,:,1);
B = B1(:,:,1);

corr_map = zeros([size(A,1),size(A,2)]);

for i = 1:size(A,1)-size(B,1)
    for j = 1:size(A,2)-size(B,2)
        %Construct the correlation map
        corr_map(i,j) = corr2(A(i:i+size(B,1)-1,j:j+size(B,2)-1),B);
    end
end

figure,imagesc(corr_map);
colorbar;
%Find the maximum value
maxpt = max(corr_map(:));
[x,y]=find(corr_map==maxpt);

%Display the image from the template
figure,imagesc(B1);title('Target Image');colormap(gray);axis image

grayA = rgb2gray(A1);
Res   = A;
Res(:,:,1)=grayA;
Res(:,:,2)=grayA;
Res(:,:,3)=grayA;

Res(x:x+size(B,1)-1,y:y+size(B,2)-1,:)=A1(x:x+size(B,1)-1,y:y+size(B,2)-1,:);

figure,imagesc(Res);


end

