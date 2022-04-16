%% getElasticity
% 
% Return Beveridge elasticity in the United States, 1951:Q1–2019:Q4
%
%% Syntax
%
%   epsilon = getElasticity(inputFolder)
%
%% Arguments
%
% * inputFolder - Character array with path to raw-data folder
% * epsilon - 276-by-1 numeric column vector with Beveridge elasticity
%
%% Description
%
% This function reads and returns the elasticity of the Beveridge curve in the United States, 1951:Q1–2019:Q4.
%
%% Data source
%
% * Michaillat and Saez (2021a)
%

function epsilon = getElasticity(inputFolder)

% Read Beveridge elasticity
epsilon = readmatrix(fullfile(inputFolder, 'figure6.csv'), 'Range', 'C3:C278');