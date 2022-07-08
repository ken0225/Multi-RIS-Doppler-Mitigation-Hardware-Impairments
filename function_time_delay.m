function [tau_0, tau_mn]=function_time_delay(centers_IRS, p_BS, p_vehicle_trajectory)
% Author: Ke(Ken)WANG from Macao Polytechnic University
% Email: ke.wang@mpu.edu.mo, kewang0225@gmail.com
% Update infomation: v0.8(2022/June/25)

% License: This code is licensed under the GPLv2 license. If you in any way
% use this code for research that results in publications, please cite our
% original article.
%
% This function aims to calculate tau_0 and tau_mn, i.e., eq(5) and eq(7), in the GC paper 2021

%
% Example:
%
% TBD

global c0;

if ismatrix(centers_IRS) && ismatrix(p_BS) && ismatrix(p_vehicle_trajectory)
    
    %Check the center_IRS is suitable or not
    centers_IRS = function_check_dim(centers_IRS);
    
    %Check the coordinate of BS is suitable or not
    p_BS = function_check_dim(p_BS);
    
    %Check the coordinate of the trajectory of vehicle is suitable or not
    p_vehicle_trajectory = function_check_dim(p_vehicle_trajectory);
    
else
    
    error('Only matrix supported! ')
    
end

%tau_0
tau_0 = vecnorm((p_vehicle_trajectory-p_BS).') ./ c0;

for aa = 1 : size(centers_IRS,1)
    
    %Calculate the propagation time between the i-th element of the IRS and the BS. 
    temp1 = vecnorm((centers_IRS(aa,:)-p_BS).') ./ c0; 

    %Calculate the propagation time between the vehicle and the i-th element of the IRS
    %every second, so size(temp2) = [1, total_time].
    temp2 = vecnorm((p_vehicle_trajectory-centers_IRS(aa,:)).') ./ c0;
    
    %size(tau_mn) = [MxN, total_time]. 
    tau_mn(aa,:) = (temp1+temp2).';
   
end

end
