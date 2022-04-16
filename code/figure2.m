%% figure2.m
% 
% Produce panels A, B, C, D, E, and F of figure 2
%
%% Description
%
% This script produces panels A–F of figure 2. The six panels display on log scales the six branches of the Beveridge curve in the United States, 1951:Q1–2019:Q4.
%
%% Requirements
%
% * inputFolder - Path to input folder (default: defined in main.m)
% * outputFolder - Path to output folder (default: defined in main.m)
% * formatFigure.m - Predefine figure properties (default: run in main.m)
%
%% Output
%
% * figure2A.pdf - PDF file with panel A of figure 2
% * figure2B.pdf - PDF file with panel B of figure 2
% * figure2C.pdf - PDF file with panel C of figure 2
% * figure2D.pdf - PDF file with panel D of figure 2
% * figure2E.pdf - PDF file with panel E of figure 2
% * figure2F.pdf - PDF file with panel F of figure 2
% * figure2.csv - CSV file with data underlying panels A–F of figure 2
%

%% Specify figure names and output files

clear figureName figureFile

% Define figure ID and panels
figureId = '2';
panel = {'A', 'B', 'C', 'D', 'E', 'F'};

% Construct figure names and files
for iPanel = 1 : 6
	figureName{iPanel} = ['Figure ', figureId, panel{iPanel}];
    figureFile{iPanel} = fullfile(outputFolder, ['figure', figureId, panel{iPanel}, '.pdf']);
end

% Construct data file
dataFile = fullfile(outputFolder, ['figure', figureId, '.csv']);

%% Get data

% Generate quarterly timeline based on data range
timeline = [1951 : 0.25 : 2019.75]';

% Get unemployment rate
u = getUnemploymentPostwar(inputFolder);

% Get vacancy rate
v = getVacancyPostwar(inputFolder);

% Get break dates in Beveridge curve
breakDate = getBreak(inputFolder);

%% Construct branches of Beveridge curve

% Construct start and end dates for branches
startBranch = [1951; breakDate + 0.25];
endBranch = [breakDate; 2019.75];
nBranch = numel(startBranch);

% Get indices for each branch
clear branch
for iBranch = 1 : nBranch 
	branch{iBranch} = [(timeline >= startBranch(iBranch)) & (timeline <= endBranch(iBranch))];
end

%% Produce figures

for iBranch = 1 : nBranch

	% Set up figure window
	fig = figure('NumberTitle', 'off', 'Name', figureName{iBranch});
	hold on
	
	% Set figure to 4:3 ratio
	widthFigure = 8.5;
	heightFigure = 6.375;
	fig.Position = [1, 1, widthFigure, heightFigure];
	fig.PaperPosition = [0, 0, widthFigure, heightFigure];
	fig.PaperSize = [widthFigure, heightFigure];

	% Format axes
	ax = gca;
	ax.FontSize = 26;
	ax.LineWidth = 1.3;
	ax.XGrid = 'on';
	ax.TickLength = [0, 0];

	% Format x-axis
	ax.XLim = log([0.02, 0.16]);
	ax.XTick = log([0.02, 0.04, 0.08, 0.16]);
	ax.XTickLabel = ["2"; "4"; "8"; "16"];
	ax.XLabel.String = 'Unemployment rate (percent on log scale)';

	% Format y-axis
	ax.YLim = log([0.01, 0.08]);
	ax.YTick = log([0.01, 0.02, 0.04, 0.08]);
	ax.YTickLabel = ["1"; "2"; "4"; "8"];
	ax.YLabel.String = 'Vacancy rate (percent on log scale)';

	% Slightly adjust axes position for better layout
	ax.Position = ax.Position + [0.002, 0.002, 0, 0]; 

	% Plot background Beveridge curve
	h1 = plot(log(u), log(v));

	% Format background Beveridge curve
	h1.Color = gray;
	h1.LineWidth = 1.3;
	h1.LineStyle = '-.';

	% Plot branch of Beveridge curve
	h2 = plot(log(u(branch{iBranch})), log(v(branch{iBranch})));

	% Format branch of Beveridge curve
	h2.LineStyle = 'none';
	h2.Color = purple;
	h2.MarkerFaceColor = purple;
	h2.Marker = 'o';
	h2.MarkerSize = 9;

	% Save figure
	print('-dpdf', figureFile{iBranch})

end

%% Save figure data

% Create empty matrix for data
data = zeros(numel(timeline), 3 + 2 .* nBranch);

%Create initial header
header = {'Year', 'Unemployment rate', 'Vacancy rate'};

% Add initial data
data(:, 1) = timeline;
data(:, 2) = u;
data(:, 3) = v;

% Add data for each branch
for iBranch = 1 : nBranch
	header = {header{:}, ['Unemployment rate: branch ', num2str(iBranch)], ['Vacancy rate: branch ', num2str(iBranch)]};
	data(branch{iBranch}, 3 + iBranch .* 2 - 1) = u(branch{iBranch});
	data(branch{iBranch}, 3 + iBranch .* 2) = v(branch{iBranch});
end

% Write header
writecell(header, dataFile, 'WriteMode', 'overwrite')

% Write data
writematrix(round(data, 4), dataFile, 'WriteMode', 'append')