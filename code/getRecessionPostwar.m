%% getRecessionPostwar
% 
% Return recession dates in the United States, 1951:Q1–2019:Q4
%
%% Syntax
%
%   [startRecession, endRecession] = getRecessionPostwar(inputFolder)
%
%% Arguments
%
% * inputFolder - Character array with path to raw-data folder
% * startRecession - 10-by-1 numeric column vector with recession start dates
% * endRecession - 10-by-1 numeric column vector with recession end dates
%
%% Description
%
% This function reads the peak dates and trough dates of US business cycles, 1951:Q1–2019:Q4. It then tranlates them into the start dates and end dates of US recessions: the first month of the recession is the month following the peak, and the last month of the recession is the month of the trough.
%
% The function then expresses the dates numerically in year.quarter format. For instance, 1951.0 is 1951:Q1, 1951.25 is 1951:Q2, 1951.5 is 1951:Q3, and 1951.75 is 1951:Q4.
%
%% Data source
%
% * NBER (2023)
%

function [startRecession, endRecession] = getRecessionPostwar(inputFolder)

% Read dates for cycle peaks and troughs
peakTable = readtable(fullfile(inputFolder, '20210719_cycle_dates_pasted.csv'), 'Range', 'A26:A35');
troughTable = readtable(fullfile(inputFolder, '20210719_cycle_dates_pasted.csv'), 'Range', 'B26:B35');

% Transform tables into datetime arrays
peakArray = table2array(peakTable);
troughArray = table2array(troughTable);

% Translate cycle peaks and troughs into recession starts and ends
startArray = peakArray + calmonths(1);
endArray = troughArray;

% Translate dates into numbers, rounded to the current quarter
startRecession = year(startArray) + floor((month(startArray) - 1) ./ 3) ./ 4; 
endRecession = year(endArray) + floor((month(endArray) - 1) ./ 3) ./ 4;