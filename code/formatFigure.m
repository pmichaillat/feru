%% formatFigure.m
% 
% Format default figure and predefine figure properties
%
%% Description
%
% This script modifies the default properties of figures. 
%
% The script also predefines a color palette composed of purple, pink, orange, and gray. Each color is specified in hexadecimal format (hex triplet) and encoded as a string.
%
% Finally, the script predefines various figure properties: for areas, for lines, for markers, and for axes. These properties are contained in cell arrays.
%
% The script is used to maintain consistent formatting across all figures.
%
%% Examples
%
%   plot(x, y, 'Color', pink)
%   xregion(x, y, grayArea{:})
%   plot(x, y, purpleLine{:})
%   plot(x, y, orangeDotDashLine{:})
%   set(gca, xPostwar{:})
%

%% Create function to convert object properties into cell arrays for application in plots

createProperty = @(obj) [fieldnames(obj), struct2cell(obj)]';

%% Set default properties for figures

widthFigure = 10;
heightFigure = 5.625;
set(groot, 'defaultFigureUnits', 'inches')
set(groot, 'defaultFigurePosition', [1, 1, widthFigure, heightFigure]);
set(groot, 'defaultFigurePaperPosition', [0, 0, widthFigure, heightFigure]);
set(groot, 'defaultFigurePaperSize', [widthFigure, heightFigure]);
set(groot, 'defaultAxesFontName', 'Helvetica')
set(groot, 'defaultAxesFontSize', 15)
set(groot, 'defaultAxesLabelFontSizeMultiplier', 1)
set(groot, 'defaultAxesTitleFontSizeMultiplier', 1)
set(groot, 'defaultAxesTitleFontWeight', 'normal')
set(groot, 'defaultAxesXColor', 'black')
set(groot, 'defaultAxesYColor', 'black')
set(groot, 'defaultAxesGridColor', 'black')
set(groot, 'defaultAxesLineWidth', 0.8)
set(groot, 'defaultAxesYGrid', 'on')
set(groot, 'defaultAxesXGrid', 'off')
set(groot, 'defaultAxesTickDirMode', 'manual')
set(groot, 'defaultAxesTickDir', 'out')
set(groot, 'defaultAxesTickLength', [0.005, 0.005])
set(groot, 'defaultAxesMinorGridLineStyle', 'none')

%% Predefine color palette

orange = '#d95f02';
purple = '#7570b3';
pink = '#e7298a';
pinkLight = '#c994c7';
pinkMedium = '#df65b0';
gray = '#bdbdbd';

%% Predefine line width

thick = 2.4;
medium = thick ./ 2;
thin = thick ./ 3;

%% Predefine area properties

% Define transparent, gray area
clear obj
obj.FaceColor = 'black';
obj.LineStyle = 'none';
obj.FaceAlpha = 0.1;
grayArea = createProperty(obj);

% Define purple and orange area for gaps
purpleOrangeArea = 	{0, purple, 'none';
					0.2, purple, 'none'; 
					0.2, orange, 'none'};

%% Predefine line properties

% Define solid thick orange line
clear obj
obj.Color = orange;
obj.LineWidth = thick;
orangeLine = createProperty(obj);

% Define dot-dashed thick orange line
clear obj
obj.Color = orange;
obj.LineWidth = thick;
obj.LineStyle = '-.';
orangeDotDashLine = createProperty(obj);

% Define dot-dashed medium orange line
clear obj
obj.Color = orange;
obj.LineWidth = medium;
obj.LineStyle = '-.';
orangeDotDashMediumLine = createProperty(obj);

% Define solid thick purple line
clear obj
obj.Color = purple;
obj.LineWidth = thick;
purpleLine = createProperty(obj);

% Define solid medium purple line
clear obj
obj.Color = purple;
obj.LineWidth = medium;
purpleMediumLine = createProperty(obj);

% Define solid thick pink line
clear obj
obj.Color = pink;
obj.LineWidth = thick;
pinkLine = createProperty(obj);

% Define solid thin pink line
clear obj
obj.Color = pink;
obj.LineWidth = thin;
pinkThinLine = createProperty(obj);

%% Predefine axis properties for various periods

% Define x-axis for 1930Q1–2024Q2
clear obj
obj.XLim = [1930, 2024.25];
obj.XTick = [1930, 1940, 1950, 1960, 1970, 1980, 1990, 2000, 2010, 2020];
x = createProperty(obj);

% Define x-axis for 1951Q1–2019Q4
clear obj
obj.XLim = [1951, 2019.75];
obj.XTick = [1951, 1960, 1970, 1980, 1990, 2000, 2010, 2019];
xPostwar = createProperty(obj);

% Define x-axis for 2020Q1–2024Q2
clear obj
obj.XLim = [2020, 2024.25];
obj.XTick = [2020, 2021, 2022, 2023, 2024];
xPandemic = createProperty(obj);

% Define x-axis for 1930Q1–1950Q4
clear obj
obj.XLim = [1930, 1950.75];
obj.XTick = [1930, 1935, 1940, 1945, 1950];
xDepression = createProperty(obj);

% Define x-axis for 1994Q1–2024Q2
clear obj
obj.XLim = [1994, 2024.25];
obj.XTick = [1994, 1999, 2004, 2009, 2014, 2019, 2024];
x345 = createProperty(obj);