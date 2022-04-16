%% getVacancyPostwar
% 
% Return quarterly vacancy rate in the United States, 1951:Q1–2019:Q4
%
%% Syntax
%
%   v = getVacancyPostwar(inputFolder)
%
%% Arguments
%
% * inputFolder - Character array with path to raw-data folder
% * v - 276-by-1 numeric column vector with vacancy rate
%
%% Description
%
% This function constructs and returns the quarterly vacancy rate for the United States, 1951:Q1–2019:Q4:
%
% * Reads the monthly vacancy rate, 1951:Q1–2000:Q4
% * Reads the monthly vacancy and labor force levels, 2001:Q1–2019:Q4
% * Calculates the monthly vacancy rate, 2001:Q1–2019:Q4, by dividing vacancy level by labor force level 
% * Produces the monthly vacancy rate, 1951:Q1–2019:Q4, by splicing the two monthly vacancy-rate series
% * Returns the quarterly average of the monthly vacancy rate 
%
%% Data source
%
% * Monthly vacancy rate, 1951:Q1–2000:Q4 - Barnichon (2010)
% * Monthly vacancy level, 2001:Q1–2019:Q4 - BLS (2024f)
% * Monthly labor force level, 2001:Q1–2019:Q4 - BLS (2024a)
%

function v = getVacancyPostwar(inputFolder)

% Read monthly vacancy rate for 1951:Q1–2000:Q4
vRate1951 = readmatrix(fullfile(inputFolder, 'CompositeHWI.xlsx - Sheet1.csv'), 'Range', 'C9:C608') ./ 100;

% Read monthly vacancy level for 2001:Q1–2019:Q4
vLevel2001 = readmatrix(fullfile(inputFolder, 'JTSJOL.csv'), 'Range', 'B2:B229');

% Read monthly labor force level for 2001:Q1–2019:Q4
laborforce = readmatrix(fullfile(inputFolder, 'CLF16OV.csv'), 'Range', 'B638:B865');

% Compute monthly vacancy rate for 2001:Q1–2019:Q4
vRate2001 = vLevel2001 ./ laborforce;

% Splice monthly vacancy rates for 1951:Q1–2000:Q4 and 2001:Q1–2019:Q4
vMonthly = [vRate1951; vRate2001];

% Take quarterly average of monthly series for 1951:Q1–2019:Q4
v = monthly2quarterly(vMonthly);