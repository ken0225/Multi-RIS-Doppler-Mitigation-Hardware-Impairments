function [output_centers_IRS]=function_centers_multi_IRS(total_elements_number, dx, dy, K, spacing, h_IRS)

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



