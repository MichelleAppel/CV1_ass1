% Color Constancy -- Grey-World Algorithm

clear
clc
close all

% read image
awb_img = imread('awb.jpg');

% transform to w x h x 3 matrix with pixel values
awb_matrix = im2double(awb_img);

% select R, G, and B matrices (one color channel per matrix)
R = awb_matrix(:, :, 1);
G = awb_matrix(:, :, 2);
B = awb_matrix(:, :, 3);

% calculate mean of R, G, and B channel and final mean
R_mean = mean(mean(R));
G_mean = mean(mean(G));
B_mean = mean(mean(B));
RGB_mean = mean([R_mean, G_mean, B_mean]);

% calculate normalization factors
R_norm = RGB_mean ./ R_mean;
G_norm = RGB_mean ./ G_mean;
K_norm = RGB_mean ./ B_mean;

% normalize each color channel to create the corrected image
corrected_img(:,:,1) = R_norm * double(R);
corrected_img(:,:,2) = G_norm * double(G);
corrected_img(:,:,3) = K_norm * double(B);

% create the subplots
figure;
h    = [];
h(1) = subplot(2,2,1);
h(2) = subplot(2,2,2);

% add images to figure
image(awb_img, 'Parent', h(1));
image(corrected_img, 'Parent', h(2));