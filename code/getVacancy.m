%% getVacancy
% 
% Return quarterly vacancy rate in the United States, 1930Q1–2024Q2
%
%% Syntax
%
%   v = getVacancy(inputFolder)
%
%% Arguments
%
% * inputFolder - Character array with path to raw-data folder
% * v - 378-by-1 numeric column vector with vacancy rate
%
%% Description
%
% This function returns the quarterly vacancy rate in the United States, 1930Q1–2024Q2. 
%

function v = getVacancy(inputFolder)

%% Get quarterly vacancy rate for three subperiods

% 1930Q1–1950Q4
vDepression = getVacancyDepression(inputFolder);

% 1951Q1–2019Q4
vPostwar = getVacancyPostwar(inputFolder);

% 2020Q1–2024Q2
vPandemic = getVacancyPandemic(inputFolder);

%% Splice the three series into one continuous series

v = [vDepression; vPostwar; vPandemic];