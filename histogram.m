% HISTOGRAM  Creates a multi-dimensional histogram.
% GNU General Public License Software Copyright: Kevin H. Knuth 2008
%
% HISTOGRAM bins the elements of the array Y into a set of containers
%           in a multi-dimensional space, and returns the number of 
%           elements in each container.
%
%   Usage:  counts = histogram(Y,M)
%           [counts, binwidth, centers] = histogram(Y,M)
%
%   Y is a D x N array  D-dimensional data with N data points
%   M is a 1 x D array  number of bins for each dimension
%   Y(i,:) is the ith datum point.
%   M(j) is the number of bins in the jth dimension
%
%   counts is an array of bin counts with dimensions dictated by M
%   binwidth in the dth dimension is binwidth(d)
%   centers is a cell array of the bin centers
%   The dth dimensional component of the center coordinate of the bins are 
%   found by: centers{d} 
%
%   Created by Kevin H. Knuth on 15 August 2003
%   Polished, tested and documented by Kevin H. Knuth on 5 April 2008

function [counts, binwidth, centers] = histogram(Y,M)

if (nargin ~= 2)
    error('Requires two input arguments.')
end

[D, N] = size(Y);

if (length(M) ~= D)
    error('The dimensions of the data and the bin number array disagree.');
end

% find the extrema
ymin = zeros(1,D);
ymax = zeros(1,D);
for d = 1:D
    ymax(d) = max(Y(d,:));
    ymin(d) = min(Y(d,:));
end

% define the bin edges
% the extreme bins go off to infinity
edges = zeros(D,max(M));
binwidth = (ymax-ymin)./M;
for d = 1:D
    m = M(d)-1;
    edges(d,1:M(d)-1) = binwidth(d)*(1:m)+ymin(d);
    edges(d,M(d)) = Inf;  % the rightmost bin edge is at negative Infinty
end




% obtain the counts %%%%%%%%%%%%%%%%%%%%%%%%%
if D == 1
    counts = zeros(1,M);
else
    counts = zeros(M);
end

% setup indexing factors
% See: Programming and Data Types: M-File Programming: Advanced Indexing
factors = ones(1,D);
for d = 1:D-1
    factors(d+1:D) = factors(d+1:D)*M(d);
end

for n = 1:N

    % get the multidimensional bin coordinates of each data point
    bin = zeros(1,D);
    for d = 1:D
        % determine which bin the count belongs in for each dimension 
        % (these are its coords in the count array)
        % I go through these from right to left to ensure that this 
        % algorithm is consistent with hist.m
        for m = 1:M(d)  %loop through all the bins in this dimension
            if (Y(d,n) <= edges(d,m))
                bin(d) = m;
                break;
            end
        end
    end
    
    % now add a count to that bin
    index = factors * (bin-1)' + 1;
    counts(index) = counts(index)+1;
end
    


% define the bin centers
centers = cell(D);
for d = 1:D
    centers(d) = {(binwidth(d)*((1:M(d))-1)+ymin(d))+binwidth(d)/2};
end


return;
