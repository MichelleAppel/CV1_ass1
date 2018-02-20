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

[w, h] = size(p);
height_map = zeros(w, h);

switch path_type
    case 'column'
        % =================================================================
        % YOUR CODE GOES HERE
        % top left corner of height_map is zero
        % for each pixel in the left column of height_map
        %   height_value = previous_height_value + corresponding_q_value
        
        for x = 2:h % 512 (image width)
            for y = 1:w % 512 (image height)
                
                height_map(y, x) = height_map(y, x-1) + p(y, x);
                
            end
        end
        % for each row
        %   for each element of the row except for leftmost
        %       height_value = previous_height_value + corresponding_p_value
        

       
        % =================================================================
               
    case 'row'
        
        % =================================================================
        % YOUR CODE GOES HERE
        
        for y = 2:w % 512 (image width)
            for x = 1:h % 512 (image height)
                
                height_map(y, x) = height_map(y-1, x) + q(y, x);
                
            end
        end
        
        % =================================================================
          
    case 'average'
        
        % =================================================================
        % YOUR CODE GOES HERE
        height_map_column = zeros(h, w);
        for x = 2:w % 512 (image width)
            for y = 1:h % 512 (image height)
                
                height_map_column(y, x) = height_map_column(y, x-1) + p(y, x);
                
            end
        end

        
        
        height_map_row = zeros(h, w);
        for y = 2:w % 512 (image width)
            for x = 1:h % 512 (image height)
                
                height_map_row(y, x) = height_map_row(y-1, x) + q(y, x);
                
            end
        end
    
        
        
        height_map(:, :) = (height_map_column(:, :) + height_map_row(:, :)) ./ 2;
        % =================================================================
end


end
