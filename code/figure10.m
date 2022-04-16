%% figure10.m
% 
% Produce figure 10
%
%% Description
%
% This script produces figure 10. The figure displays the Beveridge curve in the United States, 2001:Q1–2024:Q2.
%
%% Requirements
%
% * inputFolder - Path to input folder (default: defined in main.m)
% * outputFolder - Path to output folder (default: defined in main.m)
% * formatFigure.m - Predefine figure properties (default: run in main.m)
%
%% Output
%
% * figure10.pdf - PDF file with figure 10
% * figure10.csv - CSV file with data underlying figure 10
%

%% Construct figure name and paths to output files

% Define figure ID
figureId = '10';

% Construct figure name
figureName = ['Figure ', figureId];

% Construct paths to output files
figureFile = fullfile(outputFolder, ['figure', figureId, '.pdf']);
dataFile = fullfile(outputFolder, ['figure', figureId, '.csv']);

%% Get data

% Get unemployment rate
u = getUnemploymentJolts(inputFolder);

% Get vacancy rate
v = getVacancyJolts(inputFolder);

%% Produce figure

% Set up figure window
figure('NumberTitle', 'off', 'Name', figureName)
hold on

% Format x-axis
ax = gca;
ax.XGrid = 'on';
ax.TickLength = [0, 0];
ax.XLim = [0, 0.14];
ax.XTick = [0 : 0.02 : 0.14];
ax.XTickLabel = ["0"; "2"; "4"; "6"; "8"; "10"; "12"; "14"];
ax.XLabel.String = 'Unemployment rate (percent)';

% Format y-axis
ax.YLim = [0, 0.08];
ax.YTick = [0 : 0.02 : 0.08];
ax.YTickLabel = ["0"; "2"; "4"; "6"; "8"];
ax.YLabel.String = 'Vacancy rate (percent)';

% Plot full-employment line
uRange = [0 : 0.001 : 0.20];
vLine = uRange;
plot(uRange, vLine, pinkThinLine{:})

% Plot Beveridge curve
h1 = plot(u, v);

% Format Beveridge curve
h1.Color = gray;
h1.LineWidth = thin;
h1.MarkerSize = 1;
h1.MarkerFaceColor = gray;
h1.LineStyle = '-.';
h1.Marker = 'o';

% Highlight inefficiently tight period
tightPeriod = [u < v];
h2 = plot(u(tightPeriod), v(tightPeriod));
h2.Color = orange;
h2.MarkerSize = 7;
h2.MarkerFaceColor = orange;
h2.LineStyle = 'none';
h2.Marker = 's';

% Highlight inefficiently slack period
slackPeriod = [u > v];
h3 = plot(u(slackPeriod), v(slackPeriod));
h3.Color = purple;
h3.MarkerSize = 7;
h3.MarkerFaceColor = purple;
h3.LineStyle = 'none';
h3.Marker = 'o';

% Save figure
print('-dpdf', figureFile)

%% Save figure data

% Write header
header = {'Year', 'Unemployment rate', 'Vacancy rate'};
writecell(header, dataFile, 'WriteMode', 'overwrite')

% Write results
timeline = [2001 : 0.25 : 2024.25]';
data = [timeline, u, v];
writematrix(round(data, 4), dataFile, 'WriteMode', 'append')