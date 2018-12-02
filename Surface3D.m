function [] = surface_3D(segm, image, segmColor, imageColor)
% Plot 3D model of image with segmented objects in specified color

if ~exist('segmColor','var')
    segmColor = 'green'; % if segmentation color is not specified, use green
end

figure('Position', [10 10 900 600]);

% if image exist
if numel(size(image)) == 3
    
    if ~exist('imageColor','var')
        if strcmp(segmColor, 'blue')
            imageColor = [0 0.7 0.2];
        else
            imageColor = 'blue'; % if image color is not specified, use blue
        end
    end
    
    bw = zeros(size(image)); % take only shape from image
    bw(image>0) = 1; 
    
    % for better visualization
    J = imfill(bw,'holes');
    J = smooth3(J,'box',5);

    hv = isosurface(J, 0.5);
    h = patch(hv);
    set(h, 'FaceColor', imageColor);
    set(h, 'EdgeColor', 'none');
    alpha(0.1);
    hold on;
end

hv2 = isosurface(segm, 0.5);
patch(hv2, 'FaceColor', segmColor, 'EdgeColor', 'none');
view(3);
axis vis3d % smooth rotation
set(gca, 'visible','off', 'xlim',[0 size(segm,2)], 'ylim',[0 size(segm,1)], ...
    'zlim',[0 size(segm,3)]); % axis limits