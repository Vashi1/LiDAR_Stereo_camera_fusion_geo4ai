clear all;close all;clc;

% Open the ZED
zed = webcam('ZED 2i');
% Set video resolution
zed.Resolution = zed.AvailableResolutions{1};
% Get image size
[height width, channels] = size(snapshot(zed))

% Create Figure and wait for keyboard interrupt to quit
f = figure('name','ZED camera','keypressfcn','close','windowstyle','modal');
ok = 1;

% Start loop
while ok
      % Capture the current image
      img = snapshot(zed);

      % Split the side by side image image into two images
      image_left = img(:, 1 : width/2, :);
      image_right = img(:, width/2 +1: width, :);

      % Display the left and right images
      subplot(1,2,1);
      imshow(image_left);
      title('Image Left');
      subplot(1,2,2);
      imshow(image_right);
      title('Image Right');
      drawnow;

      % Check for interrupts
      ok = ishandle(f);
  end

  % close the camera instance
  clear cam