close all
clear all
clc

disp('Part 1: Photometric Stereo')

% obtain many images in a fixed view under different illumination
disp('Loading images...')
image_dir = './photometrics_images/MonkeyGray/';   % TODO: get the path of the script
% image_ext = '*.png';

channels = 3; % RGB
albedos_c = 0;
normals_c = 0; 

 for channel = 1:channels
    [image_stack, scriptV] = load_syn_images(image_dir, channel);
    
    
    [h, w, n] = size(image_stack);
    fprintf('Finish loading %d images.\n\n', n);
    
    if albedos_c == 0
        albedos_c = zeros(channels, h, w);
        normals_c = zeros(channels, h, w, channels);  
    end
    
    % compute the surface gradient from the stack of imgs and light source mat
    disp('Computing surface albedo and normal map...')
    [albedo, normals] = estimate_alb_nrm(image_stack, scriptV, true);

    albedos_c(channel, :, :) = albedo;
    normals_c(channel, :, :, :) = normals;
 end
 
%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
p_c = zeros(channels, h, w);
q_c = zeros(channels, h, w);
SE_c = zeros(channels, h, w);

for channel = 1:channels
    disp('Integrability checking')
    [c, h, w, d] = size(normals_c(channel, :, :, :));
    [p, q, SE] = check_integrability(reshape(normals_c(channel, :, :, :), [h, w, d]));   
    
    p_c(channel, :, :) = p;
    q_c(channel, :, :) = q;
    
    threshold = 0.00005;
    SE(SE <= threshold) = NaN; % for good visualization
    
    SE_c(channel, :, :) = SE;
    
    fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));
end
%% compute the surface height
height_map_c = zeros(channels, h, w);

for channel = 1:channels
    height_map = construct_surface( p, q, 'column');
    height_map_c(channel, :, :) = height_map;
end


%% Display seperately
for channel = 1:channels
    show_results(reshape(albedos_c(channel, :, :), [h, w]), reshape(normals_c(channel, :, :, :), [h, w, d]), reshape(SE_c(channel, :, :), [h, w]));
    show_model(reshape(albedos_c(channel, :, :), [h, w]), reshape(height_map_c(channel, :, :), [h, w]));
end
%% Combine
height_map_combined = zeros(h, w);
albedos_combined = zeros(h, w);
normals_combined = zeros(h, w, 3);
SE_combined = zeros(h, w);

for channel = 1:channels
    if ~isnan(height_map_c(channel, 1, 1))
        height_map_combined = height_map_combined + reshape(height_map_c(channel, :, :), [h, w]);
    end
    
    if ~isnan(albedos_c(channel, 1, 1))
        albedos_combined = albedos_combined + reshape(albedos_c(channel, :, :), [h, w]);
    end
    
    if ~isnan(normals_c(channel, 1, 1))
        normals_combined = normals_combined + reshape(normals_c(channel, :, :, :), [h, w, 3]);
    end 

    %if ~isnan(SE_c(channel, 1, 1))
    SE_combined = SE_combined + reshape(SE_c(channel, :, :), [h, w]);
    %end
end

height_map_combined = height_map_combined ./ channels;
albedos_combined = albedos_combined ./ channels;
normals_combined = normals_combined ./ channels;
SE_combined = SE_combined ./ channels;
%% Display combined
show_results(albedos_combined, normals_combined, SE_combined);
show_model(albedos_combined, height_map_combined);
%% Face
[image_stack, scriptV] = load_face_images('./photometrics_images/yaleB02/');
[h, w, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);
disp('Computing surface albedo and normal map...')

[albedo, normals] = estimate_alb_nrm(image_stack, scriptV, false);

%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));

%% compute the surface height
height_map = construct_surface( p, q, 'average');

show_results(albedo, normals, SE);
show_model(albedo, height_map);

