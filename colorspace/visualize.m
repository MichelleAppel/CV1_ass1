function visualize(input_image)
    [~, ~, channels] = size(input_image);
    if channels == 3
        image(input_image);
    else
        imshow(mat2gray(input_image));
    end
end

