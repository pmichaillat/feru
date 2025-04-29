%% figure14B.m
% 
% Produce panel B of figure 14
%
%% Description
%
% This script produces panel B of figure 14 and associated numerical results. The figure displays 3 variants of the unemployment gap in the United States, 1994:Q1–2024:Q2:
%
% * Unemployment gap based on concept U3 of unemployment
% * Unemployment gap based on concept U4 of unemployment
% * Unemployment gap based on concept U5 of unemployment
%
%% Requirements
%
% * inputFolder - Path to input folder (default: defined in main.m)
% * outputFolder - Path to output folder (default: defined in main.m)
% * formatFigure.m - Predefine figure properties (default: run in main.m)
%
%% Output
%
% * figure14B.pdf - PDF file with panel B of figure 14
% * figure14B.csv - CSV file with data underlying panel B of figure 14
% * figure14B.md - Markdown file with numerical results from panel B of figure 14
%

%% Construct figure name and paths to output files

% Define figure ID
figureId = '14B';

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

%% Compute FERU and unemployment gap based on concept U3 of unemployment

% Compute FERU
uStar3 = sqrt(u3 .* v3);

% Compute unemployment gap
gap3 = u3 - uStar3;

%% Compute FERU and unemployment gap based on concept U4 of unemployment

% Compute FERU
uStar4 = sqrt(u4 .* v4);

% Compute unemployment gap
gap4 = u4 - uStar4;

%% Compute FERU and unemployment gap based on concept U5 of unemployment

% Compute FERU
uStar5 = sqrt(u5 .* v5);

% Compute unemployment gap
gap5 = u5 - uStar5;

%% Produce figure

% Set up figure window
figure('NumberTitle', 'off', 'Name', figureName)
hold on

% Format x-axis
ax = gca;
set(ax, alternativeAxis{:})

% Format y-axis
ax.YLim = [-0.02, 0.08];
ax.YTick = [-0.02 : 0.02 : 0.08];
ax.YTickLabel = ["-2"; "0"; "2"; "4"; "6"; "8"];
ax.YLabel.String = 'Share of labor force (percentage points)';

% Shade recession areas
xregion(startRecession, endRecession, grayArea{:})

% Plot unemployment gaps
h1 = plot(timeline, gap5);
h2 = plot(timeline, gap4);
plot(timeline, gap3, purpleLine{:})

% Format unemployment gaps
h1.Color = '#bcbddc';
h1.LineWidth = thick;
h2.Color = '#9e9ac8';
h2.LineWidth = thick;

% Plot full-employment line
plot(timeline, zeros(size(timeline)), pinkThinLine{:})

% Save figure
print('-dpdf', figureFile)

%% Save figure data

% Write header
header = {'Year', 'U3 gap', 'U4 gap', 'U5 gap'};
writecell(header, dataFile, 'WriteMode', 'overwrite')

% Write results
data = [timeline, gap3, gap4, gap5];
writematrix(round(data, 4), dataFile, 'WriteMode', 'append')

%% Produce numerical results

% Compute results
gap3Mean = mean(gap3);
gap4Mean = mean(gap4);
gap5Mean = mean(gap5);
distance4Mean = mean(gap4 - gap3);
[distance4Max, iMax4] = max(gap4 - gap3);
[distance4Min, iMin4] = min(gap4 - gap3);
distance5Mean = mean(gap5 - gap3);
[distance5Max, iMax5] = max(gap5 - gap3);
[distance5Min, iMin5] = min(gap5 - gap3);

% Clear result file
if exist(resultFile,'file'), delete(resultFile), end

% Display and save results
fprintf('\nFigure %3s\n----------\n', figureId)
diary(resultFile)
fprintf('\n')
fprintf('* Average U3 gap: %4.3f \n', gap3Mean)
fprintf('* Average U4 gap: %4.3f \n', gap4Mean)
fprintf('* Average U5 gap: %4.3f \n', gap5Mean)
fprintf('* U3 gap in 2024:Q2: %4.3f \n', gap3(end))
fprintf('* U4 gap in 2024:Q2: %4.3f \n', gap4(end))
fprintf('* U5 gap in 2024:Q2: %4.3f \n', gap5(end))
fprintf('* Average distance between U3 gap & U4 gap: %4.3f \n', distance4Mean)
fprintf('* Maximum distance between U3 gap & U4 gap: %4.3f in %4.2f \n', distance4Max, timeline(iMax4))
fprintf('* Minimum distance between U3 gap & U4 gap: %4.3f in %4.2f \n', distance4Min, timeline(iMin4))
fprintf('* Average distance between U3 gap & U5 gap: %4.3f \n', distance5Mean)
fprintf('* Maximum distance between U3 gap & U5 gap: %4.3f in %4.2f \n', distance5Max, timeline(iMax5))
fprintf('* Minimum distance between U3 gap & U5 gap: %4.3f in %4.2f \n', distance5Min, timeline(iMin5))
fprintf('\n')
diary off