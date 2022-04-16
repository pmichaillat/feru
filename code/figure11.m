%% figure11.m
% 
% Produce figure 11
%
%% Description
%
% This script produces figure 11 and associated numerical results. The figure displays on a log scale the unemployment rate, vacancy rate, and FERU in the United States, 1930:Q1–2024:Q2.
%
%% Requirements
%
% * inputFolder - Path to input folder (default: defined in main.m)
% * outputFolder - Path to output folder (default: defined in main.m)
% * formatFigure.m - Predefine figure properties (default: run in main.m)
%
%% Output
%
% * figure11.pdf - PDF file with figure 11
% * figure11.csv - CSV file with data underlying figure 11
% * figure11.md - Markdown file with numerical results from figure 11
%

%% Construct figure name and paths to output files

% Define figure ID
figureId = '11';

% Construct figure name
figureName = ['Figure ', figureId];

% Construct paths to output files
figureFile = fullfile(outputFolder, ['figure', figureId, '.pdf']);
dataFile = fullfile(outputFolder, ['figure', figureId, '.csv']);
resultFile = fullfile(outputFolder, ['figure', figureId, '.md']);

%% Get data

% Generate quarterly timeline based on data range
timeline = [1930 : 0.25 : 2024.25]';

% Get recession dates
[startRecession, endRecession] = getRecession(inputFolder);

% Get unemployment rate
u = getUnemployment(inputFolder);

% Get vacancy rate
v = getVacancy(inputFolder);

%% Compute FERU

uStar = sqrt(u .* v);

%% Produce figure

% Set up figure window
figure('NumberTitle', 'off', 'Name', figureName)
hold on

% Format x-axis
ax = gca;
set(ax, completeAxis{:})

% Format y-axis
ax.YLim = log([0.005, 0.3]);
ax.YTick = log([0.005, 0.01, 0.02, 0.04, 0.08, 0.15, 0.3]);
ax.YTickLabel = ["0.5"; "1"; "2"; "4"; "8"; "15"; "30"];
ax.YLabel.String = 'Share of labor force (percent on log scale)';

% Shade recession areas
xregion(startRecession, endRecession, grayArea{:})

% Shade gap between unemployment and vacancy rates with distinct colors for positive and negative gaps
h = area(timeline, [log(uStar), max(log(u) - log(uStar), 0), min(log(u) - log(uStar), 0)]);
set(h, {'FaceAlpha', 'FaceColor', 'LineStyle'}, purpleOrangeArea)

% Plot unemployment rate, vacancy rate, and FERU
plot(timeline, log(u), purpleMediumLine{:})
plot(timeline, log(v), orangeDotDashMediumLine{:})
plot(timeline, log(uStar), pinkLine{:})

% Hide black box on top of figure
plot(timeline, log(0.3) .* ones(size(timeline)), 'Color', '#E6E6E6', 'LineWidth', 0.82)

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
uMean = mean(u);
[uMax, iMaxU] = max(u);
[uMin, iMinU] = min(u);
vMean = mean(v);
[vMax, iMaxV] = max(v);
[vMin, iMinV] = min(v);
uStarMean = mean(uStar);
[uStarMax, iMax] = max(uStar);
[uStarMin, iMin] = min(uStar);

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
fprintf('* Average FERU: %4.3f \n', uStarMean)
fprintf('* Maximum FERU: %4.3f in %4.2f \n', uStarMax, timeline(iMax))
fprintf('* Minimum FERU: %4.3f in %4.2f \n', uStarMin, timeline(iMin))
fprintf('\n')
diary off