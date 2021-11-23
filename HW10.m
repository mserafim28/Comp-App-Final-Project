clc; clear; 
% Step 1: Image Inspection
I = imread('IMG_0480.jpeg');
I = rgb2gray(I);
imshow(I);
title('Original Image');

% Step 2: Edge Detection
[~,threshhold] = edge(I,'sobel');
fudgeFactor = 0.5;
BWs = edge(I,'sobel', threshhold*fudgeFactor);
imshow(BWs);

% Step 3: Dilate the Image
se90 = strel('line',3,90);
se0 = strel('line',3,0);
BWsdil = imdilate(BWs,[se90 se0]);
imshow(BWsdil);

% Step 4: Fill Interior Gaps
BWdfill = imfill(BWsdil, 'holes');
imshow(BWdfill);
title('Binary image with filled holes');

% Step 5: Remove Connected Objects on Border
BWnobord = imclearborder(BWdfill,4);
imshow(BWnobord); 
title('Cleared border image');

% Step 6: Smoothen the Object
seD = strel('square',1);
BWfinal = imerode(BWnobord, seD);
BWfinal = imerode(BWfinal, seD);
imshow(BWfinal);
title('Segmented Image');

% Step 7:Visualize the Segmentation
imshow(labeloverlay(I,BWfinal));
title('Mask Over Original Image');

