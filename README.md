# u* = √uv : The Full-Employment Rate of Unemployment in the United States - Code and Data

This repository contains the code and data accompanying the paper "u* = √uv: The Full-Employment Rate of Unemployment in the United States", written by [Pascal Michaillat](https://pascalmichaillat.org) and [Emmanuel Saez](https://eml.berkeley.edu/~saez/), and forthcoming in the Fall 2024 issue of the Brookings Papers on Economic Activity.

## Paper webpage

The paper is available at https://pascalmichaillat.org/13/.

## Raw data

The raw data used by the code to produce the results in the paper are stored as CSV files in the `raw` folder. 

+ `20210719_cycle_dates_pasted.csv` - US business cycle dates, 1857–2020
	+ Source: [NBER (2023)](http://data.nber.org/data/cycles/)
+ `CLF16OV.csv` - US labor force level, 1948–2024
	+ Source: [BLS (2024a)](https://fred.stlouisfed.org/series/CLF16OV)
+ `CompositeHWI.xlsx - Sheet1.csv` - US vacancy rate, 1951–2020
	+ Source: [Barnichon (2010)](https://docs.google.com/spreadsheets/d/1fkMinSHkjTL99-bLZYFldQ8rHtgh8lxd)
+ `figure5.csv` - Dates of structural breaks in the US Beveridge curve, 1951–2019
	+ Source: [Michaillat and Saez (2021a)](https://github.com/pmichaillat/unemployment-gap)
+ `figure6.csv` - Elasticity of the US Beveridge curve, 1951–2019
	+ Source: [Michaillat and Saez (2021a)](https://github.com/pmichaillat/unemployment-gap)
+ `HistoricalSeries_JME_2020January.csv` - US unemployment and vacancy rates, 1890–2017
	+ Source: [Petrosky-Nadeau and Zhang (2021)](https://drive.google.com/file/d/1NcuUMRR4_fOwJW6qHb-XxitVSXXONBHW)
+ `JTSJOL.csv` - US job openings, 2001–2024
	+ Source: [BLS (2024f)](https://fred.stlouisfed.org/series/JTSJOL)
+ `LNU05026642.csv` - US marginally attached workers, 1994–2024
	+ Source: [BLS (2024h)](https://fred.stlouisfed.org/series/LNU05026642)
+ `LNU05026645.csv` - US discouraged workers, 1994–2024
	+ Source: [BLS (2024g)](https://fred.stlouisfed.org/series/LNU05026645)
+ `NROU.csv` - US NRU, 1949–2024
	+ Source: [CBO (2024)](https://fred.stlouisfed.org/series/NROU)
+ `NROUST.csv` - US short-term NRU, 1949–2021
	+ Source: [CBO (2021)](https://fred.stlouisfed.org/series/NROUST)
+ `U4RATE.csv` - US U4 unemployment rate, 1994–2024
	+ Source: [BLS (2024i)](https://fred.stlouisfed.org/series/U4RATE)
+ `U5RATE.csv` - US U5 unemployment rate, 1994–2024
	+ Source: [BLS (2024j)](https://fred.stlouisfed.org/series/U5RATE)
+ `UNRATE.csv` - US unemployment (U3) rate, 1948–2024
	+ Source: [BLS (2024k)](https://fred.stlouisfed.org/series/UNRATE)
+ `ustar.csv` - US NAIRU, 1960–2023
	+ Source: [Crump, Eusepi, Giannoni, and Sahin (2024)](https://doi.org/10.1016/j.jmoneco.2024.103580)

## Code

The results in the paper are obtained using MATLAB. The MATLAB code is located in the `code` folder.

### Main script

The main script, `main.m`, orchestrates the production of the results in the paper:

+ The script produces the 30 figures presented in the paper. The script generates each figure in a figure window and saves the figures as PDF files. The script saves the data used to generate each figure as CSV files.
+ The script also produces the numerical results associated with each figure. The results are displayed in the command window and saved in Markdown files.

### Formatting script

Before the computations begin, the main script calls the script `formatFigure.m` to preformat figures and predefine figure properties.

### Production scripts

The main script then produces the figures using a collection of scripts:

+ `figure1A.m` - Produce panel A of figure 1
+ `figure1B.m` - Produce panel B of figure 1
+ `figure2.m` - Produce panels A, B, C, D, E, and F of figure 2
+ `figure3A.m` - Produce panel A of figure 3
+ `figure3B.m` - Produce panel B of figure 3
+ `figure4A.m` - Produce panel A of figure 4
+ `figure4B.m` - Produce panel B of figure 4
+ `figure5A.m` - Produce panel A of figure 5
+ `figure5B.m` - Produce panel B of figure 5
+ `figure6A.m` - Produce panel A of figure 6
+ `figure6B.m` - Produce panel B of figure 6
+ `figure7A.m` - Produce panel A of figure 7
+ `figure7B.m` - Produce panel B of figure 7
+ `figure8A.m` - Produce panel A of figure 8
+ `figure8B.m` - Produce panel B of figure 8
+ `figure9A.m` - Produce panel A of figure 9
+ `figure9B.m` - Produce panel B of figure 9
+ `figure10.m` - Produce figure 10
+ `figure11.m` - Produce figure 11
+ `figure12.m` - Produce figure 12
+ `figure13A.m` - Produce panel A of figure 13
+ `figure13B.m` - Produce panel B of figure 13
+ `figure14A.m` - Produce panel A of figure 14
+ `figure14B.m` - Produce panel B of figure 14
+ `figure15.m` - Produce figure 15

The scripts display the figures in MATLAB figure windows, save each figure as a PDF file, and save the underlying data as CSV files. The scripts also produce the numerical results associated with the figures. The results are displayed in the MATLAB command window and saved in Markdown files.

### Helper functions

The production scripts rely on a collection of helper functions:
 
+ `getBreak` - Return dates of structural breaks of the US Beveridge curve, 1951–2019
+ `getData345` - Return US U3, U4, U5 unemployment rates, 1994–2024
+ `getElasticity` - Return elasticity of the US Beveridge curve, 1951–2019
+ `getNairu` - Return US NAIRU, 1960–2023
+ `getNru` - Return US NRU, 1949–2024
+ `getNrust` - Return US short-term NRU, 1949–2021
+ `getRecession.m` - Return US recession dates, 1930–2024
+ `getRecession345` - Return US recession dates, 1994–2024
+ `getRecessionDepression.m` - Return US recession dates, 1930–1950
+ `getRecessionPandemic.m` - Return US recession dates, 2020–2024
+ `getRecessionPostwar.m` - Return US recession dates, 1951–2019
+ `getUnemployment.m` - Return US unemployment rate, 1930–2024
+ `getUnemploymentDepression.m` - Return US unemployment rate, 1930–1950
+ `getUnemploymentJolts.m` - Return US unemployment rate, 2001–2024
+ `getUnemploymentPandemic.m` - Return US unemployment rate, 2020–2024
+ `getUnemploymentPostwar.m` - Return US unemployment rate, 1951–2019
+ `getVacancy.m` - Return US vacancy rate, 1930–2024
+ `getVacancyDepression.m` - Return US vacancy rate, 1930–2024
+ `getVacancyJolts.m` - Return US vacancy rate, 2001–2024
+ `getVacancyPandemic.m` - Return US vacancy rate, 2020–2024
+ `getVacancyPostwar.m` - Return US vacancy rate, 1951–2019
+ `monthly2quarterly.m` - Convert monthly data to quarterly data

## Figures

The figures produced by the code are saved as PDF files. The data used to generate the figures are saved as CSV files. And the numerical results associated with the figures are saved in Markdown files. All the files are located in the `figures` folder, each corresponding to a specific figure in the paper:

+ `figure1A.pdf`, `figure1A.csv`, `figure1A.md` - Panel A of figure 1
+ `figure1B.pdf`, `figure1B.csv` - Panel B of figure 1
+ `figure2A.pdf`, `figure2.csv` - Panel A of figure 2
+ `figure2B.pdf`, `figure2.csv` - Panel B of figure 2
+ `figure2C.pdf`, `figure2.csv` - Panel C of Figure 2
+ `figure2D.pdf`, `figure2.csv` - Panel D of Figure 2
+ `figure2E.pdf`, `figure2.csv` - Panel E of Figure 2
+ `figure2F.pdf`, `figure2.csv` - Panel F of Figure 2
+ `figure3A.pdf`, `figure3A.csv` - Panel A of figure 3
+ `figure3B.pdf`, `figure3B.csv`, `figure3B.md` -  Panel B of figure 3
+ `figure4A.pdf`, `figure4A.csv`, `figure4A.md` - Panel A of figure 4
+ `figure4B.pdf`, `figure4B.csv`, `figure4B.md` - Panel B of figure 4
+ `figure5A.pdf`, `figure5A.csv`, `figure5A.md` - Panel A of figure 5
+ `figure5B.pdf`, `figure5B.csv`, `figure5B.md` - Panel B of figure 5
+ `figure6A.pdf`, `figure6A.csv` - Panel A of figure 6
+ `figure6B.pdf`, `figure6B.csv`, `figure6B.md` - Panel B of figure 6
+ `figure7A.pdf`, `figure7A.csv`, `figure7A.md` - Panel A of figure 7
+ `figure7B.pdf`, `figure7B.csv`, `figure7B.md` - Panel B of figure 7
+ `figure8A.pdf`, `figure8A.csv`, `figure8A.md` - Panel A of figure 8
+ `figure8B.pdf`, `figure8B.csv`, `figure8B.md` - Panel B of figure 8
+ `figure9A.pdf`, `figure9A.csv`, `figure9A.md` - Panel A of figure 9
+ `figure9B.pdf`, `figure9B.csv`, `figure9B.md` - Panel B of figure 9
+ `figure10.pdf`, `figure10.csv` - Figure 10
+ `figure11.pdf`, `figure11.csv`, `figure11.md` - Figure 11
+ `figure12.pdf`, `figure12.csv`, `figure12.md` - Figure 12
+ `figure13A.pdf`, `figure13A.csv`, `figure13A.md` - Panel A of figure 13
+ `figure13B.pdf`, `figure13B.csv`, `figure13B.md` - Panel B of figure 13
+ `figure14A.pdf`, `figure14A.csv`, `figure14A.md` - Panel A of figure 14
+ `figure14B.pdf`, `figure14B.csv`, `figure14B.md` - Panel B of figure 14
+ `figure15.pdf`, `figure15.csv`, `figure15.md` - Figure 15

## Usage

1. Clone the repository to your local machine using Git or by downloading the ZIP file.

2. Open MATLAB and set the `code` folder as the current folder.

3. To generate the figures and numerical results presented in the paper, run the following command in the MATLAB command window:

```matlab
run('main.m')
```

4. By default, the main script overwrites the files in the `figures` folder. To preserve existing files, make a copy of the folder before running the script.

## Software

The results were obtained using MATLAB R2024a on macOS Sequoia (Apple silicon). Some scripts required the Statistics and Machine Learning Toolbox.

## License

This repository is licensed under the [MIT License](LICENSE.md).