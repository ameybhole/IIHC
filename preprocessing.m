function [RGB, RGB1, im4, im8] = preprocessing(t, R, R1)
% Convert to gray scale
T = rgb2gray(t);
T1 = imresize(T,[361 488]);
% figure, imagesc(T1);
R1 = imcrop(R1,[47 53 487 360]);
% figure, imagesc(R1)

% Thresholding 320*240
[r,c] = size(T);
im = zeros(r,c);
 for i = 1:r
     for j = 1:c
         if T(i,j) > 200
             im(i,j) = 1;
%          else
%              im(i,j) = 0;
         end
     end
 end
im = bwareaopen(im,60);
im = imclearborder(im,8);
im = imfill(im,'holes');

% Thresholding 640*480
[r1,c1] = size(T1);
im5 = zeros(r1,c1);
 for i = 1:r1
     for j = 1:c1
         if T1(i,j) > 200
             im5(i,j) = 1;
%          else
%              im(i,j) = 0;
         end
     end
 end
im5 = bwareaopen(im5,60);
im5 = imclearborder(im5,8);
im5 = imfill(im5,'holes');


% Close and extract maximum area 320*240
BWsdil = imclose(imclose(im,strel('line',18,0)),strel('line',18,90));
% figure, imshow(BWsdil);
reg = regionprops(BWsdil);
bw = bwlabel(BWsdil);
% figure, imagesc(bw);
[mx,mxind] = max([reg.Area]);
B = double(bw == mxind);
B(B == 0) = -1;
% figure,imshow(B);

% Close and extract maximum area 640*480
BWsdil1 = imclose(imclose(im5,strel('line',25,0)),strel('line',25,90));
% figure, imshow(BWsdil1);
reg1 = regionprops(BWsdil1);
bw1 = bwlabel(BWsdil1);
% figure, imagesc(bw1);
[mx1,mxind1] = max([reg1.Area]);
B1 = double(bw1 == mxind1);
B1(B1 == 0) = -1;
% figure,imshow(B1);

% Segment complete RGB Cow 320*240
fuse = imoverlay(R,~imbinarize(B), 'black');
% figure,imshow(fuse);

% Segment complete RGB Cow 640*480
fuse3 = imoverlay(R1,~imbinarize(B1), 'black');
% figure,imshow(fuse3);
 
% Obtain mask 320*240
fuse1 = imoverlay(T,~imbinarize(B));
% figure,imshow(fuse1);
fuse2 = rgb2gray(fuse1);  

% Obtain mask 640*480
fuse4 = imoverlay(T1,~imbinarize(B1));
% figure,imshow(fuse4);
fuse5 = rgb2gray(fuse4);  

% Thresholding 320*240 on only cow
[r2,c2] = size(fuse2);
im1 = zeros(r2,c2);
 for i = 1:r2
     for j = 1:c2
         if fuse2(i,j) > 200
             im1(i,j) = 1;
%          else
%              im2(i,j) = -1;
         end
     end
 end
 
% figure,imshow(im1);
im2 = imbinarize(im1);
% figure,imshow(im2);

% Thresholding 640*480 on only cow
[r3,c3] = size(fuse5);
im6 = zeros(r3,c3);
 for i = 1:r3
     for j = 1:c3
         if fuse5(i,j) > 200
             im6(i,j) = 1;
%          else
%              im2(i,j) = -1;
         end
     end
 end
 
% figure,imshow(im6);
im7 = imbinarize(im6);
% figure,imshow(im7);


% Smoothen out the edges of mask 320*240
windowSize = 9;
kernel = ones(windowSize) / windowSize ^ 2;
blurryImage = conv2(single(im2), kernel, 'same');
im3 = blurryImage > 0.8; % Rethreshold
% figure,imshow(~im3);

% Smoothen out the edges of mask 640*480
windowSize = 12;
kernel = ones(windowSize) / windowSize ^ 2;
blurryImage1 = conv2(single(im7), kernel, 'same');
im7 = blurryImage1 > 0.8; % Rethreshold
% figure,imshow(~im7);


% Scratched RGB Image 320*240
RGB = imoverlay(fuse,~im3, 'white');
% figure, imshow(RGB);

% Scratched RGB Image 640*480
RGB1 = imoverlay(fuse3,~im7, 'white');
% figure, imshow(RGB1);

BB = regionprops(B);
BB1 = regionprops(B1);

RGB = imcrop(RGB, BB.BoundingBox);
RGB1 = imcrop(RGB1, BB1.BoundingBox);

im4 = im2uint8(im3);
im8 = im2uint8(im7);

im4 = imcrop(im4, BB.BoundingBox);
im8 = imcrop(im8, BB1.BoundingBox);
