%% figure12.m
% 
% Produce figure 12
%
%% Description
%
% This script produces figure 12 and associated numerical results. The figure displays on a log scale the quarterly labor-market tightness in the United States, 1930Q1–2024Q2.
%
%% Requirements
%
% * inputFolder – String giving the location of the input folder. By default inputFolder is defined in main.m.
% * outputFolder – String giving the location of the output folder. By default outputFolder is defined in main.m.
% * formatFigure.m – Script defining plot colors and properties. By default formatFigure.m is run in main.m.
%
%% Output
%
% * figure12.pdf – PDF file with figure 12
% * figure12.csv – CSV file with data underlying figure 12
% * figure12.md – Markdown file with numerical results associated with figure 12.
%

%% Specify figure name and output files

% Define figure number
number = '12';

% Construct figure name
figureName = ['Figure ', number];

% Construct file names
figureFile = fullfile(outputFolder, ['figure', number, '.pdf']);
dataFile = fullfile(outputFolder, ['figure', number, '.csv']);
resultFile = fullfile(outputFolder, ['figure', number, '.md']);

%% Get data

% Produce quarterly timeline
timeline = [1930 : 0.25 : 2024.25]';

% Get recessions dates
[startRecession, endRecession] = getRecession(inputFolder);

% Get unemployment rate
u = getUnemployment(inputFolder);

% Get vacancy rate
v = getVacancy(inputFolder);

%% Compute labor-market tightness

tightness = v ./ u;

%% Produce figure

figure('NumberTitle', 'off', 'Name', figureName)
hold on

% Format x-axis
ax = gca;
set(ax, xTotal{:})

% Format y-axis
ax.YLim = log([0.03, 8]);
ax.YTick =  log([0.03,0.1,0.3,1,2,4,8]);
ax.YTickLabel = ['0.03'; ' 0.1';' 0.3'; '   1'; '   2'; '   4'; '   8'];
ax.YLabel.String =  'Labor-market tightness (log scale)';

% Paint recession areas
xregion(startRecession, endRecession, grayArea{:});

% Paint gap between tightness and full-employment line
a = area(timeline, [zeros(size(log(tightness))), max(log(tightness),0), min(log(tightness),0)], 'LineStyle', 'none');
a(1).FaceAlpha = 0;
a(2).FaceAlpha = 0.2;
a(3).FaceAlpha = 0.2;
a(2).FaceColor = orange;
a(3).FaceColor = purple;

% Plot labor-market tightness
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
writematrix(round(data,2), dataFile, 'WriteMode', 'append')

%% Produce numerical results

% Compute results
tightnessMean = mean(tightness);
[tightnessMax, iMax] = max(tightness);
[tightnessMin, iMin] = min(tightness);
tightness4245 = mean(tightness([timeline > 1941] & [timeline < 1946]));
tightness5153 = mean(tightness([timeline > 1950] & [timeline < 1954]));
tightness6669 = mean(tightness([timeline > 1965] & [timeline < 1970]));

% Clear result file
fid = fopen(resultFile, 'w');
fclose(fid);

% Display and save results
diary(resultFile)
fprintf('\n')
fprintf('* Average labor-market tightness: %4.2f \n', tightnessMean)
fprintf('* Maximum labor-market tightness: %4.2f in %4.2f \n', tightnessMax, timeline(iMax))
fprintf('* Minimum labor-market tightness: %4.2f in %4.2f \n', tightnessMin, timeline(iMin))
fprintf('* Average labor-market tightness over 1942–1945: %4.2f \n', tightness4245)
fprintf('* Average labor-market tightness over 1951–1953: %4.2f \n', tightness5153)
fprintf('* Average labor-market tightness over 1966–1969: %4.2f \n', tightness6669)
fprintf('\n')
diary off