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
%   set(gca, postwarAxis{:})
%

%% Set default properties for figures

widthFigure = 10;
heightFigure = 5.625;
set(groot, 'defaultFigureUnits', 'inches')
set(groot, 'defaultFigurePosition', [1, 1, widthFigure, heightFigure])
set(groot, 'defaultFigurePaperPosition', [0, 0, widthFigure, heightFigure])
set(groot, 'defaultFigurePaperSize', [widthFigure, heightFigure])
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
grayArea = {...
	'FaceColor', 'black';
	'LineStyle', 'none';
	'FaceAlpha', 0.1
}';

% Define purple and orange area for gaps
purpleOrangeArea = {...
	0, 0.2, 0.2;
	purple, purple, orange;
	'none', 'none', 'none'
}';

%% Predefine line properties

% Define solid thick orange line
orangeLine = {...
	'Color', orange;
	'LineWidth', thick
}';

% Define dot-dashed thick orange line
orangeDotDashLine = {...
	'Color', orange;
	'LineWidth', thick;
	'LineStyle', '-.'
}';

% Define dot-dashed medium orange line
orangeDotDashMediumLine = {...
	'Color', orange;
	'LineWidth', medium;
	'LineStyle', '-.'
}';

% Define solid thick purple line
purpleLine = {...
	'Color', purple;
	'LineWidth', thick
}';

% Define solid medium purple line
purpleMediumLine = {...
	'Color', purple;
	'LineWidth', medium
}';

% Define solid thick pink line
pinkLine = {...
	'Color', pink;
	'LineWidth', thick
}';

% Define solid thin pink line
pinkThinLine = {...
	'Color', pink;
	'LineWidth', thin
}';

%% Predefine axis properties for various periods

% Define x-axis for complete period: 1930:Q1–2024:Q2
completeAxis = {...
	'XLim', [1930, 2024.25];
	'XTick', [1930, 1940, 1950, 1960, 1970, 1980, 1990, 2000, 2010, 2020]
}';

% Define x-axis for postwar period: 1951:Q1–2019:Q4
postwarAxis = {...
	'XLim', [1951, 2019.75];
	'XTick', [1951, 1960, 1970, 1980, 1990, 2000, 2010, 2019]
}';

% Define x-axis for pandemic period: 2020:Q1–2024:Q2
pandemicAxis = {...
	'XLim', [2020, 2024.25];
	'XTick', [2020, 2021, 2022, 2023, 2024]
}';

% Define x-axis for depression period: 1930:Q1–1950:Q4
depressionAxis = {...
	'XLim', [1930, 1950.75];
	'XTick', [1930, 1935, 1940, 1945, 1950]
}';

% Define x-axis for alternative unemployment measures: 1994:Q1–2024:Q2
alternativeAxis = {...
	'XLim', [1994, 2024.25];
	'XTick', [1994, 1999, 2004, 2009, 2014, 2019, 2024]
}';