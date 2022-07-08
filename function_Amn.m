function [A_mn_sum, A_mn_matrix]=function_Amn(p_BS, centers_IRS, p_vehicle_trajectory, total_time, dx, dy)
% Author: Ke(Ken)WANG from Macao Polytechnic University
% Email: ke.wang@mpu.edu.mo, kewang0225@gmail.com
% Update infomation: v0.8(2022/June/25)

% License: This code is licensed under the GPLv2 license. If you in any way
% use this code for research that results in publications, please cite our
% original article.

%
% Example:
%
% TBD

global c0 fc total_elements_number;

lambda_c = c0/fc;

%Note that p2 is IRS and p1 is BS. This gain is $G_T^{mn}$
%This is the gain from BS to IRS, that means this gain always euqals to 1
%since we assume the transceiver is isotropic
G_BS_to_IRS_direction = function_antenna_gain_TR(total_elements_number); 

%This gain is $G_{mn}^T$. If the IRS is isotropic, the gain is 1, otherwise we use
%"function_gain_IRS" to calculate the gain. 
G_IRS_to_BS_direction = function_gain_IRS(total_elements_number);

%The first half part of eq(6)
A_BS_IRS = lambda_c/(4*pi) * sqrt(G_BS_to_IRS_direction.*G_IRS_to_BS_direction)./vecnorm((centers_IRS-p_BS)');  

A_mn_sum = [];

A_IRS_Vehicle = [];

A_mn_matrix = []; % size(A_mn_matrix) = total_time x M*N

G_Vehicle_to_IRS_direction=[];

G_IRS_to_Vehicle_direction=[];

%This for-loop aims to calculate $G_R^{mn}(t)$ and $G_{mn}^R(t)$ in eq(6)
%and its above content in the GC paper 2021
for t = 1 : total_time
    
    %This is the gain from Vehicle to IRS, $G_R^{mn}(t)$. That means this gain always euqals to 1
    %since we assume the transceiver is isotropic
    temp_G_Vehicle_to_IRS_direction = function_antenna_gain_TR(total_elements_number);
    G_Vehicle_to_IRS_direction =[G_Vehicle_to_IRS_direction; temp_G_Vehicle_to_IRS_direction];
    
    %This is the gain from IRS to Vehicle, $G_{mn}^R(t)$. If the IRS is isotropic, the gain is 1, otherwise we use
    %"function_gain_IRS" to calculate the gain. 
    temp_G_IRS_to_Vehicle_direction = function_gain_IRS(total_elements_number);
    G_IRS_to_Vehicle_direction =[G_IRS_to_Vehicle_direction; temp_G_IRS_to_Vehicle_direction];
    
end

%This for-loop aims to calculate $A_{m,n}$, i.e., eq(6), the GC paper 2021
for t = 1 : total_time
    
    %The second half part of eq(6)
    A_IRS_Vehicle = ...
        lambda_c/(4*pi) * sqrt(G_Vehicle_to_IRS_direction(t,:)...
        .*G_IRS_to_Vehicle_direction(t,:)) ./ vecnorm((p_vehicle_trajectory(t,:)-centers_IRS).'); 
    
    %The entire eq(6) in the GC paper 2021
    temp_A_mn_sum = sum(A_BS_IRS .* A_IRS_Vehicle); 
    A_mn_sum = [A_mn_sum; temp_A_mn_sum];
    
    %We also want to get a matrix that contains the exact gain of every
    %element during total time. It helps calculate the approximation of the
    %SE
    temp_A_mn_matrix = A_BS_IRS .* A_IRS_Vehicle; 
    A_mn_matrix = [A_mn_matrix; temp_A_mn_matrix];
    
end


end
