function [Q]=function_Q(A_0, A_star, A_mn_vector, a_HWI)
% Author: Ke(Ken)WANG from Macao Polytechnic University
% Email: ke.wang@mpu.edu.mo, kewang0225@gmail.com
% Update infomation: v0.8(2022/June/25)

% License: This code is licensed under the GPLv2 license. If you in any way
% use this code for research that results in publications, please cite our
% original article.

Q = (A_0)^2 + (sinc(a_HWI/pi))^2 * A_star + sum(A_mn_vector.^2) + 2*A_0*sinc(a_HWI/pi)*sum(A_mn_vector); 

end