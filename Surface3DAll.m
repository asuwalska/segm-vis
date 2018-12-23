function Surface3DAll(varargin)
% Plot 3D model of multiple segmentations
%
% For each segmentation - color and transparency must be specified.
% Example of usage: 
%   Surface3DAll(segm1,'r',0.8,segm2,'b',0.4,segm3,[0 0 0.5],0.1);
%
number_of_segmentations = nargin;

figure('Position', [10 10 900 600]);

for i = 1:3:number_of_segmentations
    segm = varargin{i};
    color = varargin{i+1};
    alpha_segm = varargin{i+2};

    bw_segm = zeros(size(segm)); 
    bw_segm(segm>0) = 1; 
    segm = bw_segm;

    segm = imfill(segm,'holes');

    hv = isosurface(segm, 0.5);
    h = patch(hv);
    set(h, 'FaceColor', color, 'EdgeColor', 'none', 'FaceAlpha', alpha_segm);
    hold on;
end

view(3);
axis vis3d % smooth rotation
set(gca, 'visible','off', 'xlim',[0 size(segm,2)], 'ylim',[0 size(segm,1)], ...
    'zlim',[0 size(segm,3)]); % axis limits