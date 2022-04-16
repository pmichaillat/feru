%% getVacancyDepression
% 
% Return quarterly vacancy rate in the United States, 1930:Q1–1950:Q4
%
%% Syntax
%
%   v = getVacancyDepression(inputFolder)
%
%% Arguments
%
% * inputFolder - Character array with path to raw-data folder
% * v - 84-by-1 numeric column vector with vacancy rate
%
%% Description
%
% This function reads the monthly vacancy rate in the United States, 1930:Q1–1950:Q4, and returns the quarterly average of the series. 
%
%% Data source
%
% * Petrosky-Nadeau and Zhang (2021)
%

function v = getVacancyDepression(inputFolder)

% Read monthly vacancy rate
vMonthly = readmatrix(fullfile(inputFolder, 'HistoricalSeries_JME_2020January.csv'), 'Range', 'D486:D737') ./ 100;

% Take quarterly average of monthly series
v = monthly2quarterly(vMonthly);