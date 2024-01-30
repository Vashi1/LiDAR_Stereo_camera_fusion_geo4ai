% Auto-generated by stereoCalibrator app on 27-Jan-2024
%-------------------------------------------------------


% Define images to process
imageFileNames1 = {'C:\Users\Rakshith\Desktop\LiDAR-Camera Fusion\LiDAR_Camera_Fusion_codes\LiDAR_Stereo_camera_fusion_geo4ai\Images\stereo_left\lidar_frame1.jpg',...
    'C:\Users\Rakshith\Desktop\LiDAR-Camera Fusion\LiDAR_Camera_Fusion_codes\LiDAR_Stereo_camera_fusion_geo4ai\Images\stereo_left\lidar_frame3.jpg',...
    'C:\Users\Rakshith\Desktop\LiDAR-Camera Fusion\LiDAR_Camera_Fusion_codes\LiDAR_Stereo_camera_fusion_geo4ai\Images\stereo_left\lidar_frame4.jpg',...
    'C:\Users\Rakshith\Desktop\LiDAR-Camera Fusion\LiDAR_Camera_Fusion_codes\LiDAR_Stereo_camera_fusion_geo4ai\Images\stereo_left\lidar_frame5.jpg',...
    };
imageFileNames2 = {'C:\Users\Rakshith\Desktop\LiDAR-Camera Fusion\LiDAR_Camera_Fusion_codes\LiDAR_Stereo_camera_fusion_geo4ai\Images\stereo_right\img_right1.jpg',...
    'C:\Users\Rakshith\Desktop\LiDAR-Camera Fusion\LiDAR_Camera_Fusion_codes\LiDAR_Stereo_camera_fusion_geo4ai\Images\stereo_right\img_right3.jpg',...
    'C:\Users\Rakshith\Desktop\LiDAR-Camera Fusion\LiDAR_Camera_Fusion_codes\LiDAR_Stereo_camera_fusion_geo4ai\Images\stereo_right\img_right4.jpg',...
    'C:\Users\Rakshith\Desktop\LiDAR-Camera Fusion\LiDAR_Camera_Fusion_codes\LiDAR_Stereo_camera_fusion_geo4ai\Images\stereo_right\img_right5.jpg',...
    };

% Detect calibration pattern in images
detector = vision.calibration.stereo.CheckerboardDetector();
[imagePoints, imagesUsed] = detectPatternPoints(detector, imageFileNames1, imageFileNames2);

% Generate world coordinates for the planar patten keypoints
squareSize = 25;  % in units of 'millimeters'
worldPoints = generateWorldPoints(detector, 'SquareSize', squareSize);

% Read one of the images from the first stereo pair
I1 = imread(imageFileNames1{1});
[mrows, ncols, ~] = size(I1);

% Calibrate the camera
[stereoParams, pairsUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', false, 'EstimateTangentialDistortion', false, ...
    'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'millimeters', ...
    'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', [], ...
    'ImageSize', [mrows, ncols]);

% View reprojection errors
h1=figure; showReprojectionErrors(stereoParams);

% Visualize pattern locations
h2=figure; showExtrinsics(stereoParams, 'CameraCentric');

% Display parameter estimation errors
displayErrors(estimationErrors, stereoParams);

% You can use the calibration data to rectify stereo images.
I2 = imread(imageFileNames2{1});
[J1, J2, reprojectionMatrix] = rectifyStereoImages(I1, I2, stereoParams);

% See additional examples of how to use the calibration data.  At the prompt type:
% showdemo('StereoCalibrationAndSceneReconstructionExample')
% showdemo('DepthEstimationFromStereoVideoExample')
