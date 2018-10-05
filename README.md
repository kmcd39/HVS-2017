# HVS-2017
Sets up public-use microdata for the 2017 NYC Housing &amp; Vacancy Survey for analysis in R.

This repository contains scripts to download and setup the data for the NYCHVS.
Information on this survey and the microdata is found on the census website:
https://www.census.gov/programs-surveys/nychvs/about.html

The .RDS files in the subfolder in the repository were created through the SAS import scripts available on the census website and the scripts numbered 2 & 3 in the repository.
Script 4 sets up the microdata as survey objects to use with the survey or svryr packages in R.
If you download the raw data and run the "set up workspace" script you'll have the hvs data and survey objects ready to use.

"Renaming hvs values" changes from the survey encoding to English names for selected columns.

