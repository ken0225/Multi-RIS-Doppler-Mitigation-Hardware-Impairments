function [S_0]=function_S0(A_0, tau_0) 
% Author: Ke(Ken)WANG from Macao Polytechnic University
% Email: ke.wang@mpu.edu.mo, kewang0225@gmail.com
% Update infomation: v0.8(2022/June/25)

% License: This code is licensed under the GPLv2 license. If you in any way
% use this code for research that results in publications, please cite our
% original article.
%
% This function aims to calculate S_0(t), i.e., eq(4) in the GC paper 2021

%
% Example:
%
% TBD

global fc;

%Eq(4) in the GC paper 2021
%Note that the $\sqrt{P_t}$ is not included here. Instead, we multiply
%it when we finally calculate the received power 
S_0 = A_0.*exp(-1i*2*pi*fc.*tau_0);

end