function MakeVideo(filename, format)
% Captures 3D plot and makes a video in specified format with the plot
% rotated.
%
% Inputs:
%           filename - name for created video (string)
%           format - file type, one from: 'MPEG-4', 'Uncompressed AVI', 
%                    'Motion JPEG AVI', 'Grayscale AVI'
%

if strcmp(format, 'MPEG-4')
    filename = [filename, '.mp4'];
else
    filename = [filename, '.avi'];
end
    
video = VideoWriter(filename, format);
video.Quality = 95; % quality for video (max 100)
frames = [linspace(-10, -369, 360); repmat(10, 1, 360)]';
   
open(video);
for frame = 1:size(frames,1)
    view(frames(frame,:)); drawnow;
    writeVideo(video, getframe(gcf)); 
end
close(video);