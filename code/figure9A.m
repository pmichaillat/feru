%% figure9A.m
% 
% Produce figure 9A
%
%% Description
%
% This script produces figure 9A and associated numerical results. The figure displays the quarterly unemployment rate, vacancy rate, and FERU in the United States, 2020Q1–2024Q2.
%
%% Requirements
%
% * inputFolder – String giving the location of the input folder. By default inputFolder is defined in main.m.
% * outputFolder – String giving the location of the output folder. By default outputFolder is defined in main.m.
% * formatFigure.m – Script defining plot colors and properties. By default formatFigure.m is run in main.m.
%
%% Output
%
% * figure9A.pdf – PDF file with figure 9A
% * figure9A.csv – CSV file with data underlying figure 9A
% * figure9A.md – Markdown file with numerical results associated with figure 9A.
%

%% Specify figure name and output files

% Define figure number
number = '9A';

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

% Plot unemployment rate, vacancy rate, and FERU
plot(timeline, u, purpleThinLine{:})
plot(timeline, v, orangeDashThinLine{:})
plot(timeline, uStar, pinkLine{:})

% Save figure
print('-dpdf', figureFile)

%% Save figure data

% Write header
header = {'Year',  'Unemployment rate', 'Vacancy rate', 'FERU'};
writecell(header, dataFile, 'WriteMode', 'overwrite')

% Write results
data = [timeline, u, v, uStar];
writematrix(round(data,4), dataFile, 'WriteMode', 'append')

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
fprintf('* FERU in 2024Q2: %4.3f \n', uStar(end))
fprintf('\n')
diary off