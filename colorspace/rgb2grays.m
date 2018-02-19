function [output_image] = rgb2grays(input_image)
% converts an RGB into grayscale by using 4 different methods

%[w, h, ~] = size(input_image);
%output_image = zeros(w, h, 1);

R = input_image(:, :, 1);
G = input_image(:, :, 2);
B = input_image(:, :, 3);

% ligtness method
%output_image = (max(max(R, G), B) + min(min(R, G), B)) / 2;

% average method
%output_image = (R + G + B) / 3;

% luminosity method
%output_image = 0.21 * R + 0.72 * G + 0.07 * B;

% built-in MATLAB function 
output_image = rgb2gray(input_image);

end

