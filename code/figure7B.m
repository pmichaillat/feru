%% figure7B.m
% 
% Produce panel B of figure 7
%
%% Description
%
% This script produces panel B of figure 7 and associated numerical results. The figure displays the quarterly unemployment gap in the United States, 1930Q1–1950Q4.
%
%% Requirements
%
% * inputFolder - Path to the input folder (default: defined in main.m)
% * outputFolder - Path to the output folder (default: defined in main.m)
% * formatFigure.m - Script for plot formatting (default: run in main.m)
%
%% Output
%
% * figure7B.pdf - PDF file with panel B of figure 7
% * figure7B.csv - CSV file with data underlying panel B of figure 7
% * figure7B.md - Markdown file with numerical results from panel B of figure 7
%

%% Specify figure name and output files

% Define figure number
number = '7B';

% Construct figure name
figureName = ['Figure ', number];

% Construct file names
figureFile = fullfile(outputFolder, ['figure', number, '.pdf']);
dataFile = fullfile(outputFolder, ['figure', number, '.csv']);
resultFile = fullfile(outputFolder, ['figure', number, '.md']);

%% Get data

% Generate quarterly timeline based on data range
timeline = [1930 : 0.25 : 1950.75]';

% Get recession dates
[startRecession, endRecession] = getRecessionDepression(inputFolder);

% Get unemployment rate
u = getUnemploymentDepression(inputFolder);

% Get vacancy rate
v = getVacancyDepression(inputFolder);

%% Compute FERU

uStar = sqrt(u .* v);

%% Compute unemployment gap

gap = u - uStar;

%% Produce figure

figure('NumberTitle', 'off', 'Name', figureName)
hold on

% Format x-axis
ax = gca;
set(ax, xDepression{:})

% Format y-axis
ax.YLim = [0, 0.3];
ax.YTick = [0 : 0.05 : 0.3];
ax.YTickLabel = [' 0'; ' 5'; '10'; '15'; '20'; '25'; '30'];
ax.YLabel.String = 'Share of labor force (percent)';

% Paint recession areas
xregion(startRecession, endRecession, grayArea{:})

% Paint unemployment gap with distinct colors for positive and negative gaps
h = area(timeline, [uStar, max(u - uStar, 0), min(u - uStar, 0)]);
set(h, {'FaceAlpha', 'FaceColor', 'LineStyle'}, purpleOrangeArea);

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
fid = fopen(resultFile, 'w');
fclose(fid);

% Display and save results
diary(resultFile)
fprintf('\n')
fprintf('* Average unemployment gap: %4.3f \n', gapMean)
fprintf('* Maximum unemployment gap: %4.3f in %4.2f \n', gapMax, timeline(iMax))
fprintf('* Minimum unemployment gap: %4.3f in %4.2f \n', gapMin, timeline(iMin))
fprintf('\n')
diary off