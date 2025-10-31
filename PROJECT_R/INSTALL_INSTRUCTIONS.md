# Installing R and Required Packages

To run this music trends analysis project, you'll need to install R and the required packages. Here's how:

## Installing R

1. Go to https://cran.r-project.org/
2. Click on "Download R for Windows" (or your operating system)
3. Download the base subdirectory
4. Run the installer with default settings

## Installing RStudio (Recommended)

1. Go to https://posit.co/download/rstudio-desktop/
2. Download the free version of RStudio Desktop
3. Install with default settings

## Installing Required R Packages

Once R is installed, you need to install the required packages. You can do this in two ways:

### Method 1: Using R Console
Open R or RStudio and run:

```r
install.packages(c("ggplot2", "dplyr", "tidyverse", "corrplot", "lubridate", 
                   "wordcloud", "ggthemes", "plotly", "tidytext"))
```

### Method 2: Running from Script
In RStudio, open the `music_trends_analysis.R` file and run it line by line or select all and run.

## Troubleshooting

If you encounter any issues:

1. Make sure you have internet connection when installing packages
2. On Windows, run R/RStudio as administrator if you get permission errors
3. If a package installation fails, try installing dependencies manually:
   ```r
   install.packages("package_name", dependencies = TRUE)
   ```

4. For Mac users, you might need to install XQuartz for some visualization packages

## Running the Analysis

After installing everything:

1. Open RStudio
2. Open the `music_trends_analysis.R` file
3. Run the script by pressing Ctrl+Alt+R or clicking "Run" button

The script will generate all visualizations and save the dataset as `music_trends_dataset.csv`.