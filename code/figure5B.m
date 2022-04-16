%% figure5B.m
% 
% Produce panel B of figure 5
%
%% Description
%
% This script produces panel B of figure 5 and associated numerical results. The figure displays on a log scale the unemployment and vacancy rates in the United States, 1930:Q1–1950:Q4.
%
%% Requirements
%
% * inputFolder - Path to input folder (default: defined in main.m)
% * outputFolder - Path to output folder (default: defined in main.m)
% * formatFigure.m - Predefine figure properties (default: run in main.m)
%
%% Output
%
% * figure5B.pdf - PDF file with panel B of figure 5
% * figure5B.csv - CSV file with data underlying panel B of figure 5
% * figure5B.md - Markdown file with numerical results from panel B of figure 5
%

%% Construct figure name and paths to output files

% Define figure ID
figureId = '5B';

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

ax.YLim = log([0.005, 0.30]);
ax.YTick = log([0.005, 0.01, 0.02, 0.04, 0.1, 0.2, 0.3]);
ax.YTickLabel = ["0.5"; "1"; "2"; "4"; "10"; "20"; "30"];
ax.YLabel.String = 'Share of labor force (percent on log scale)';

% Shade recession areas
xregion(startRecession, endRecession, grayArea{:})

% Plot log unemployment and vacancy rates
plot(timeline, log(u), purpleLine{:})
plot(timeline, log(v), orangeDotDashLine{:})

% Save figure
print('-dpdf', figureFile)

%% Save figure data

% Write header
header = {'Year', 'Log unemployment rate', 'Log vacancy rate'};
writecell(header, dataFile, 'WriteMode', 'overwrite')

% Write results
data = [timeline, log(u), log(v)];
writematrix(round(data, 4), dataFile, 'WriteMode', 'append')

%% Produce numerical results

% Compute elasticity of Beveridge curve
y = log(v);
X = [ones(size(u)), log(u)];
b = regress(y,X);
elasticity = b(2);

% Clear result file
if exist(resultFile,'file'), delete(resultFile), end

% Display and save results
fprintf('\nFigure %3s\n----------\n', figureId)
diary(resultFile)
fprintf('\n')
fprintf('* Elasticity of the 1930-1950 Beveridge curve: %1.2f \n', elasticity)
fprintf('\n')
diary off