%% getData345
% 
% Return quarterly unemployment and vacancy rates associated with U3, U4, U5 concepts in the United States, 1994:Q1–2024:Q2
%
%% Syntax
%
%   [u3, u4, u5, v3, v4, v5] = getData345(inputFolder)
%
%% Arguments
%
% * inputFolder - Character array with path to raw-data folder
% * u3 - 122-by-1 numeric column vector with unemployment rate u3
% * v3 - 122-by-1 numeric column vector with vacancy rate v3
% * u4 - 122-by-1 numeric column vector with unemployment rate u4
% * v4 - 122-by-1 numeric column vector with vacancy rate v4
% * u5 - 122-by-1 numeric column vector with unemployment rate u5
% * v5 - 122-by-1 numeric column vector with vacancy rate v5
%
%% Description
%
% This function produces various quarterly unemployment rates in the United States, 1994:Q1–2024:Q2:
%
% * u3 - Unemployment rate based on U3 concept
% * u4 - Unemployment rate based on U4 concept
% * u5 - Unemployment rate based on U5 concept
%
% Given that the different concepts of unemployment lead to different measures of the labor force, the vacancy rate = vacancy level / labor force level must be adjusted for consistency when different unemployment concepts are used:
%
% * v3 - Vacancy rate consistent with the U3 concept
% * v4 - Vacancy rate consistent with the U4 concept
% * v5 - Vacancy rate consistent with the U5 concept
%
% The vacancy rates are built from the same vacancy level but different labor force levels:
%
% * v3 = vacancy level / standard labor force
% * v4 = vacancy level / [standard labor force + discouraged workers]
% * v5 = vacancy level / [standard labor force + marginally attached workers]
%
%% Data source
%
% * Monthly U3 unemployment rate - BLS (2024k)
% * Monthly U4 unemployment rate - BLS (2024i)
% * Monthly U5 unemployment rate - BLS (2024j)
% * Monthly labor force participants - BLS (2024a)
% * Monthly discouraged workers - BLS (2024g)
% * Monthly marginally attached workers - BLS (2024h)
%

function [u3, u4, u5, v3, v4, v5] = getData345(inputFolder)

%% Produce unemployment rates	

% Read monthly U3 unemployment rate
u3Monthly = readmatrix(fullfile(inputFolder, 'UNRATE.csv'), 'Range', 'B554:B919') ./ 100;

% Read monthly U4 unemployment rate
u4Monthly = readmatrix(fullfile(inputFolder, 'U4RATE.csv'), 'Range', 'B2:B367') ./ 100;

% Read monthly U5 unemployment rate
u5Monthly = readmatrix(fullfile(inputFolder, 'U5RATE.csv'), 'Range', 'B2:B367') ./ 100;

% Take quarterly average of monthly series
u3 = monthly2quarterly(u3Monthly);
u4 = monthly2quarterly(u4Monthly);
u5 = monthly2quarterly(u5Monthly);

%% Compute labor force levels

% Read monthly number of labor force participants
laborforce3Monthly = readmatrix(fullfile(inputFolder, 'CLF16OV.csv'), 'Range', 'B554:B919');

% Read monthly number of discouraged workers
discouragedMonthly = readmatrix(fullfile(inputFolder, 'LNU05026645.csv'), 'Range', 'B2:B367');

% Read monthly number of marginally attached workers
marginalMonthly = readmatrix(fullfile(inputFolder, 'LNU05026642.csv'), 'Range', 'B2:B367');

% Take quarterly average of monthly series
laborforce3 = monthly2quarterly(laborforce3Monthly);
discouraged = monthly2quarterly(discouragedMonthly);
marginal = monthly2quarterly(marginalMonthly);

% Compute labor force level consistent with U4
laborforce4 = laborforce3 + discouraged;

% Compute labor force level consistent with U5
laborforce5 = laborforce3 + marginal;

%% Produce vacancy rates

% Get quarterly vacancy rate from a longer dataset (1930:Q1–2024:Q2)
vRate1930 = getVacancy(inputFolder);

% Extract quarterly vacancy rate for 1994:Q1–2024:Q2
n = numel(u3);
vRate = vRate1930(end - n + 1 : end);

% Convert vacancy rate to vacancy level
vLevel = vRate .* laborforce3;

% Compute vacancy rate consistent with U3
v3 = vLevel ./ laborforce3;

% Compute vacancy rate consistent with U4
v4 = vLevel ./ laborforce4;

% Compute vacancy rate consistent with U5
v5 = vLevel ./ laborforce5;