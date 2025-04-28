%% monthly2quarterly
%
% Convert monthly data to quarterly data
%
%% Syntax
%
%   result = monthly2quarterly(data)
%
%% Arguments
%
% If the function is applied to a single series:
%
% * data - N-by-1 numeric column vector
% * result - (N/3)-by-1 numeric column vector
% 
% If the function is applied to M series:
%
% * data - N-by-M numeric matrix
% * result - (N/3)-by-M numeric matrix
%
%% Description
%
% This function averages the monthly series contained in data to convert them to quarterly series. The series must be arranged by columns. For each series, the observations must start at the beginning of a quarter and stop at the end of another quarter, so the number of observations must be divisible by 3.
%
% Each element of result corresponds to a quarterly observation. It is the average of 3 consecutive monthly observations for a given series j: result(i,j) = [data(3*i+1,j) + data(3*i+2,j) + data(3*i+3,j)] / 3.
% 
%% Example
%
% We create a monthly series and convert it to quarterly frequency.
%
%   data = [1; 2; 3; 2; 3; 4];
%   result = monthly2quarterly(data);
%
% The output is the following:
% 
%   result = [2; 3]
%

function result = monthly2quarterly(data)

[row, col] = size(data);

% Check that the number of observations is divisible by 3
assert(mod(row,3) == 0, 'Number of monthly observations must be divisible by 3 for quarterly conversion.')

% Reshape the dataset so that L(:,i,j) contains the 3 monthly observations from series j in quarter i
L = reshape(data, 3, row/3, col);

% Average the 3 monthly observations in L(:,i,j) for all series in all quarters
M = mean(L, 1);

% Shift the dimensions of M so that the series are organized by columns again
result = shiftdim(M);