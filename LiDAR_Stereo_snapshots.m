clear all;
close all;
clc;

% Open the ZED
zed = webcam('ZED 2i');
closePreview(zed);

% LiDAR Initialization
lidar = velodynelidar('VLP16');
%preview(lidar)

% Set video resolution
zed.Resolution = zed.AvailableResolutions{1};

% Get image size
[height, width, channels] = size(snapshot(zed));

% Create Figure and wait for keyboard interrupt to quit
f = figure('name','ZED camera','keypressfcn','close','windowstyle','modal');
ok = 1;
counter = 1;

while ok
<<<<<<< Updated upstream
    % Capture the current image
    img = snapshot(zed);

    % Split the side by side image image into two images
    image_left = img(:, 1 : width/2, :);
    image_right = img(:, width/2 + 1 : width, :);

    % Start LiDAR Point Cloud acquisition
    start(lidar);
    [frame, timestamp] = read(lidar, 1);

    % Stop LiDAR Point Cloud acquisition
    stop(lidar);

    % Save the images and LiDAR data on user prompt
    X = input("Enter keystroke: ", "s");
    if (X == "y")
=======
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
      % Save the image on user prompt
      X = input("Enter keystroke: ", "s");
      if (X == "y")
>>>>>>> Stashed changes
        % Saving the Split Stereo Camera Images
        f_name_l = append("img_left",string(counter),".jpg");
        f_name_r = append("img_right",string(counter),".jpg");
        imwrite(image_left, f_name_l);
        imwrite(image_right, f_name_r);

        % Saving LiDAR data
        lidar_data_filename = append("lidar_data", string(counter), ".mat");
        save(lidar_data_filename, 'frame', 'timestamp');

        counter = counter + 1;
<<<<<<< Updated upstream
    end
    if (X == "n")
        break;
    end
    %Display the left and right images
    subplot(1,2,1);
    imshow(image_left);
    title('Image Left');
    subplot(1,2,2);
    imshow(image_right);
    title('Image Right');
    drawnow;

    % Check for interrupts
    %ok = ishandle(f);
end

% Close the camera and LiDAR instances
clear zed;
clear li
=======
        % Start LiDAR Point Cloud acquisition
        start(lidar);        
        [frame,timestamp] = read(lidar,1);
        stop(lidar)
        save lidardata.mat frames timestamps
        clear lidar
      end
      % Check for interrupts
      ok = ishandle(f);
  end
>>>>>>> Stashed changes

    
  %close the camera instance
  clear cam