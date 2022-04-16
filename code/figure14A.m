%% figure14A.m
% 
% Produce panel A of figure 14
%
%% Description
%
% This script produces panel A of figure 14 and associated numerical results. The figure displays 3 variants of the FERU in the United States, 1994:Q1–2024:Q2:
%
% * FERU based on concept U3 of unemployment
% * FERU based on concept U4 of unemployment
% * FERU based on concept U5 of unemployment
%
%% Requirements
%
% * inputFolder - Path to input folder (default: defined in main.m)
% * outputFolder - Path to output folder (default: defined in main.m)
% * formatFigure.m - Predefine figure properties (default: run in main.m)
%
%% Output
%
% * figure14A.pdf - PDF file with panel A of figure 14
% * figure14A.csv - CSV file with data underlying panel A of figure 14
% * figure14A.md - Markdown file with numerical results from panel A of figure 14
%

%% Construct figure name and paths to output files

% Define figure ID
figureId = '14A';

% Construct figure name
figureName = ['Figure ', figureId];

% Construct paths to output files
figureFile = fullfile(outputFolder, ['figure', figureId, '.pdf']);
dataFile = fullfile(outputFolder, ['figure', figureId, '.csv']);
resultFile = fullfile(outputFolder, ['figure', figureId, '.md']);

%% Get data

% Generate quarterly timeline based on data range
timeline = [1994 : 0.25 : 2024.25]';

% Get recession dates
[startRecession, endRecession] = getRecession345(inputFolder);

% Get unemployment and vacancy rates
[u3, u4, u5, v3, v4, v5] = getData345(inputFolder);

%% Compute FERU based on concept U3 of unemployment

uStar3 = sqrt(u3.*v3);

%% Compute FERU based on concept U4 of unemployment

uStar4 = sqrt(u4.*v4);

%% Compute FERU based on concept U5 of unemployment

uStar5 = sqrt(u5.*v5);

%% Produce figure

% Set up figure window
figure('NumberTitle', 'off', 'Name', figureName)
hold on

% Format x-axis
ax = gca;
set(ax, alternativeAxis{:})

% Format y-axis
ax.YLim = [0, 0.08];
ax.YTick = [0 : 0.02 : 0.08];
ax.YTickLabel = ["0"; "2"; "4"; "6"; "8"];
ax.YLabel.String = 'Share of labor force (percent)';

% Shade recession areas
xregion(startRecession, endRecession, grayArea{:})

% Plot FERUs
h1 = plot(timeline, uStar5);
h2 = plot(timeline, uStar4);
plot(timeline, uStar3, pinkLine{:})

% Format FERUs
h1.Color = pinkLight;
h1.LineWidth = thick;
h2.Color = pinkMedium;
h2.LineWidth = thick;

% Save figure
print('-dpdf', figureFile)

%% Save figure data

% Write header
header = {'Year', 'FERU3', 'FERU4', 'FERU5'};
writecell(header, dataFile, 'WriteMode', 'overwrite')

% Write results
data = [timeline, uStar3, uStar4, uStar5];
writematrix(round(data, 4), dataFile, 'WriteMode', 'append')

%% Produce numerical results

% Compute results
v3Mean = mean(v3);
v4Mean = mean(v4);
v5Mean = mean(v5);
u3Mean = mean(u3);
u4Mean = mean(u4);
u5Mean = mean(u5);
uStar3Mean = mean(uStar3);
uStar4Mean = mean(uStar4);
uStar5Mean = mean(uStar5);
distance4Mean = mean(uStar4 - uStar3);
[distance4Max, iMax4] = max(uStar4 - uStar3);
[distance4Min, iMin4] = min(uStar4 - uStar3);
distance5Mean = mean(uStar5 - uStar3);
[distance5Max, iMax5] = max(uStar5 - uStar3);
[distance5Min, iMin5] = min(uStar5 - uStar3);

% Clear result file
if exist(resultFile,'file'), delete(resultFile), end

% Display and save results
fprintf('\nFigure %3s\n----------\n', figureId)
diary(resultFile)
fprintf('\n')
fprintf('* Average V3 rate: %4.3f \n', v3Mean)
fprintf('* Average V4 rate: %4.3f \n', v4Mean)
fprintf('* Average V5 rate: %4.3f \n', v5Mean)
fprintf('* Average U3 rate: %4.3f \n', u3Mean)
fprintf('* Average U4 rate: %4.3f \n', u4Mean)
fprintf('* Average U5 rate: %4.3f \n', u5Mean)
fprintf('* Average FERU3: %4.3f \n', uStar3Mean)
fprintf('* Average FERU4: %4.3f \n', uStar4Mean)
fprintf('* Average FERU5: %4.3f \n', uStar5Mean)
fprintf('* Average distance between FERU3 & FERU4: %4.3f \n', distance4Mean)
fprintf('* Maximum distance between FERU3 & FERU4: %4.3f in %4.2f \n', distance4Max, timeline(iMax4))
fprintf('* Minimum distance between FERU3 & FERU4: %4.3f in %4.2f \n', distance4Min, timeline(iMin4))
fprintf('* Average distance between FERU3 & FERU5: %4.3f \n', distance5Mean)
fprintf('* Maximum distance between FERU3 & FERU5: %4.3f in %4.2f \n', distance5Max, timeline(iMax5))
fprintf('* Minimum distance between FERU3 & FERU5: %4.3f in %4.2f \n', distance5Min, timeline(iMin5))
fprintf('\n')
diary off