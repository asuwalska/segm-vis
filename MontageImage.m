function [] = montage_image(image)
% plots all slices in montage

minMRI = min(image(:));
maxMRI = max(image(:));

figure();

montage(reshape(image, [size(image,1), size(image,2), 1, size(image,3)]));
set(gca, 'clim', [minMRI, maxMRI - 50]);