function [output_function_vehicle_moving_xdir]=function_vehicle_moving_xdir(speed, t)
% Author: Ke(Ken)WANG from Macao Polytechnic University
% Email: ke.wang@mpu.edu.mo, kewang0225@gmail.com
% Update infomation: v0.8(2022/June/25)
%
% This function aims to calculate the vehicle coordinate increment. 
% Note that we suppose the vehicle only moves along the positive x-axis direction
%
% License: This code is licensed under the GPLv2 license. If you in any way
% use this code for research that results in publications, please cite our
% original article.
%
% Example:
%
% [output_function_vehicle_moving_xdir]=function_vehicle_moving_xdir(83.3,100)
% 
% output_function_vehicle_moving_xdir =
% 
%         8330           0           0

    output_function_vehicle_moving_xdir = [speed.*t, 0, 0];

end