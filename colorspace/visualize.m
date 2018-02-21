function visualize(input_image, colorspace)
    [~, ~, channels] = size(input_image);
       
    figure;
    if channels == 3
        % all color methods
        subplot(2, 2, 1);
        imshow(input_image);
        imwrite(input_image, strcat('images/', colorspace, '_img.png'));
        for ii = 2:channels+1
            subplot(2, 2, ii);
            imshow(input_image(:, :, ii-1));
            imwrite(input_image(:, :, ii-1), strcat('images/', colorspace, num2str(ii-1), '_img.png'));
        end
    else
        % all greyscale methods
        for ii = 1:channels
            subplot(2, 2, ii);
            imshow(input_image(:, :, ii));
            imwrite(input_image(:, :, ii), strcat('images/', colorspace, num2str(ii), '_img.png'));
        end
    end
end

