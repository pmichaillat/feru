%% figure6B.m
% 
% Produce panel B of figure 6
%
%% Description
%
% This script produces panel B of figure 6 and associated numerical results. The figure displays the labor market tightness in the United States, 1930:Q1–1950:Q4.
%
%% Requirements
%
% * inputFolder - Path to input folder (default: defined in main.m)
% * outputFolder - Path to output folder (default: defined in main.m)
% * formatFigure.m - Predefine figure properties (default: run in main.m)
%
%% Output
%
% * figure6B.pdf - PDF file with panel B of figure 6
% * figure6B.csv - CSV file with data underlying panel B of figure 6
% * figure6B.md - Markdown file with numerical results from panel B of figure 6
%

%% Construct figure name and paths to output files

% Define figure ID
figureId = '6B';

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

%% Compute labor market tightness

tightness = v ./ u;

%% Produce figure

% Set up figure window
figure('NumberTitle', 'off', 'Name', figureName)
hold on

% Format x-axis
ax = gca;
set(ax, depressionAxis{:})

% Format y-axis
ax.YLim = [0, 7];
ax.YTick = [0 : 1 : 7];
ax.YLabel.String = 'Labor market tightness';

% Shade recession areas
xregion(startRecession, endRecession, grayArea{:})

% Shade tightness gap with distinct colors for positive and negative gaps
h = area(timeline, [ones(size(tightness)), min(tightness - 1, 0), max(tightness - 1, 0)]);
set(h, {'FaceAlpha', 'FaceColor', 'LineStyle'}, purpleOrangeArea)

% Plot labor market tightness
plot(timeline, tightness, orangeLine{:})

% Plot full-employment line
plot(timeline, ones(size(timeline)), pinkThinLine{:})

% Save figure
print('-dpdf', figureFile)

%% Save figure data

% Write header
header = {'Year', 'Tightness'};
writecell(header, dataFile, 'WriteMode', 'overwrite')

% Write results
data = [timeline, tightness];
writematrix(round(data, 2), dataFile, 'WriteMode', 'append')

%% Produce numerical results

% Compute results
tightnessMean = mean(tightness);
[tightnessMax, iMax] = max(tightness);
[tightnessMin, iMin] = min(tightness);

% Clear result file
if exist(resultFile,'file'), delete(resultFile), end

% Display and save results
fprintf('\nFigure %3s\n----------\n', figureId)
diary(resultFile)
fprintf('\n')
fprintf('* Average labor market tightness: %4.2f \n', tightnessMean)
fprintf('* Maximum labor market tightness: %4.2f in %4.2f \n', tightnessMax, timeline(iMax))
fprintf('* Minimum labor market tightness: %4.2f in %4.2f \n', tightnessMin, timeline(iMin))
fprintf('\n')
diary off