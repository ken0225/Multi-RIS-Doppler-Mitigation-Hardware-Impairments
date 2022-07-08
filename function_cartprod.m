function X = function_cartprod(varargin)
%  CARTPROD Cartesian product of multiple sets.
%  https://ww2.mathworks.cn/matlabcentral/fileexchange/5475-cartprod-cartesian-product-of-multiple-sets
%   X = CARTPROD(A,B,C,...) returns the cartesian product of the sets
%   A,B,C, etc, where A,B,C, are numerical vectors.
%
%   Example: A = [-1 -3 -5];   B = [10 11];   C = [0 1];
%
%   X = cartprod(A,B,C)
%   X =
%
%     -5    10     0
%     -3    10     0
%     -1    10     0
%
%   This function requires IND2SUBVECT, also available (I hope) on the MathWorks
%   File Exchange site.


numSets = length(varargin);

for i = 1 : numSets
    
    thisSet = sort(varargin{i});
    
    if ~isequal(numel(thisSet), length(thisSet))
        error('All inputs must be vectors.')
    end
    
    if ~isnumeric(thisSet)
        error('All inputs must be numeric.')
    end
    
    if ~isequal(thisSet,unique(thisSet))
        error(['Input set' ' ' num2str(i) ' ' 'contains duplicated elements.'])
    end
    
    sizeThisSet(i) = length(thisSet);
    
    varargin{i} = thisSet;
    
end

X = zeros(prod(sizeThisSet), numSets);

for i = 1 : size(X, 1)
    
    ixVect = ind2subVect(sizeThisSet, i);
    
    for j = 1 : numSets
        X(i, j) = varargin{j}(ixVect(j));
    end
    
end

end

function X = ind2subVect(siz,ndx)

n = length(siz);

k = [1, cumprod(siz(1 : end-1))];

ndx = ndx - 1;

for i = n : -1 : 1
    X(i) = floor(ndx/k(i)) + 1;
    ndx = rem(ndx,k(i));
end

end
