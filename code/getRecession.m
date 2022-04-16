%% getRecession
% 
% Return recession dates in the United States, 1930:Q1–2024:Q2
%
%% Syntax
%
%   [startRecession, endRecession] = getRecession(inputFolder)
%
%% Arguments
%
% * inputFolder - Character array with path to raw-data folder
% * startRecession - 15-by-1 numeric column vector with recession start dates
% * endRecession - 15-by-1 numeric column vector with recession end dates
%
%% Description
%
% This function returns the start dates and end dates of US recessions between 1930:Q1 and 2024:Q2.
%
% The dates are expressed numerically in year.quarter format. For instance, 1951.0 is 1951:Q1, 1951.25 is 1951:Q2, 1951.5 is 1951:Q3, and 1951.75 is 1951:Q4.
%

function [startRecession, endRecession] = getRecession(inputFolder)

%% Get recession dates for three subperiods

% 1930:Q1–1950:Q4
[startDepression, endDepression]  = getRecessionDepression(inputFolder);

% 1951:Q1–2019:Q4
[startPostwar, endPostwar]  = getRecessionPostwar(inputFolder);

% 2020:Q1–2024:Q2
[startPandemic, endPandemic]  = getRecessionPandemic(inputFolder);

%% Splice three series into one continuous series

startRecession = [startDepression; startPostwar; startPandemic];
endRecession = [endDepression; endPostwar; endPandemic];