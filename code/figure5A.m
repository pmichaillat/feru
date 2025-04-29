%% figure5A.m
% 
% Produce panel A of figure 5
%
%% Description
%
% This script produces panel A of figure 5 and associated numerical results. The figure displays the unemployment and vacancy rates in the United States, 1930:Q1–1950:Q4.
%
%% Requirements
%
% * inputFolder - Path to input folder (default: defined in main.m)
% * outputFolder - Path to output folder (default: defined in main.m)
% * formatFigure.m - Predefine figure properties (default: run in main.m)
%
%% Output
%
% * figure5A.pdf - PDF file with panel A of figure 5
% * figure5A.csv - CSV file with data underlying panel A of figure 5
% * figure5A.md - Markdown file with numerical results from panel A of figure 5
%

%% Construct figure name and paths to output files

% Define figure ID
figureId = '5A';

% Construct figure name
figureName = ['Figure ', figureId];

% Construct paths to output files
figureFile = fullfile(outputFolder, ['figure', figureId, '.pdf']);
dataFile = fullfile(outputFolder, ['figure', figureId, '.csv']);
resultFile = fullfile(outputFolder, ['figure', figureId, '.md']);

%% Get data

% Generate quarterly timeline based on data range
timeline = [1930 : 0.25 : 1950.75]';

% Get recession dates
[startRecession, endRecession] = getRecessionDepression(inputFolder);

% Get unemployment rate
u = getUnemploymentDepression(inputFolder);

% Get vacancy rate
v = getVacancyDepression(inputFolder);

%% Produce figure

% Set up figure window
figure('NumberTitle', 'off', 'Name', figureName)
hold on

% Format x-axis
ax = gca;
set(ax, depressionAxis{:})

% Format y-axis
ax.YLim = [0, 0.3];
ax.YTick = [0 : 0.05 : 0.3];
ax.YTickLabel = ["0"; "5"; "10"; "15"; "20"; "25"; "30"];
ax.YLabel.String = 'Share of labor force (percent)';

% Shade recession areas
xregion(startRecession, endRecession, grayArea{:})

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
fprintf('* Average vacancy rate: %4.3f \n', vMean)
fprintf('* Maximum vacancy rate: %4.3f in %4.2f \n', vMax, timeline(iMaxV))
fprintf('* Minimum vacancy rate: %4.3f in %4.2f \n', vMin, timeline(iMinV))
fprintf('\n')
diary off