%% figure7A.m
% 
% Produce panel A of figure 7
%
%% Description
%
% This script produces panel A of figure 7. The figure displays the unemployment rate, vacancy rate, and FERU in the United States, 1930:Q1–1950:Q4.
%
%% Requirements
%
% * inputFolder - Path to input folder (default: defined in main.m)
% * outputFolder - Path to output folder (default: defined in main.m)
% * formatFigure.m - Predefine figure properties (default: run in main.m)
%
%% Output
%
% * figure7A.pdf - PDF file with panel A of figure 7
% * figure7A.csv - CSV file with data underlying panel A of figure 7
% * figure7A.md - Markdown file with numerical results from panel A of figure 7
%

%% Construct figure name and paths to output files

% Define figure ID
figureId = '7A';

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

%% Compute FERU

uStar = sqrt(u .* v);

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
if exist(resultFile,'file'), delete(resultFile), end

% Display and save results
fprintf('\nFigure %3s\n----------\n', figureId)
diary(resultFile)
fprintf('\n')
fprintf('* Average FERU: %4.3f \n', uStarMean)
fprintf('* Maximum FERU: %4.3f in %4.2f \n', uStarMax, timeline(iMax))
fprintf('* Minimum FERU: %4.3f in %4.2f \n', uStarMin, timeline(iMin))
fprintf('\n')
diary off