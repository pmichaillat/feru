%% figure13B.m
% 
% Produce panel B of figure 13
%
%% Description
%
% This script produces panel B of figure 13 and associated numerical results. The figure displays the FERU in the United States, 1930:Q1–2024:Q2, for a range of alternative calibrations:
%
% * Beveridge elasticity between 0.75 and 1.25
% * Recruiting cost between 0.75 and 1.25
% * Social product of unemployed labor between -0.25 and 0.25 
%
% For each calibration, the FERU is computed using generalized formula (8), with the other parameters set to their baseline values.
%
%% Requirements
%
% * inputFolder - Path to input folder (default: defined in main.m)
% * outputFolder - Path to output folder (default: defined in main.m)
% * formatFigure.m - Predefine figure properties (default: run in main.m)
%
%% Output
%
% * figure13B.pdf - PDF file with panel B of figure 13
% * figure13B.csv - CSV file with data underlying panel B of figure 13
% * figure13B.md - Markdown file with numerical results from panel B of figure 13
%

%% Construct figure name and paths to output files

% Define figure ID
figureId = '13B';

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

%% Calibrate parameters

% Calibrate Beveridge elasticity
epsilonBaseline = 1;
epsilonLow = 0.75;
epsilonHigh = 1.25;

% Calibrate recruiting cost
kappaBaseline = 1;
kappaLow = 0.75;
kappaHigh = 1.25;

% Calibrate social product of unemployed labor
zetaBaseline = 0;
zetaLow = -0.25;
zetaHigh = 0.25;

%% Create function to apply generalized formula (8)

uStar = @(u, v, epsilon, kappa, zeta) (kappa .* epsilon .* v .* (u.^epsilon) ./ (1 - zeta)).^(1 ./ (1 + epsilon));

%% Compute FERU using generalized formula (8) for various calibrations

% Compute baseline FERU
uStarBaseline = uStar(u, v, epsilonBaseline, kappaBaseline, zetaBaseline);

% Compute FERU for low and high Beveridge elasticities
uStarEpsilonLow = uStar(u, v, epsilonLow, kappaBaseline, zetaBaseline);
uStarEpsilonHigh = uStar(u, v, epsilonHigh, kappaBaseline, zetaBaseline);

% Compute FERU for low and high recruiting costs
uStarKappaLow = uStar(u, v, epsilonBaseline, kappaLow, zetaBaseline);
uStarKappaHigh = uStar(u, v, epsilonBaseline, kappaHigh, zetaBaseline);

% Compute FERU for low and high social products of unemployed labor
uStarZetaLow = uStar(u, v, epsilonBaseline, kappaBaseline, zetaLow);
uStarZetaHigh = uStar(u, v, epsilonBaseline, kappaBaseline, zetaHigh);

%% Produce figure

% Set up figure window
figure('NumberTitle', 'off', 'Name', figureName)
hold on

% Format x-axis
ax = gca;
set(ax, completeAxis{:})

% Format y-axis
ax.YLim = [0, 0.08];
ax.YTick = [0 : 0.02 : 0.08];
ax.YTickLabel = ["0"; "2"; "4"; "6"; "8"];
ax.YLabel.String = 'Share of labor force (percent)';

% Shade recession areas
xregion(startRecession, endRecession, grayArea{:})

% Shade FERU area for range of Beveridge elasticities
h1 = area(timeline, [uStarEpsilonLow, uStarEpsilonHigh - uStarEpsilonLow]);

% Format first FERU area
h1(1).FaceAlpha = 0;
h1(1).LineWidth = medium;
h1(1).LineStyle = '-.';
h1(1).EdgeColor = pinkLight;
h1(2).FaceAlpha = 0.2;
h1(2).FaceColor = pinkLight;
h1(2).LineWidth = medium;
h1(2).LineStyle = '-.';
h1(2).EdgeColor = pinkLight;

% Shade FERU area for range of recruiting costs
h2 = area(timeline, [uStarKappaLow, uStarKappaHigh - uStarKappaLow]);

% Format second FERU area
h2(1).FaceAlpha = 0;
h2(1).LineWidth = medium;
h2(1).LineStyle = '--';
h2(1).EdgeColor = pinkMedium;
h2(2).FaceAlpha = 0.2;
h2(2).FaceColor = pinkMedium;
h2(2).LineWidth = medium;
h2(2).LineStyle = '--';
h2(2).EdgeColor = pinkMedium;

% Shade FERU area for range of social products of unemployed labor
h3 = area(timeline, [uStarZetaLow, uStarZetaHigh - uStarZetaLow]);

% Format third FERU area
h3(1).FaceAlpha = 0;
h3(1).LineWidth = medium;
h3(1).LineStyle = ':';
h3(1).EdgeColor = pink;
h3(2).FaceAlpha = 0.2;
h3(2).FaceColor = pink;
h3(2).LineWidth = medium;
h3(2).LineStyle = ':';
h3(2).EdgeColor = pink;

% Plot baseline FERU
plot(timeline, uStarBaseline, pinkLine{:})

% Save figure
print('-dpdf', figureFile)

%% Save figure data

% Write header
header = {'Year', 'Baseline FERU', 'FERU with epsilon = 0.75', 'FERU with epsilon = 1.25', 'FERU with kappa = 0.75', 'FERU with kappa = 1.25', 'FERU with zeta = -0.25', 'FERU with zeta = 0.25'};
writecell(header, dataFile, 'WriteMode', 'overwrite')

% Write results
data = [timeline, uStarBaseline, uStarEpsilonLow, uStarEpsilonHigh, uStarKappaLow, uStarKappaHigh, uStarZetaLow, uStarZetaHigh];
writematrix(round(data, 4), dataFile, 'WriteMode', 'append')

%% Produce numerical results

% Compute results
widthEpsilonMean = mean(abs(uStarEpsilonLow - uStarEpsilonHigh));
widthKappaMean = mean(abs(uStarKappaLow - uStarKappaHigh));
widthZetaMean = mean(abs(uStarZetaLow - uStarZetaHigh));

% Clear result file
if exist(resultFile,'file'), delete(resultFile), end

% Display and save results
fprintf('\nFigure %3s\n----------\n', figureId)
diary(resultFile)
fprintf('\n')
fprintf('* Baseline FERU in 2024:Q2: %4.3f \n', uStarBaseline(end))
fprintf('* FERU with epsilon = 0.75 in 2024:Q2: %4.3f \n', uStarEpsilonLow(end))
fprintf('* FERU with epsilon = 1.25 in 2024:Q2: %4.3f \n', uStarEpsilonHigh(end))
fprintf('* FERU with kappa = 0.75 in 2024:Q2: %4.3f \n', uStarKappaLow(end))
fprintf('* FERU with kappa = 1.25 in 2024:Q2: %4.3f \n', uStarKappaHigh(end))
fprintf('* FERU with zeta = -0.25 in 2024:Q2: %4.3f \n', uStarZetaLow(end))
fprintf('* FERU with zeta = 0.25 in 2024:Q2: %4.3f \n', uStarZetaHigh(end))
fprintf('* Average width of FERU area when 0.75 < epsilon < 1.25: %4.3f \n', widthEpsilonMean)
fprintf('* Average width of FERU area when 0.75 < kappa < 1.25: %4.3f \n', widthKappaMean)
fprintf('* Average width of FERU area when -0.25 < zeta < 0.25: %4.3f \n', widthZetaMean)
fprintf('\n')
diary off