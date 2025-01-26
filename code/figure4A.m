%% figure4A.m
% 
% Produce panel A of figure 4
%
%% Description
%
% This script produces panel A of figure 4 and associated numerical results. The figure displays the quarterly unemployment rate, vacancy rate, and FERU in the United States, 1951Q1–2019Q4.
%
%% Requirements
%
% * inputFolder – Path to the input folder (default: defined in main.m)
% * outputFolder – Path to the output folder (default: defined in main.m)
% * formatFigure.m – Script for plot formatting (default: run in main.m)
%
%% Output
%
% * figure4A.pdf – PDF file with panel A of figure 4
% * figure4A.csv – CSV file with data underlying panel A of figure 4
% * figure4A.md – Markdown file with numerical results from panel A of figure 4
%

%% Specify figure name and output files

% Define figure number
number = '4A';

% Construct figure name
figureName = ['Figure ', number];

% Construct file names
figureFile = fullfile(outputFolder, ['figure', number, '.pdf']);
dataFile = fullfile(outputFolder, ['figure', number, '.csv']);
resultFile = fullfile(outputFolder, ['figure', number, '.md']);

%% Get data

% Generate quarterly timeline based on data range
timeline = [1951 : 0.25 : 2019.75]';

% Get recession dates
[startRecession, endRecession] = getRecessionPostwar(inputFolder);

% Get unemployment rate
u = getUnemploymentPostwar(inputFolder);

% Get vacancy rate
v = getVacancyPostwar(inputFolder);

%% Compute FERU

uStar = sqrt(u .* v);

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

% Plot unemployment rate, vacancy rate, and FERU
plot(timeline, u, purpleMediumLine{:})
plot(timeline, v, orangeDotDashMediumLine{:})
plot(timeline, uStar, pinkLine{:})

% Save figure
print('-dpdf', figureFile)

%% Save figure data

% Write header
header = {'Year', 'Unemployment rate', 'Vacancy rate', 'FERU'};
writecell(header, dataFile, 'WriteMode', 'overwrite')

% Write results
data = [timeline, u, v, uStar];
writematrix(round(data, 4), dataFile, 'WriteMode', 'append')

%% Produce numerical results

% Compute results
uStarMean = mean(uStar);
[uStarMax, iMax] = max(uStar);
[uStarMin, iMin] = min(uStar);

% Clear result file
fid = fopen(resultFile, 'w');
fclose(fid);

% Display and save results
diary(resultFile)
fprintf('\n')
fprintf('* Average FERU: %4.3f \n', uStarMean)
fprintf('* Maximum FERU: %4.3f in %4.2f \n', uStarMax, timeline(iMax))
fprintf('* Minimum FERU: %4.3f in %4.2f \n', uStarMin, timeline(iMin))
fprintf('\n')
diary off