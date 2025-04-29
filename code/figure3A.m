%% figure3A.m
% 
% Produce panel A of figure 3
%
%% Description
%
% This script produces panel A of figure 3. The figure displays the gap between the unemployment and vacancy rates in the United States, 1951:Q1–2019:Q4.
%
%% Requirements
%
% * inputFolder - Path to input folder (default: defined in main.m)
% * outputFolder - Path to output folder (default: defined in main.m)
% * formatFigure.m - Predefine figure properties (default: run in main.m)
%
%% Output
%
% * figure3A.pdf - PDF file with panel A of figure 3
% * figure3A.csv - CSV file with data underlying panel A of figure 3
%

%% Construct figure name and paths to output files

% Define figure ID
figureId = '3A';

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
ax.YLim = [0, 0.12];
ax.YTick = [0 : 0.02 : 0.12];
ax.YTickLabel = ["0"; "2"; "4"; "6"; "8"; "10"; "12"];
ax.YLabel.String = 'Share of labor force (percent)';

% Shade recession areas
xregion(startRecession, endRecession, grayArea{:})

% Shade gap between unemployment and vacancy rates with distinct colors for positive and negative gaps
h = area(timeline, [v, max(u - v, 0), min(u - v, 0)]);
set(h, {'FaceAlpha', 'FaceColor', 'LineStyle'}, purpleOrangeArea)

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