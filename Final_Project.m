% Final Project:

% Method 1

clc; clear;
filename = input('Enter image name: ','s');
color = input('Is image stained with live-dead staining or cell tracker? Enter answer as either live-dead or cell tracker: ','s');
pix = imread(filename);
[h,w,c] = size(pix);
binary = false(h,w);
count = 0;
if color == "live-dead"
    for ii=1:1:h
        for jj=1:1:w
            r = pix(ii, jj, 1);
            g = pix(ii, jj, 2);
            b = pix(ii, jj, 3);
            if r>=183 && r<=255 && g>=90 && g<=241 && b>=33 && b<=170 %&& r>b+45
                binary(ii,jj)= 1;
                count = count + 1;
            end
        end
    end
elseif color == "cell tracker"
    for ii=1:1:h
        for jj=1:1:w
            r = pix(ii, jj, 1);
            g = pix(ii, jj, 2);
            b = pix(ii, jj, 3);
            if r>=170 && r<=255 && g>=70 && g<=140 && b>=55 && b<=140 %&& r>b+45
                binary(ii,jj)= 1;
                count = count + 1;
            end
        end
    end
else
    error('Invalid input');
end   

% Method 2

% Step 1: Image Inspection
I = pix;
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
BWfinal=bwareafilt(BWfinal,[50 3000]);
imshow(BWfinal);
title('Segmented Image');

% Step 7:Visualize the Segmentation
figure(1)
subplot(2,1,1)
imshowpair(pix, binary, 'montage');
title('Montage: Method 1')
subplot(2,1,2)
imshow(labeloverlay(I,BWfinal));
title('Mask Over Original Image: Method 2');

% Calculations
CC = bwconncomp(BWfinal);
m1_cell = round(count/78.168);
m2_cell = CC.NumObjects;
if color == "live-dead"
    fprintf('Live cell count:%d\n',m1_cell);
    fprintf('Total cell count:%d\n',m2_cell);
    fprintf('Percent Survival:%.2f%%\n',(m1_cell/m2_cell)*100);
else
    fprintf('Method 1 cell count:%d\n',m1_cell);
    fprintf('Method 2 cell count:%d\n',m2_cell);
    fprintf('Average cell count:%.2f\n',(m1_cell + m2_cell)/2);
end


% Total cell count on scaffold

% Image Thresholding:
% clc; clear;
% filename = input('Enter filename: ','s');
% pix = imread(filename);
% [h, w, c] = size(pix);
% binary = false(h,w);
% for ii=1:1:h
%     for jj=1:1:w
%         r = pix(ii, jj, 1);
%         g = pix(ii, jj, 2);
%         b = pix(ii, jj, 3);
%         if r <100 && g >5 && g< 130 && b >50 && b<160 && b>r && b>g
%             binary(ii,jj)= 1;
%         end
%     end
% end
% blank = zeros(h,w);
% for ii = 2:1:h-1
%     for jj = 2:1:w-1
%         x = double(binary(ii,jj))*-4;
%         y = double(binary(ii-1,jj));
%         z = double(binary(ii+1,jj));
%         a = double(binary(ii,jj-1));
%         b = double(binary(ii,jj+1));
%         blank(ii,jj) = x+y+z+a+b;
%     end
% end
% blank = blank>0;
% for ii=1:1:h
%     for jj=1:1:w
%         if blank(ii,jj)==1
%             pix(ii,jj,:) = 255;
%         end
%     end
% end
% imshow(pix);
