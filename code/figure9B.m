%% figure9B.m
% 
% Produce panel B of figure 9
%
%% Description
%
% This script produces panel B of figure 9 and associated numerical results. The figure displays the unemployment gap in the United States, 2020:Q1–2024:Q2.
%
%% Requirements
%
% * inputFolder - Path to input folder (default: defined in main.m)
% * outputFolder - Path to output folder (default: defined in main.m)
% * formatFigure.m - Predefine figure properties (default: run in main.m)
%
%% Output
%
% * figure9B.pdf - PDF file with panel B of figure 9
% * figure9B.csv - CSV file with data underlying panel B of figure 9
% * figure9B.md - Markdown file with numerical results from panel B of figure 9
%

%% Construct figure name and paths to output files

% Define figure ID
figureId = '9B';

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

%% Compute FERU

uStar = sqrt(u .* v);

%% Compute unemployment gap

gap = u - uStar;

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
ax.YLabel.String = 'Share of labor force (percent)';

% Shade recession areas
xregion(startRecession, endRecession, grayArea{:})

% Shade unemployment gap with distinct colors for positive and negative gaps
h = area(timeline, [uStar, max(u - uStar, 0), min(u - uStar, 0)]);
set(h, {'FaceAlpha', 'FaceColor', 'LineStyle'}, purpleOrangeArea)

% Plot unemployment rate and FERU
plot(timeline, u, purpleMediumLine{:})
plot(timeline, uStar, pinkLine{:})

% Save figure
print('-dpdf', figureFile)

%% Save figure data

% Write header
header = {'Year', 'Unemployment rate', 'FERU', 'Unemployment gap'};
writecell(header, dataFile, 'WriteMode', 'overwrite')

% Write results
data = [timeline, u, uStar, gap];
writematrix(round(data, 4), dataFile, 'WriteMode', 'append')

%% Produce numerical results

% Compute results
gapMean = mean(gap);
[gapMax, iMax] = max(gap);
[gapMin, iMin] = min(gap);

% Clear result file
if exist(resultFile,'file'), delete(resultFile), end

% Display and save results
fprintf('\nFigure %3s\n----------\n', figureId)
diary(resultFile)
fprintf('\n')
fprintf('* Average unemployment gap: %4.3f \n', gapMean)
fprintf('* Maximum unemployment gap: %4.3f in %4.2f \n', gapMax, timeline(iMax))
fprintf('* Minimum unemployment gap: %4.3f in %4.2f \n', gapMin, timeline(iMin))
fprintf('* Unemployment gap in 2024:Q2: %4.3f \n', gap(end))
fprintf('\n')
diary off