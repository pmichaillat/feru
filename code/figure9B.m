%% figure9B.m
% 
% Produce figure 9B
%
%% Description
%
% This script produces figure 9B and associated numerical results. The figure displays the quarterly unemployment gap in the United States, 2020Q1–2024Q2.
%
%% Requirements
%
% * inputFolder – String giving the location of the input folder. By default inputFolder is defined in main.m.
% * outputFolder – String giving the location of the output folder. By default outputFolder is defined in main.m.
% * formatFigure.m – Script defining plot colors and properties. By default formatFigure.m is run in main.m.
%
%% Output
%
% * figure9B.pdf – PDF file with figure 9B
% * figure9B.csv – CSV file with data underlying figure 9B
% * figure9B.md – Markdown file with numerical results associated with figure 9B.
%

%% Specify figure name and output files

% Define figure number
number = '9B';

% Construct figure name
figureName = ['Figure ', number];

% Construct file names
figureFile = fullfile(outputFolder, ['figure', number, '.pdf']);
dataFile = fullfile(outputFolder, ['figure', number, '.csv']);
resultFile = fullfile(outputFolder, ['figure', number, '.md']);

%% Get data

% Produce quarterly timeline
timeline = [2020 : 0.25 : 2024.25]';

% Get recessions dates
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

figure('NumberTitle', 'off', 'Name', figureName)
hold on

% Format x-axis
ax = gca;
set(ax, xPandemic{:})

% Format y-axis
ax.YLim = [0, 0.14];
ax.YTick =  [0:0.02:0.14];
ax.YTickLabel = [' 0%'; ' 2%'; ' 4%'; ' 6%'; ' 8%'; '10%'; '12%'; '14%'];
ax.YLabel.String =  'Share of labor force';

% Paint recession areas
xregion(startRecession, endRecession, grayArea{:});

% Paint unemployment gap
a = area(timeline, [uStar, max(u - uStar,0), min(u - uStar,0)], 'LineStyle', 'none');
a(1).FaceAlpha = 0;
a(2).FaceAlpha = 0.2;
a(3).FaceAlpha = 0.2;
a(2).FaceColor = purple;
a(3).FaceColor = orange;

% Plot unemployment rate and FERU
plot(timeline, u, purpleThinLine{:})
plot(timeline, uStar, pinkLine{:})

% Save figure
print('-dpdf', figureFile)

%% Save figure data

% Write header
header = {'Year',  'Unemployment rate', 'FERU', 'Unemployment gap'};
writecell(header, dataFile, 'WriteMode', 'overwrite')

% Write results
data = [timeline, u, uStar, gap];
writematrix(round(data,4), dataFile, 'WriteMode', 'append')

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
fprintf('* Unemployment gap in 2024Q2: %4.3f \n', gap(end))
fprintf('\n')
diary off