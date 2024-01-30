z%Export Saved Point Clouddata
clear all;
clc;
data = load('lidar_data5.mat', 'frame')
y = data.frame;
pcwrite(y, "lidar_frame5")