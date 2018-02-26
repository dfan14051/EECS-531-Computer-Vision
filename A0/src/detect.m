%% Clean Environment
close all;clear;clc;

%% load and show input
Io =imread('../data/characters.png'); % original image
load('../data/template-h.mat');
figure; imshow(Io); title('input image');
figure; imagesc(T); colormap(gray);
title('template of letter h');

%% proprecssing input image
I = mat2gray(rgb2gray(Io)); % map to scale [0, 1];
ih = size(I,1);
iw = size(I,2);
th = size(T,1);
tw = size(T,2);

%% scan over I and compare all patches with template T
rh = ih - th + 1;
rw = iw - tw + 1;
D = zeros(rh, rw);
for r=1:rh
    for c=1:rw
            patch = I(r:r+th-1, c:c+tw-1);
            D(r, c) = sum((patch(:) - T(:)).^2);
    end
end
figure;
subplot(1,2,1); imagesc(D); colormap('jet');
subplot(1,2,2); hist(D(:), 100);

%% threshhold and plot the results
thresh = 10;
RI=Io;
for r=1:rh
    for c=1:rw
        if D(r,c) < thresh
            RI(r:r+th-1, c, 1) = 255;
            RI(r:r+th-1, c, 2) = 0;
            RI(r:r+th-1, c, 3) = 255;
            
            RI(r:r+th-1, c+tw-1, 1) = 255;
            RI(r:r+th-1, c+tw-1, 2) = 0;
            RI(r:r+th-1, c+tw-1, 3) = 255;
            
            RI(r, c:c+tw-1, 1) = 255;
            RI(r, c:c+tw-1, 2) = 0;
            RI(r, c:c+tw-1, 3) = 255;
            
            RI(r+th-1, c:c+tw-1, 1) = 255;
            RI(r+th-1, c:c+tw-1, 2) = 0;
            RI(r+th-1, c:c+tw-1, 3) = 255;
            
        end
    end
end
figure; imshow(RI); title('detection result');
