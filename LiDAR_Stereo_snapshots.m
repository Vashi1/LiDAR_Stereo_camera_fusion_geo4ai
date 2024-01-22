clear all;close all;clc;

% Open the ZED
zed = webcam('ZED 2i');
%LiDAR Initialization
lidar = velodynelidar('VLP16');
preview(lidar)
% Set video resolution
zed.Resolution = zed.AvailableResolutions{1};
% Get image size
[height, width, channels] = size(snapshot(zed));

% Create Figure and wait for keyboard interrupt to quit
f = figure('name','ZED camera','keypressfcn','close','windowstyle','modal');
ok = 1;
counter = 1;
while ok
      % Capture the current image
      img = snapshot(zed);
        
      
      % Split the side by side image image into two images
      image_left = img(:, 1 : width/2, :);
      image_right = img(:, width/2 +1: width, :);
      
      % Save the image on user prompt
      X = input("Enter keystroke: ", "s");
      if (X == "y")
        % Saving the Split Stereo Camera Images
        f_name_l = append("img_left",tostring(counter),".jpg");
        f_name_r = append("img_right",tostring(counter),".jpg");
        imwrite(image_left, f_name_r);
        imwrite(image_right, f_name_r);
        counter = counter + 1;
        % Start LiDAR Point Cloud acquisition
        start(lidar);        
        [frame,timestamp] = read(lidar,1);
        stop(lidar)
        save lidardata.mat frames timestamps
        clear lidar



      end

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