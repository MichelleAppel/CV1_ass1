function [ albedo, normal ] = estimate_alb_nrm( image_stack, scriptV, shadow_trick)
warning('off','all')
%COMPUTE_SURFACE_GRADIENT compute the gradient of the surface
%   image_stack : the images of the desired surface stacked up on the 3rd
%   dimension
%   scriptV : matrix V (in the algorithm) of source and camera information
%   shadow_trick: (true/false) whether or not to use shadow trick in solving
%   	linear equations
%   albedo : the surface albedo
%   normal : the surface normal

[h, w, no_images] = size(image_stack);
if nargin == 2
    shadow_trick = true;
end

% create arrays for 
%   albedo (1 channel)
%   normal (3 channels)
albedo = zeros(w, h, 1); % h x w matrix
normal = zeros(w, h, 3); % h x w x 3 matrix

% =========================================================================
% YOUR CODE GOES HERE
% for each point in the image array
%   stack image values into a vector i
%   construct the diagonal matrix scriptI
%   solve scriptI * scriptV * g = scriptI * i to obtain g for this point
%   albedo at this point is |g|
%   normal at this point is g / |g|

for y = 1:h % image width
    for x = 1:w % image height
        g = zeros(no_images, 1);
        
        i = reshape(image_stack(y, x, :), [no_images, 1]); % no_images x 1 matrix
        scriptI = diag(i); % no_images x no_images matrix

        % mldivide(A, B) solves the system of linear equations A*x = B
        if shadow_trick == true
            A = scriptI * scriptV; % no_images x 3 matrix
            B = scriptI * i; % no_images x 1 matrix
            g = linsolve(A, B); % no_images x 1 matrix
        else
            g = linsolve(scriptV, i); % no_images x 1 matrix
        end

        albedo(x, y, 1) = sqrt(sum(g.^2));
        if sum(g) ~= 0
            normal(x, y, :) = g / sqrt(sum(g.^2));   
        end
    end
end
% =========================================================================

end

