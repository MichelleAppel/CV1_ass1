function [ p, q, SE ] = check_integrability( normals )
%CHECK_INTEGRABILITY check the surface gradient is acceptable
%   normals: normal image
%   p : df / dx
%   q : df / dy
%   SE : Squared Errors of the 2 second derivatives

[h, w, ~] = size(normals);

% initalization
p = zeros([h, w]);
q = zeros([h, w]);
SE = zeros([h, w]);

% ========================================================================
% YOUR CODE GOES HERE
% Compute p and q, where
% p measures value of df / dx
% q measures value of df / dy

% calculate first order partial derivatives
% [p, q] = gradient(normals); % correct method? NO
p = normals(:, :, 1) ./ normals(:, :, 3);
q = normals(:, :, 2) ./ normals(:, :, 3);
% p and q are 512x512x1 matrices

% ========================================================================

p(isnan(p)) = 0;
q(isnan(q)) = 0;

% ========================================================================
% YOUR CODE GOES HERE
% approximate second derivate by neighbor difference
% and compute the Squared Errors SE of the 2 second derivatives SE

% TODO
% "Implement and compute the second derivatives according to the algorithm
% and perform the test of integrability by choosing a reasonable threshold"

% p_p : dp / dx [ = d df/dx / dx ]
% p_q : dp / dy [ = d df/dx / dy ]
% q_q : dq / dy [ = d df/dy / dy ]
% q_p : dq / dx [ = d df/dy / dx ]

% calculate second order partial derivatives
[~, p_y] = gradient(p); % correct method?
[q_x, ~] = gradient(q); % correct method?
% p_p, p_q, q_p and q_q are 512x512x3 matrices

% d df/dx / dy - d df/dy / dx   should be small at each point
% dp / dy - dq / dx             should be small at each point
% check: is (dp/dy - dq / dx)^2 small at each point?
% check: is (p_q - q_p)^2       small at each point?

% calculate the Squared Errors SE using the final formulas above
SE = (p_y - q_x).^2;
treshold = 0.01; % needs to be determined
large_values = find(SE > treshold);

% ========================================================================

end
