function ShowSegmentation(image, segm, war)
% plot 2D segmentation from slice war

if numel(size(image)) == 3
    
    if ~exist('war', 'var')
        war = round(size(image,3)/2);
    end
    
    E = segm(:,:,war);
    slice = image(:,:,war);  
else
    E = segm;
    slice = image;
end

figure(); imshow(slice,[]);
hold on;

yellow = cat(3, ones(size(E)), ones(size(E)), zeros(size(E)));
y = imshow(yellow);
hold off;
set(y, 'AlphaData', E);

end

