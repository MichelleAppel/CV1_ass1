function [ height_map ] = construct_surface( p, q, path_type )
%CONSTRUCT_SURFACE construct the surface function represented as height_map
%   p : measures value of df / dx
%   q : measures value of df / dy
%   path_type: type of path to construct height_map, either 'column',
%   'row', or 'average'
%   height_map: the reconstructed surface


if nargin == 2
    path_type = 'average';
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
        
        height_map = zeros(w, h);
        for x = 2:w % 512 (image width)
            for y = 1:h % 512 (image height)
                
                height_map(x, y) = height_map(x-1, y) + p(x, y);
                
            end
        end
        % for each row
        %   for each element of the row except for leftmost
        %       height_value = previous_height_value + corresponding_p_value
        

       
        % =================================================================
               
    case 'row'
        
        % =================================================================
        % YOUR CODE GOES HERE
        
        for y = 2:h % 512 (image width)
            for x = 1:w % 512 (image height)
                
                height_map(x, y) = height_map(x, y-1) + q(x, y);
                
            end
        end
        
        % =================================================================
          
    case 'average'
        
        % =================================================================
        % YOUR CODE GOES HERE
        height_map_column = zeros(w, h);
        for x = 2:w % 512 (image width)
            for y = 1:h % 512 (image height)
                
                height_map_column(x, y) = height_map_column(x-1, y) + p(x, y);
                
            end
        end

        
        
        height_map_row = zeros(w, h);
        for y = 2:h % 512 (image width)
            for x = 1:w % 512 (image height)
                
                height_map_row(x, y) = height_map_row(x, y-1) + q(x, y);
                
            end
        end
    
        
        
        height_map(:, :) = (height_map_column(:, :) + height_map_row(:, :)) ./ 2 ;
        % =================================================================
end


end
