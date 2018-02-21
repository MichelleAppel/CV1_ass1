% Color Constancy -- Grey-World Algorithm

% clear figures and command window
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

% calculate mean of R, G, and B channel
R_mean = mean(mean(R));
G_mean = mean(mean(G));
B_mean = mean(mean(B));

% calculate normalization factors
R_norm = 0.5 ./ R_mean;
G_norm = 0.5 ./ G_mean;
K_norm = 0.5 ./ B_mean;

% normalize each color channel to create the corrected image
corrected_img(:, :, 1) = R_norm * double(R);
corrected_img(:, :, 2) = G_norm * double(G);
corrected_img(:, :, 3) = K_norm * double(B);

% save reconstructed image as .png
%imwrite(corrected_img, 'norm_awb.jpg')

% create the subplots
figure;
h    = [];
h(1) = subplot(2, 2, 1);
h(2) = subplot(2, 2, 2);

% add images to figure
image(awb_img, 'Parent', h(1));
image(corrected_img, 'Parent', h(2));