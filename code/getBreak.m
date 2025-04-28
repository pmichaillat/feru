%% getBreak
% 
% Return break dates for US Beveridge curve, 1951Q1–2019Q4
%
%% Syntax
%
%   breakDate = getBreak(inputFolder)
%
%% Arguments
%
% * inputFolder - Character array with path to raw-data folder
% * breakDate - 5-by-1 numeric column vector with break dates
%
%% Description
%
% This function reads and returns the dates of the structural breaks in the US Beveridge curve between 1951Q1 and 2019Q4. The dates are expressed numerically in year.quarter format. For instance, 1951.0 is 1951Q1, 1951.25 is 1951Q2, 1951.5 is 1951Q3, and 1951.75 is 1951Q4.
%
%
%% Data source
%
% * Michaillat and Saez (2021a)
%

function breakDate = getBreak(inputFolder)

% Read Beveridge elasticity
breakDate = readmatrix(fullfile(inputFolder, 'figure5.csv'), 'Range', 'A3:A7');