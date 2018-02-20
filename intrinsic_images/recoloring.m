% Intrinsic Image Decomposition -- Recoloring

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

% select R, G, and B matrices
R = refl_matrix(:, :, 1);
G = refl_matrix(:, :, 2);
B = refl_matrix(:, :, 3);

% calculate RGB value (for the center pixel, because it is uniform)
[w, h] = size(R);
RGB = [R(w/2, h/2), G(w/2, h/2), B(w/2, h/2)];

% green reflection: R = 0, G = 255, B = 0
green_reflection = zeros(size(refl_matrix));
for x = 1:w
    for y = 1:h
        if R(x, y) ~= 0
            green_reflection(x, y, 1) = 0;
        end
        if G(x, y) ~= 0
            green_reflection(x, y, 2) = 1;
        end
        if B(x, y) ~= 0
            green_reflection(x, y, 3) = 0;
        end
    end
end


% magenta reflection: R = 255, G = 0, B = 255
magenta_reflection = zeros(size(refl_matrix));
for x = 1:w
    for y = 1:h
        if R(x, y) ~= 0
            magenta_reflection(x, y, 1) = 1;
        end
        if G(x, y) ~= 0
            magenta_reflection(x, y, 2) = 0;
        end
        if B(x, y) ~= 0
            magenta_reflection(x, y, 3) = 1;
        end
    end
end


% reconstruct image with normal reflection
reconstruction = refl_matrix .* shade_matrix;

% reconstruct image with green reflection
green_reconstruction = green_reflection .* shade_matrix;

% reconstruct image with magenta reflection
magenta_reconstruction = magenta_reflection .* shade_matrix;

% create the subplots
figure;
h    = [];
h(1) = subplot(2,2,1);
h(2) = subplot(2,2,2);
h(3) = subplot(2,2,3);

% add images
image(reconstruction, 'Parent', h(1));
image(green_reconstruction, 'Parent', h(2));
image(magenta_reconstruction, 'Parent', h(3));