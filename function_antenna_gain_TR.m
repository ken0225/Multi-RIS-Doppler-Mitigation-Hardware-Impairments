function [output_antenna_gain_TR]=function_antenna_gain_TR(temp)  % p2 denotes Receiver and p1 denotes Transmitter
% Author: Ke(Ken)WANG from Macao Polytechnic University
% Email: ke.wang@mpu.edu.mo, kewang0225@gmail.com
% Update infomation: v0.8(2022/June/25)

% License: This code is licensed under the GPLv2 license. If you in any way
% use this code for research that results in publications, please cite our
% original article.
%
% This function aims to calculate the gain of transceiver.
% Note that since we suppose the transceiver is isotropic, then the gain
% always equals to 1.

%
% Example:
%
% [output_antenna_gain_TR]=function_antenna_gain_TR(eye(3), [1,2,3;4,5,6;7,8,9])
% 
% output_antenna_gain_TR =
% 
%      1     1     1
    
    
    % Note that since we suppose the transceiver is isotropic, then the gain
    % always equals to 1.
    output_antenna_gain_TR = ones(1, temp);
   
end
