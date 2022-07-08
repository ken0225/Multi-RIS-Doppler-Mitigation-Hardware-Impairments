function [SE_IRS_HWI_HA_MC]=function_compute_SE(signal_HWI_HA_total_all_Realization, Pt, N0, kappa_t, kappa_r)
% Author: Ke(Ken)WANG from Macao Polytechnic University
% Email: ke.wang@mpu.edu.mo, kewang0225@gmail.com
% Update infomation: v0.8(2022/June/25)

% License: This code is licensed under the GPLv2 license. If you in any way
% use this code for research that results in publications, please cite our
% original article.

receiver_power_all_Realization = Pt .* (abs(signal_HWI_HA_total_all_Realization)) .^ 2;

SNR_IRS_HWI_HA_MC = receiver_power_all_Realization ./ ...
    (kappa_t .* receiver_power_all_Realization + kappa_r .* receiver_power_all_Realization + N0);

SE_IRS_HWI_HA_MC = mean(log2(1 + SNR_IRS_HWI_HA_MC),1);

end