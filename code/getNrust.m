%% getNrust
% 
% Return quarterly short-term NRU in the United States, 1949:Q1–2020:Q4
%
%% Syntax
%
%   nrust = getNrust(inputFolder)
%
%% Arguments
%
% * inputFolder - Character array with path to raw-data folder
% * nrust - 288-by-1 numeric column vector with short-term NRU
%
%% Description
%
% This function reads and returns the quarterly short-term NRU (natural/noncyclical rate of unemployment) in the United States, 1949:Q1–2020:Q4.
%
%% Data source
%
% * CBO (2021)
%

function nrust = getNrust(inputFolder)

% Read short-term NRU
nrust = readmatrix(fullfile(inputFolder, 'NROUST.csv'), 'Range', 'B2:B289') ./ 100;