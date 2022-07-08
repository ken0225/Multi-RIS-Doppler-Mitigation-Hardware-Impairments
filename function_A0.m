function [A0]=function_A0(p1,p2)  % p2 denotes Receiver and p1 denotes Transmitter
% Author: Ke(Ken)WANG from Macao Polytechnic University
% Email: ke.wang@mpu.edu.mo, kewang0225@gmail.com
% Update infomation: v0.8(2022/June/25)

% License: This code is licensed under the GPLv2 license. If you in any way
% use this code for research that results in publications, please cite our
% original article.
%
% This function aims to calculate the vehicle coordinate increment.
% Note that we suppose the vehicle only moves along the positive x-axis direction

%
% Example:
%
% lambda_c = 3e8/2.4e9; p1=[1,2,3], p2=[0,0,0]; [A0]=function_A0(p1,p2)
%
% A0 =
%
%     0.0019


global c0 fc total_time;

lambda_c = c0/fc;

%The gain of transmitter, from the direction of receiver
G_T_to_R_direction = function_antenna_gain_TR(total_time);

%The gain of receiver, from the direction of transmitter
G_R_to_T_direction = function_antenna_gain_TR(total_time);

A0 = lambda_c/(4*pi) .* sqrt(G_T_to_R_direction.*G_R_to_T_direction)./vecnorm((p2-p1).'); %eq(3) in GC2021 paper

end
