%% main.m
% 
% Main script
%
%% Description
%
% This is the main script for the paper. It constructs the 30 figures and  associated numerical results included in the paper.
%
%% Output
%
% * The figures are saved as PDF files.
% * The figure data are saved as CSV files.
% * The numerical results are saved as Markdown files.
%

%% Clear MATLAB

% Close figure windows
close all

% Clear workspace
clear

% Clear command window
clc

%% Specify input and output folders

% Specify folder with raw data
inputFolder = fullfile('..', 'raw');

% Specify folder with figures and numerical results
outputFolder = fullfile('..', 'figures');

%% Format default figure and predefine figure properties

formatFigure

%% Produce and save figures and associated numerical results

figure1A
figure1B
figure2
figure3A
figure3B
figure4A
figure4B
figure5A
figure5B
figure6A
figure6B
figure7A
figure7B
figure8A
figure8B
figure9A
figure9B
figure10
figure11
figure12
figure13A
figure13B
figure14A
figure14B
figure15