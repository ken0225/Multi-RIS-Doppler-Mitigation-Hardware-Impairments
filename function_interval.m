function [output_interval]=function_interval(S)
% Author: Ke(Ken)WANG from Macao Polytechnic University
% Email: ke.wang@mpu.edu.mo, kewang0225@gmail.com
% Update infomation: v0.8(2022/June/25)

% License: This code is licensed under the GPLv2 license. If you in any way
% use this code for research that results in publications, please cite our
% original article.
%
% Suppose we have an IRS with M x N elements, this function aims to
% calculate the smallest and biggest indices of M and N

%
% Example:
%
% [output_interval]=function_interval(8)
%
% output_interval =
% 
%     -3     4
    
    S_min = mod(S+1, 2) - floor(S/2);
    S_max = floor(S/2);
    
    assert(S_min == fix(S_min) & S_max == fix(S_max), 'the edges of interval are not integer!');
    
    output_interval = [fix(S_min), fix(S_max)];
    
end
