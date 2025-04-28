%% getUnemployment
% 
% Return quarterly unemployment rate in the United States, 1930Q1–2024Q2
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
% This function returns the quarterly unemployment rate in the United States, 1930Q1–2024Q2. 
%

function u = getUnemployment(inputFolder)

%% Get quarterly unemployment rate for three subperiods

% 1930Q1–1950Q4
uDepression = getUnemploymentDepression(inputFolder);

% 1951Q1–2019Q4
uPostwar = getUnemploymentPostwar(inputFolder);

% 2020Q1–2024Q2
uPandemic = getUnemploymentPandemic(inputFolder);

%% Splice three series into one continuous series

u = [uDepression; uPostwar; uPandemic];