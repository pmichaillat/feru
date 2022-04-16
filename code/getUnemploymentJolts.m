%% getUnemploymentJolts
% 
% Return quarterly unemployment rate in the United States, 2001:Q1–2024:Q2
%
%% Syntax
%
%   u = getUnemploymentJolts(inputFolder)
%
%% Arguments
%
% * inputFolder - Character array with path to raw-data folder
% * u - 94-by-1 numeric column vector with unemployment rate
%
%% Description
%
% This function reads the monthly unemployment rate in the United States, 2001:Q1–2024:Q2, and returns the quarterly average of the series. 
%
%% Data source
%
% * BLS (2024k)
%

function u = getUnemploymentJolts(inputFolder)

% Read monthly unemployment rate
uMonthly = readmatrix(fullfile(inputFolder, 'UNRATE.csv'), 'Range', 'B638:B919') ./ 100;

% Take quarterly average of monthly series
u = monthly2quarterly(uMonthly);