%% getUnemploymentPandemic
% 
% Return quarterly unemployment rate in the United States, 2020:Q1–2024:Q2
%
%% Syntax
%
%   u = getUnemploymentPandemic(inputFolder)
%
%% Arguments
%
% * inputFolder - Character array with path to raw-data folder
% * u - 18-by-1 numeric column vector with unemployment rate
%
%% Description
%
% This function reads the monthly unemployment rate in the United States, 2020:Q1–2024:Q2, and returns the quarterly average of the series. 
%
%% Data source
%
% * BLS (2024k)
%

function u = getUnemploymentPandemic(inputFolder)

% Read monthly unemployment rate
uMonthly = readmatrix(fullfile(inputFolder, 'UNRATE.csv'), 'Range', 'B866:B919') ./ 100;

% Take quarterly average of monthly series
u = monthly2quarterly(uMonthly);