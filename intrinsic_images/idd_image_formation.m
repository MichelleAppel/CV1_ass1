% Intrinsic Image Decomposition -- Image Formation

% clear figures and command window
clear
clc
close all

% read images
ball_img = imread('ball.png');
shade_img = imread('ball_shading.png');
refl_img = imread('ball_reflectance.png');

% transform to matrices with pixel values
ball_matrix = im2double(ball_img);
shade_matrix = im2double(shade_img);
refl_matrix = im2double(refl_img);

% reconstruct images by multiplying reflection and shade
reconstruction = refl_matrix .* shade_matrix;

% save image as .png
imwrite(reconstruction, 'ball_reconstructed.png')

% create the subplots
figure;
h    = [];
h(1) = subplot(2, 2, 1);
h(2) = subplot(2, 2, 2);
h(3) = subplot(2, 2, 3);
h(4) = subplot(2, 2, 4);

% add images
image(refl_img, 'Parent', h(1));
image(shade_img, 'Parent', h(2));
image(ball_img, 'Parent', h(3));
image(reconstruction, 'Parent', h(4));