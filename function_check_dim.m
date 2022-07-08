function [coordinate_of_p_3D] = function_check_dim(coordinate_of_p)
% Author: Ke(Ken)WANG from Macao Polytechnic University
% Email: ke.wang@mpu.edu.mo, kewang0225@gmail.com
% Update infomation: v0.8(2022/June/25)

% License: This code is licensed under the GPLv2 license. If you in any way
% use this code for research that results in publications, please cite our
% original article.
%
% This function aims to check the 3D coordinate; We define
% each row of a matrix stands for a 3D coordinate. In other words, coordinate_of_p_3D
% must be a 3 x X matrix.

%
% The INPUT is the coordinate and the OUTPUT is a 3D coordinate.
%
% Example:
%
% coordinate_of_p = eye(2,3); function_check_dim(coordinate_of_p)
%
% ans =
%
%      1     0     0
%      0     1     0

size_coordinate_of_p = size(coordinate_of_p);

if ismatrix(coordinate_of_p)
    
    if size_coordinate_of_p(2) == 3
        
        coordinate_of_p_3D = coordinate_of_p;
        
    elseif size_coordinate_of_p(1) == 3
        
        coordinate_of_p_3D = coordinate_of_p.';
        
    else
        
        error('The input is NOT an Euclidean vector.')
        
    end
    
else
    
    error('Only matrix supported.')
    
end

end
