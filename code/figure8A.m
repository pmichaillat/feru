%% figure8A.m
% 
% Produce panel A of figure 8
%
%% Description
%
% This script produces panel A of figure 8 and associated numerical results. The figure displays the gap between the unemployment and vacancy rates in the United States, 2020:Q1–2024:Q2.
%
%% Requirements
%
% * inputFolder - Path to input folder (default: defined in main.m)
% * outputFolder - Path to output folder (default: defined in main.m)
% * formatFigure.m - Predefine figure properties (default: run in main.m)
%
%% Output
%
% * figure8A.pdf - PDF file with panel A of figure 8
% * figure8A.csv - CSV file with data underlying panel A of figure 8
% * figure8A.md - Markdown file with numerical results from panel A of figure 8
%

%% Construct figure name and paths to output files

% Define figure ID
figureId = '8A';

% Construct figure name
figureName = ['Figure ', figureId];

% Construct paths to output files
figureFile = fullfile(outputFolder, ['figure', figureId, '.pdf']);
dataFile = fullfile(outputFolder, ['figure', figureId, '.csv']);
resultFile = fullfile(outputFolder, ['figure', figureId, '.md']);

%% Get data

% Generate quarterly timeline based on data range
timeline = [2020 : 0.25 : 2024.25]';

% Get recession dates
[startRecession, endRecession] = getRecessionPandemic(inputFolder);

% Get unemployment rate
u = getUnemploymentPandemic(inputFolder);

% Get vacancy rate
v = getVacancyPandemic(inputFolder);

%% Produce figure

% Set up figure window
figure('NumberTitle', 'off', 'Name', figureName)
hold on

% Format x-axis
ax = gca;
set(ax, pandemicAxis{:})

% Format y-axis
ax.YLim = [0, 0.14];
ax.YTick = [0 : 0.02 : 0.14];
ax.YTickLabel = ["0"; "2"; "4"; "6"; "8"; "10"; "12"; "14"];
ax.YTickLabel = ["0"; "2"; "4"; "6"; "8"; "10"; "12"; "14"];
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

%% Produce numerical results

% Compute results
uMean = mean(u);
[uMax, iMaxU] = max(u);
[uMin, iMinU] = min(u);
vMean = mean(v);
[vMax, iMaxV] = max(v);
[vMin, iMinV] = min(v);

% Clear result file
if exist(resultFile,'file'), delete(resultFile), end

% Display and save results
fprintf('\nFigure %3s\n----------\n', figureId)
diary(resultFile)
fprintf('\n')
fprintf('* Average unemployment rate: %4.3f \n', uMean)
fprintf('* Maximum unemployment rate: %4.3f in %4.2f \n', uMax, timeline(iMaxU))
fprintf('* Minimum unemployment rate: %4.3f in %4.2f \n', uMin, timeline(iMinU))
fprintf('* Unemployment rate in 2024:Q2: %4.3f \n', u(end))
fprintf('* Average vacancy rate: %4.3f \n', vMean)
fprintf('* Maximum vacancy rate: %4.3f in %4.2f \n', vMax, timeline(iMaxV))
fprintf('* Minimum vacancy rate: %4.3f in %4.2f \n', vMin, timeline(iMinV))
fprintf('* Vacancy rate in 2024:Q2: %4.3f \n', v(end))
fprintf('\n')
diary off