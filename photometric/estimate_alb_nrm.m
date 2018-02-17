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

[h, w, ~] = size(image_stack);
if nargin == 2
    shadow_trick = true;
end

% create arrays for 
%   albedo (1 channel)
%   normal (3 channels)
albedo = zeros(h, w, 1);
normal = zeros(h, w, 3);
%size(albedo)        % 512x512 matrix
%size(normal)        % 512x512x3 matrix

% =========================================================================
% YOUR CODE GOES HERE
% for each point in the image array
%   stack image values into a vector i
%   construct the diagonal matrix scriptI
%   solve scriptI * scriptV * g = scriptI * i to obtain g for this point
%   albedo at this point is |g|
%   normal at this point is g / |g|

for x = 1:512 % 512 (image width)
    for y = 1:512 % 512 (image height)

        i = reshape(image_stack(x, y, :), [5,1]);
        scriptI = diag(i);
        %size(i)        % 5x1 matrix
        %size(scriptI)  % 5x5 matrix
        %size(scriptV)  % 5x3 matrix
        %g = (scriptI * i * ones(1,3)) / (scriptI * scriptV); % wrong

        A = scriptI * scriptV;
        B = scriptI * i;
        %g = linsolve(A, B); % solves the matrix equation AX = B
        g = mldivide(A, B); % solves the system of linear equations A*x = B
        %size(A)        % 5x3 matrix
        %size(B)        % 5x1 matrix
        %size(g)        % 5x1 matrix
       
        % TODO: FIX ERROR FOR LINSOLVE() and MLDIVIDE():
        % "Warning: Rank deficient, rank = 0, tol =  0.000000e+00"
        albedo(y, x, 1) = sum(g);
        if sum(g) ~= 0
            normal(y, x, :) = g / sum(g);        
        end
    end
end

% =========================================================================

end

