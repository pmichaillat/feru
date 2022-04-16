%% figure12.m
% 
% Produce figure 12
%
%% Description
%
% This script produces figure 12 and associated numerical results. The figure displays on a log scale the labor market tightness in the United States, 1930:Q1–2024:Q2.
%
%% Requirements
%
% * inputFolder - Path to input folder (default: defined in main.m)
% * outputFolder - Path to output folder (default: defined in main.m)
% * formatFigure.m - Predefine figure properties (default: run in main.m)
%
%% Output
%
% * figure12.pdf - PDF file with figure 12
% * figure12.csv - CSV file with data underlying figure 12
% * figure12.md - Markdown file with numerical results from figure 12
%

%% Construct figure name and paths to output files

% Define figure ID
figureId = '12';

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

%% Compute labor market tightness

tightness = v ./ u;

%% Produce figure

% Set up figure window
figure('NumberTitle', 'off', 'Name', figureName)
hold on

% Format x-axis
ax = gca;
set(ax, completeAxis{:})

% Format y-axis
ax.YLim = log([0.03, 8]);
ax.YTick = log([0.03, 0.1, 0.3, 1, 2, 4, 8]);
ax.YTickLabel = ["0.03"; "0.1"; "0.3"; "1"; "2"; "4"; "8"];
ax.YLabel.String = 'Labor market tightness (log scale)';

% Shade recession areas
xregion(startRecession, endRecession, grayArea{:})

% Shade tightness gap with distinct colors for positive and negative gaps
h = area(timeline, [zeros(size(log(tightness))), min(log(tightness), 0), max(log(tightness), 0)]);
set(h, {'FaceAlpha', 'FaceColor', 'LineStyle'}, purpleOrangeArea)

% Plot labor market tightness
plot(timeline, log(tightness), orangeLine{:})

% Plot full-employment line
plot(timeline, zeros(size(timeline)), pinkThinLine{:})

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
tightness4345 = mean(tightness([timeline >= 1943] & [timeline < 1946]));
tightness5153 = mean(tightness([timeline >= 1951] & [timeline < 1954]));
tightness6669 = mean(tightness([timeline >= 1966] & [timeline < 1970]));

% Clear result file
if exist(resultFile,'file'), delete(resultFile), end

% Display and save results
fprintf('\nFigure %3s\n----------\n', figureId)
diary(resultFile)
fprintf('\n')
fprintf('* Average labor market tightness: %4.2f \n', tightnessMean)
fprintf('* Maximum labor market tightness: %4.2f in %4.2f \n', tightnessMax, timeline(iMax))
fprintf('* Minimum labor market tightness: %4.2f in %4.2f \n', tightnessMin, timeline(iMin))
fprintf('* Average labor market tightness over 1943–1945: %4.2f \n', tightness4345)
fprintf('* Average labor market tightness over 1951–1953: %4.2f \n', tightness5153)
fprintf('* Average labor market tightness over 1966–1969: %4.2f \n', tightness6669)
fprintf('\n')
diary off