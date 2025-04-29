%% getRecessionPandemic
% 
% Return recession dates in the United States, 2020:Q1–2024:Q2
%
%% Syntax
%
%   [startRecession, endRecession] = getRecessionPandemic(inputFolder)
%
%% Arguments
%
% * inputFolder - Character array with path to raw-data folder
% * startRecession - 1-by-1 numeric column vector with recession start dates
% * endRecession - 1-by-1 numeric column vector with recession end dates
%
%% Description
%
% This function reads the peak dates and trough dates of US business cycles, 2020:Q1–2024:Q2. It then tranlates them into the start dates and end dates of US recessions: the first month of the recession is the month following the peak, and the last month of the recession is the month of the trough.
%
% The function then expresses the dates numerically in year.quarter format. For instance: 2020.0 is 2020:Q1, 2020.25 is 2020:Q2, 2020.5 is 2020:Q3, and 2020.75 is 2020:Q4.
%
%% Data source
%
% * NBER (2023)
%

function [startRecession, endRecession] = getRecessionPandemic(inputFolder)

% Read dates for cycle peaks and troughs
peakTable = readtable(fullfile(inputFolder, '20210719_cycle_dates_pasted.csv'), 'Range', 'A36:A36');
troughTable = readtable(fullfile(inputFolder, '20210719_cycle_dates_pasted.csv'), 'Range', 'B36:B36');

% Transform tables into datetime arrays
peakArray = table2array(peakTable);
troughArray = table2array(troughTable);

% Translate cycle peaks and troughs into recession starts and ends
startArray = peakArray + calmonths(1);
endArray = troughArray;

% Translate dates into numbers, rounded to the current quarter
startRecession = year(startArray) + floor((month(startArray) - 1) ./ 3) ./ 4; 
endRecession = year(endArray) + floor((month(endArray) - 1) ./ 3) ./ 4;