function [A_star]=function_Astar(A_mn_vector)
% Author: Ke(Ken)WANG from Macao Polytechnic University
% Email: ke.wang@mpu.edu.mo, kewang0225@gmail.com
% Update infomation: v0.8(2022/June/25)

% License: This code is licensed under the GPLv2 license. If you in any way
% use this code for research that results in publications, please cite our
% original article.

temp_A_star_2 = [];

for k = 1 : size(A_mn_vector,2)

temp_A_star_1 = A_mn_vector(k) * (sum(A_mn_vector)-A_mn_vector(k));

temp_A_star_2 = [temp_A_star_2; temp_A_star_1 ];

end

A_star = sum(temp_A_star_2);

end