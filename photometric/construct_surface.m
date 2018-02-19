function [ height_map ] = construct_surface( p, q, path_type )
%CONSTRUCT_SURFACE construct the surface function represented as height_map
%   p : measures value of df / dx
%   q : measures value of df / dy
%   path_type: type of path to construct height_map, either 'column',
%   'row', or 'average'
%   height_map: the reconstructed surface


if nargin == 2
    path_type = 'column';
end

[h, w] = size(p);
height_map = zeros(h, w);

switch path_type
    case 'column'
        % =================================================================
        % YOUR CODE GOES HERE
        % top left corner of height_map is zero
        % for each pixel in the left column of height_map
        %   height_value = previous_height_value + corresponding_q_value
        
        for x = 1:512 % 512 (image width)
            for y = 2:512 % 512 (image height)
                
                height_map(x, y) = height_map(x, y-1) + q(x, y);
                
            end
        end
        % for each row
        %   for each element of the row except for leftmost
        %       height_value = previous_height_value + corresponding_p_value
        

       
        % =================================================================
               
    case 'row'
        
        % =================================================================
        % YOUR CODE GOES HERE
        
        for y = 1:512 % 512 (image width)
            for x = 2:512 % 512 (image height)
                
                height_map(x, y) = height_map(x-1, y) + p(x, y);
                
            end
        end
        
        % =================================================================
          
    case 'average'
        
        % =================================================================
        % YOUR CODE GOES HERE
        for x = 1:512 % 512 (image width)
            for y = 2:512 % 512 (image height)
                
                height_map(x, y) = height_map(x, y-1) + q(x, y);
                
            end
        end

        for y = 1:512 % 512 (image width)
            for x = 2:512 % 512 (image height)
                
                height_map(x, y) = height_map(x-1, y) + p(x, y);
                
            end
        end
    
        height_map(:, :) = height_map(:, :) ./ 2;
        % =================================================================
end


end

