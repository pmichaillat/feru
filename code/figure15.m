%% figure15.m
% 
% Produce figure 15
%
%% Description
%
% This script produces figure 15 and associated numerical results. The figure displays various unemployment targets in the United States, 1930:Q1–2024:Q2.
%
% * Full-employment rate of unemployment (FERU)
% * Natural rate of unemployment (NRU)
% * Short-term natural rate of unemployment (NRUST)
% * Non-accelerating-inflation rate of unemployment (NAIRU)
%
%% Requirements
%
% * inputFolder - Path to input folder (default: defined in main.m)
% * outputFolder - Path to output folder (default: defined in main.m)
% * formatFigure.m - Predefine figure properties (default: run in main.m)
%
%% Output
%
% * figure15.pdf - PDF file with figure 15
% * figure15.csv - CSV file with data underlying figure 15
% * figure15.md - Markdown file with numerical results from figure 15
%

%% Construct figure name and paths to output files

% Define figure ID
figureId = '15';

% Construct figure name
figureName = ['Figure ', figureId];

% Construct paths to output files
figureFile = fullfile(outputFolder, ['figure', figureId, '.pdf']);
dataFile = fullfile(outputFolder, ['figure', figureId, '.csv']);
resultFile = fullfile(outputFolder, ['figure', figureId, '.md']);

%% Get data

% Generate quarterly timeline based on data ranges
timeline = [1930 : 0.25 : 2024.25]';
timelineNru = [1949 : 0.25 : 2024.25]';
timelineNrust = [1949 : 0.25 : 2020.75]';
timelineNairu = [1960 : 0.25 : 2023.75]';

% Get recession dates
[startRecession, endRecession] = getRecession(inputFolder);

% Get vacancy rate
v = getVacancy(inputFolder);

% Get unemployment rate
u = getUnemployment(inputFolder);

% Get NRU
nru = getNru(inputFolder);

% Get NRUST
nrust = getNrust(inputFolder);

% Get NAIRU
nairu = getNairu(inputFolder);

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
ax.YLim = [0, 0.1];
ax.YTick = [0 : 0.02 : 0.1];
ax.YTickLabel = ["0"; "2"; "4"; "6"; "8"; "10"];
ax.YLabel.String = 'Share of labor force (percent)';

% Shade recession areas
xregion(startRecession, endRecession, grayArea{:})

% Plot unemployment targets
h1 = plot(timelineNrust, nrust);
h2 = plot(timelineNairu, nairu);
h3 = plot(timelineNru, nru);
plot(timeline, uStar, pinkLine{:})

% Format unemployment targets
h1.Color = gray;
h1.LineWidth = thick;
h1.LineStyle = '-.';
h2.Color = '#737373';
h2.LineWidth = thick;
h2.LineStyle = ':';
h3.Color = '#252525';
h3.LineWidth = thick;
h3.LineStyle = '-.';

% Save figure
print('-dpdf', figureFile)

%% Save figure data

% Write header
header = {'Timeline', 'FERU', 'NRU', 'NRUST', 'NAIRU'};
writecell(header, dataFile, 'WriteMode', 'overwrite')

% Create empty matrix for data
data = zeros(numel(timeline), 5);

% Add FERU data
data(:, 1) = timeline;
data(:, 2) = uStar;

% Add NRU data
idx = find(timeline == timelineNru(1));
data(idx : idx + numel(nru) - 1, 3) = nru;

% Add NRUST data
idx = find(timeline == timelineNrust(1));
data(idx : idx + numel(nrust) - 1, 4) = nrust;

% Add NAIRU data
idx = find(timeline == timelineNairu(1));
data(idx : idx + numel(nairu) - 1, 5) = nairu;

% Write data
writematrix(round(data, 4), dataFile, 'WriteMode', 'append')

%% Produce numerical results

% Compute results for NAIRU
nairu2019 = nairu(timelineNairu < 2020);
uStarNairu = uStar([timeline >= timelineNairu(1)] & [timeline < 2020]);
nairuMean = mean(nairu2019);
distanceNairuMean = mean(nairu2019 - uStarNairu);
[distanceNairuMax, iMaxNairu] = max(nairu2019 - uStarNairu);
[distanceNairuMin, iMinNairu] = min(nairu2019 - uStarNairu);

% Compute results for NRU
nru2019 = nru(timelineNru < 2020);
uStarNru = uStar([timeline >= timelineNru(1)] & [timeline < 2020]);
nruMean = mean(nru2019);
distanceNruMean = mean(nru2019 - uStarNru);
[distanceNruMax, iMaxNru] = max(nru2019 - uStarNru);
[distanceNruMin, iMinNru] = min(nru2019 - uStarNru);

% Clear result file
if exist(resultFile,'file'), delete(resultFile), end

% Display and save results
fprintf('\nFigure %3s\n----------\n', figureId)
diary(resultFile)
fprintf('\n')
fprintf('* Average NAIRU: %4.3f \n', nairuMean)
fprintf('* Average distance between FERU & NAIRU: %4.3f \n', distanceNairuMean)
fprintf('* Maximum distance between FERU & NAIRU: %4.3f in %4.2f \n', distanceNairuMax, timelineNairu(iMaxNairu))
fprintf('* Minimum distance between FERU & NAIRU: %4.3f in %4.2f \n', distanceNairuMin, timelineNairu(iMinNairu))
fprintf('* Average NRU over 1949–2019: %4.3f \n', nruMean)
fprintf('* Average distance between FERU & NRU: %4.3f \n', distanceNruMean)
fprintf('* Maximum distance between FERU & NRU: %4.3f in %4.2f \n', distanceNruMax, timelineNru(iMaxNru))
fprintf('* Minimum distance between FERU & NRU: %4.3f in %4.2f \n', distanceNruMin, timelineNru(iMinNru))
fprintf('\n')
diary off