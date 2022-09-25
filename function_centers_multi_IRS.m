function [output_centers_IRS]=function_centers_multi_IRS(total_elements_number, dx, dy, K, spacing, h_IRS)
% Author: Ke(Ken)WANG from Macao Polytechnic University
% Email: ke.wang@mpu.edu.mo, kewang0225@gmail.com
% Update infomation: v0.8(2022/June/25)

% License: This code is licensed under the GPLv2 license. If you in any way
% use this code for research that results in publications, please cite our
% original article.

M = sqrt(total_elements_number/K);
N = M;

a = linspace(-K/2,-1,K/2);
b = linspace(1,K/2,K/2);
temp_K = [a,b];
temp_K_spacing = [temp_K(temp_K<0)+0.5, temp_K(temp_K>0)-0.5]*spacing;

output_centers_IRS  = [];

for kk = 1:K
    
    [temp_center_IRS]=function_centers_single_IRS(M, N, dx, dy);
    
    temp_center_IRS(:,1) = temp_center_IRS(:,1) + temp_K_spacing(kk);
    
    output_centers_IRS = [output_centers_IRS; temp_center_IRS];

end

function [output_centers_IRS]=function_centers_multi_IRS_v2(total_elements_number, dx, dy, K, spacing, h_IRS)

M = sqrt(total_elements_number/K);
N = M;

a = linspace(-K/2,-1,K/2);
b = linspace(1,K/2,K/2);
temp_K = [a,b];
temp_K_spacing = [temp_K(temp_K<0)+0.5, temp_K(temp_K>0)-0.5]*spacing;

output_centers_IRS  = [];

for kk = 1:K
    
    [temp_center_IRS]=function_centers_single_IRS(M, N, dx, dy);
    
    temp_center_IRS(:,1) = temp_center_IRS(:,1) + temp_K_spacing(kk);
    
    output_centers_IRS = [output_centers_IRS; temp_center_IRS];

end

output_centers_IRS(:,2) = output_centers_IRS(:,2) + h_IRS;

end



