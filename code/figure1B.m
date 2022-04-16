%% figure1B.m
% 
% Produce panel B of figure 1
%
%% Description
%
% This script produces panel B of figure 1. The figure displays on a log scale the unemployment and vacancy rates in the United States, 1951:Q1–2019:Q4.
%
%% Requirements
%
% * inputFolder - Path to input folder (default: defined in main.m)
% * outputFolder - Path to output folder (default: defined in main.m)
% * formatFigure.m - Predefine figure properties (default: run in main.m)
%
%% Output
%
% * figure1B.pdf - PDF file with panel B of figure 1
% * figure1B.csv - CSV file with data underlying panel B of figure 1
%

%% Construct figure name and paths to output files

% Define figure ID
figureId = '1B';

% Construct figure name
figureName = ['Figure ', figureId];

% Construct paths to output files
figureFile = fullfile(outputFolder, ['figure', figureId, '.pdf']);
dataFile = fullfile(outputFolder, ['figure', figureId, '.csv']);

%% Get data

% Generate quarterly timeline based on data range
timeline = [1951 : 0.25 : 2019.75]';

% Get recession dates
[startRecession, endRecession] = getRecessionPostwar(inputFolder);

% Get unemployment rate
u = getUnemploymentPostwar(inputFolder);

% Get vacancy rate
v = getVacancyPostwar(inputFolder);

%% Produce figure

% Set up figure window
figure('NumberTitle', 'off', 'Name', figureName)
hold on

% Format x-axis
ax = gca;
set(ax, postwarAxis{:})

% Format y-axis
ax.YLim = log([0.01, 0.12]);
ax.YTick = log([0.01, 0.02 : 0.02 : 0.12]);
ax.YTickLabel = ["1"; "2"; "4"; "6"; "8"; "10"; "12"];
ax.YLabel.String = 'Share of labor force (percent on log scale)';

% Shade recession areas
xregion(startRecession, endRecession, grayArea{:})

% Plot log unemployment and vacancy rates
plot(timeline, log(u), purpleLine{:})
plot(timeline, log(v), orangeDotDashLine{:})

% Save figure
print('-dpdf', figureFile)

%% Save figure data

% Write header
header = {'Year', 'Log unemployment rate', 'Log vacancy rate'};
writecell(header, dataFile, 'WriteMode', 'overwrite')

% Write results
data = [timeline, log(u), log(v)];
writematrix(round(data, 4), dataFile, 'WriteMode', 'append')