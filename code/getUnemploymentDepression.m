%% getUnemploymentDepression
% 
% Return quarterly unemployment rate in the United States, 1930:Q1–1950:Q4
%
%% Syntax
%
%   u = getUnemploymentDepression(inputFolder)
%
%% Arguments
%
% * inputFolder - Character array with path to raw-data folder
% * u - 84-by-1 numeric column vector with unemployment rate
%
%% Description
%
% This function reads the monthly unemployment rate in the United States, 1930:Q1–1950:Q4, and returns the quarterly average of the series. 
%
%% Data source
%
% * Petrosky-Nadeau and Zhang (2021)
%

function u = getUnemploymentDepression(inputFolder)

% Read monthly unemployment rate
uMonthly = readmatrix(fullfile(inputFolder, 'HistoricalSeries_JME_2020January.csv'), 'Range', 'B486:B737') ./ 100;

% Take quarterly average of monthly series
u = monthly2quarterly(uMonthly);