%% getNairu
% 
% Return NAIRU in the United States, 1960Q1–2023Q4
%
%% Syntax
%
%   nairu = getNairu(inputFolder)
%
%% Arguments
%
% * inputFolder – Character array with path to raw-data folder
% * nairu - 256-by-1 numeric column vector with NAIRU
%
%% Description
%
% This function reads and returns the NAIRU (non-accelerating-inflation rate of unemployment) in the United States, 1960Q1–2023Q4.
%
%% Data source
%
% * Crump, Eusepi, Giannoni, and Sahin (2024)
%

function nairu = getNairu(inputFolder)

% Read NAIRU
nairu = readmatrix(fullfile(inputFolder, 'ustar.csv'), 'Range', 'C2:C257') ./ 100;