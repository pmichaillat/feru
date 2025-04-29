%% getUnemploymentPostwar
% 
% Return quarterly unemployment rate in the United States, 1951:Q1–2019:Q4
%
%% Syntax
%
%   u = getUnemploymentPostwar(inputFolder)
%
%% Arguments
%
% * inputFolder - Character array with path to raw-data folder
% * u - 276-by-1 numeric column vector with unemployment rate
%
%% Description
%
% This function reads the monthly unemployment rate in the United States, 1951:Q1–2019:Q4, and returns the quarterly average of the series. 
%
%% Data source
%
% * BLS (2024k)
%

function u = getUnemploymentPostwar(inputFolder)

% Read monthly unemployment rate
uMonthly = readmatrix(fullfile(inputFolder, 'UNRATE.csv'), 'Range', 'B38:B865') ./ 100;

% Take quarterly average of monthly series
u = monthly2quarterly(uMonthly);