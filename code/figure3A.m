%% figure3A.m
% 
% Produce panel A of figure 3
%
%% Description
%
% This script produces panel A of figure 3. The figure displays the gap between the quarterly unemployment and vacancy rates in the United States, 1951Q1–2019Q4.
%
%% Requirements
%
% * inputFolder - Path to the input folder (default: defined in main.m)
% * outputFolder - Path to the output folder (default: defined in main.m)
% * formatFigure.m - Script for plot formatting (default: run in main.m)
%
%% Output
%
% * figure3A.pdf - PDF file with panel A of figure 3
% * figure3A.csv - CSV file with data underlying panel A of figure 3
%

%% Specify figure name and output files

% Define figure number
number = '3A';

% Construct figure name
figureName = ['Figure ', number];

% Construct file names
figureFile = fullfile(outputFolder, ['figure', number, '.pdf']);
dataFile = fullfile(outputFolder, ['figure', number, '.csv']);

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

figure('NumberTitle', 'off', 'Name', figureName)
hold on

% Format x-axis
ax = gca;
set(ax, xPostwar{:})

% Format y-axis
ax.YLim = [0, 0.12];
ax.YTick = [0 : 0.02 : 0.12];
ax.YTickLabel = [' 0'; ' 2'; ' 4'; ' 6'; ' 8'; '10'; '12'];
ax.YLabel.String = 'Share of labor force (percent)';

% Paint recession areas
xregion(startRecession, endRecession, grayArea{:})

% Paint gap between unemployment and vacancy rates with distinct colors for positive and negative gaps
h = area(timeline, [v, max(u - v, 0), min(u - v, 0)]);
set(h, {'FaceAlpha', 'FaceColor', 'LineStyle'}, purpleOrangeArea);

% Plot unemployment and vacancy rates
plot(timeline, u, purpleLine{:})
plot(timeline, v, orangeDotDashLine{:})

% Save figure
print('-dpdf', figureFile)

%% Save figure data

% Write header
header = {'Year', 'Unemployment rate', 'Vacancy rate'};
writecell(header, dataFile, 'WriteMode', 'overwrite')

% Write results
data = [timeline, u, v];
writematrix(round(data, 4), dataFile, 'WriteMode', 'append')