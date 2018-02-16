function [ albedo, normal ] = estimate_alb_nrm( image_stack, scriptV, shadow_trick)
%COMPUTE_SURFACE_GRADIENT compute the gradient of the surface
%   image_stack : the images of the desired surface stacked up on the 3rd
%   dimension
%   scriptV : matrix V (in the algorithm) of source and camera information
%   shadow_trick: (true/false) whether or not to use shadow trick in solving
%   	linear equations
%   albedo : the surface albedo
%   normal : the surface normal


[h, w, ~] = size(image_stack);
if nargin == 2
    shadow_trick = true;
end

% create arrays for 
%   albedo (1 channel)
%   normal (3 channels)
albedo = zeros(h, w, 1);
normal = zeros(h, w, 3);
%size(albedo)
%size(normal)

% =========================================================================
% YOUR CODE GOES HERE
% for each point in the image array
%   stack image values into a vector i
%   construct the diagonal matrix scriptI
%   solve scriptI * scriptV * g = scriptI * i to obtain g for this point
%   albedo at this point is |g|
%   normal at this point is g / |g|

for x = 1:1 % 512
    for y = 1:1 % 512
        i = reshape(image_stack(x, y, :), [5,1]);
        scriptI = diag(i);
        %size(scriptI)
        %size(i)
        %size(scriptV)
        %test1 = scriptI * i
        %test2 = scriptI * scriptV
        %size(scriptI * i * ones(1,3))
        %size(scriptI * scriptV)
        g = (scriptI * i * ones(1,3)) / (scriptI * scriptV);
        size(albedo(y, x, 1))
        size(sum(g))
        % TODO: FIX ERROR
        albedo(y, x, 1) = sum(g);
        normal(y, x, :) = g / sum(g);
    end
end

% =========================================================================

end

