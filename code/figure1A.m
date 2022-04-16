%% figure1A.m
% 
% Produce panel A of figure 1
%
%% Description
%
% This script produces panel A of figure 1 and associated numerical results. The figure displays the unemployment and vacancy rates in the United States, 1951:Q1–2019:Q4.
%
%% Requirements
%
% * inputFolder - Path to input folder (default: defined in main.m)
% * outputFolder - Path to output folder (default: defined in main.m)
% * formatFigure.m - Predefine figure properties (default: run in main.m)
%
%% Output
%
% * figure1A.pdf - PDF file with panel A of figure 1
% * figure1A.csv - CSV file with data underlying panel A of figure 1
% * figure1A.md - Markdown file with numerical results from panel A of figure 1
%

%% Construct figure name and paths to output files

% Define figure ID
figureId = '1A';

% Construct figure name
figureName = ['Figure ', figureId];

% Construct paths to output files
figureFile = fullfile(outputFolder, ['figure', figureId, '.pdf']);
dataFile = fullfile(outputFolder, ['figure', figureId, '.csv']);
resultFile = fullfile(outputFolder, ['figure', figureId, '.md']);

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

% Plot unemployment and vacancy rates
plot(timeline, u, purpleLine{:})
plot(timeline, v, orangeDotDashLine{:})

% Save figure
print('-dpdf', figureFile)

%% Save figure data

% Write header
header = {'Year', 'Unemployment rate', 'Vacancy rate'};
writecell(header, dataFile, 'WriteMode', 'overwrite')

% Write data
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