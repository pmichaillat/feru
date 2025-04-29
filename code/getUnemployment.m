%% getUnemployment
% 
% Return quarterly unemployment rate in the United States, 1930:Q1–2024:Q2
%
%% Syntax
%
%   u = getUnemployment(inputFolder)
%
%% Arguments
%
% * inputFolder - Character array with path to raw-data folder
% * u - 378-by-1 numeric column vector with unemployment rate
%
%% Description
%
% This function returns the quarterly unemployment rate in the United States, 1930:Q1–2024:Q2. 
%

function u = getUnemployment(inputFolder)

%% Get quarterly unemployment rate for three subperiods

% 1930:Q1–1950:Q4
uDepression = getUnemploymentDepression(inputFolder);

% 1951:Q1–2019:Q4
uPostwar = getUnemploymentPostwar(inputFolder);

% 2020:Q1–2024:Q2
uPandemic = getUnemploymentPandemic(inputFolder);

%% Splice three series into one continuous series

u = [uDepression; uPostwar; uPandemic];