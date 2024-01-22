%View Saved Stereo data
clear all;
clc;
data = load('lidar_data1.mat', 'frame')
y = data.frame;
pc = pcshow(y);