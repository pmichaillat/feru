%% figure14A.m
% 
% Produce figure 14A
%
%% Description
%
% This script produces figure 14A and associated numerical results. The figure displays 3 variants of the quarterly FERU in the United States, 1994Q1–2024Q2:
%
% * FERU based on concept U3 of unemployment
% * FERU based on concept U4 of unemployment
% * FERU based on concept U5 of unemployment
%
%% Requirements
%
% * inputFolder – String giving the location of the input folder. By default inputFolder is defined in main.m.
% * outputFolder – String giving the location of the output folder. By default outputFolder is defined in main.m.
% * formatFigure.m – Script defining plot colors and properties. By default formatFigure.m is run in main.m.
%
%% Output
%
% * figure14A.pdf – PDF file with figure 14A
% * figure14A.csv – CSV file with data underlying figure 14A
% * figure14A.md – Markdown file with numerical results associated with figure 14A.
%

%% Specify figure name and output files

% Define figure number
number = '14A';

% Construct figure name
figureName = ['Figure ', number];

% Construct file names
figureFile = fullfile(outputFolder, ['figure', number, '.pdf']);
dataFile = fullfile(outputFolder, ['figure', number, '.csv']);
resultFile = fullfile(outputFolder, ['figure', number, '.md']);

%% Get data

% Produce quarterly timeline
timeline = [1994 : 0.25 : 2024.25]';

% Get recessions dates
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

figure('NumberTitle', 'off', 'Name', figureName)
hold on

% Format x-axis
ax = gca;
set(ax, x345{:})

% Format y-axis
ax.YLim = [0, 0.08];
ax.YTick =  [0:0.02:0.08];
ax.YTickLabel = ['0%'; '2%'; '4%'; '6%'; '8%'];
ax.YLabel.String =  'Share of labor force';

% Paint recession areas
xregion(startRecession, endRecession, grayArea{:});

% Plot FERUs
h1 = plot(timeline, uStar5);
h2 = plot(timeline, uStar4);
plot(timeline, uStar3, pinkLine{:})

% Format FERUs
h1.Color = '#c994c7';
h1.LineWidth = 2.4;
h2.Color = '#df65b0';
h2.LineWidth = 2.4;

% Save figure
print('-dpdf', figureFile)

%% Save figure data

% Write header
header = {'Year', 'FERU3', 'FERU4', 'FERU5'};
writecell(header, dataFile, 'WriteMode', 'overwrite')

% Write results
data = [timeline, uStar3, uStar4, uStar5];
writematrix(round(data,4), dataFile, 'WriteMode', 'append')

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
fid = fopen(resultFile, 'w');
fclose(fid);

% Display and save results
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