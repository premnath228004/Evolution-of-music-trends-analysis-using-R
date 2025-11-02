# Evolution of Music Trends (1990s–2020s): A Comparative Analysis

This project analyzes and visualizes how music trends have evolved across three major languages — Hindi, Punjabi, and English — from the 1990s to the 2020s. The analysis explores how features like song duration, popularity, danceability, energy, and lyrical sentiment have changed over time using data-driven insights.

## Project Overview

### Objective
To analyze and visualize how music trends have evolved across three major languages — Hindi, Punjabi, and English — from the 1990s to the 2020s. The project aims to explore how features like song duration, popularity, danceability, energy, and lyrical sentiment have changed over time, using data-driven insights.

### Dataset
The project uses a synthetic dataset that mimics real music data with the following columns:
- `Song_Name`: Name of the song
- `Artist`: Artist name
- `Language`: Language of the song (Hindi, Punjabi, English)
- `Year`: Release year
- `Genre`: Music genre
- `Popularity`: Popularity score (0-100)
- `Danceability`: Danceability score (0-1)
- `Energy`: Energy level (0-1)
- `Tempo`: Beats per minute
- `Sentiment`: Lyrical sentiment (Positive, Negative, Neutral)

In a real-world scenario, this data could be collected from Spotify API or Kaggle music datasets.

## Libraries Used
- `ggplot2`: For data visualization
- `dplyr`: For data manipulation
- `tidyverse`: For data wrangling
- `corrplot`: For correlation analysis
- `lubridate`: For working with year/time
- `wordcloud`: For lyrical keyword visualization (optional)
- `ggthemes`: For aesthetic plots
- `plotly`: For interactive plots
- `tidytext`: For sentiment analysis on lyrics

## Key Analysis Components

### 1. Data Collection & Cleaning
- Synthetic dataset generation with realistic trends
- Handling of missing values
- Data transformation for analysis

### 2. Exploratory Data Analysis (EDA)
- Count of songs per decade per language
- Average popularity, energy, and danceability by year
- Correlation matrix between song features
- Top artists and genres over time

### 3. Trend Visualization
- Line charts showing changes in average energy/danceability over decades
- Bar charts comparing popularity and tempo across languages
- Sentiment distribution by decade
- Correlation heatmap of music features

### 4. Insights & Interpretation
- Analysis of which language's songs became more energetic over time
- Examination of the shift from slow romantic songs to high-energy beats
- Discussion of cultural and technological influences on music trends

## Expected Visual Outputs
1. Trend lines showing "energy" and "popularity" growth over years
2. Comparison bar plot of languages' average tempo
3. Correlation heatmap of music features
4. Sentiment comparison per decade

## How to Run the Analysis

1. Make sure you have R installed on your system
2. Install the required packages:
```r
install.packages(c("ggplot2", "dplyr", "tidyverse", "corrplot", "lubridate", 
                   "wordcloud", "ggthemes", "plotly", "tidytext"))
```
3. Open `music_trends_analysis.R` in RStudio or your preferred R environment
4. Run the script to generate all analyses and visualizations

## Results Summary

The analysis reveals interesting trends in music evolution:
- Energy and danceability levels have generally increased over time across all languages
- English songs tend to have slightly higher popularity on average
- Tempo varies by language, with interesting patterns emerging
- Sentiment distribution shows shifts in emotional expression over decades
- The transition from the emotional melodies of the 90s to upbeat digital tracks of the 2020s reflects broader cultural and technological changes

## Bonus Features Implemented
- Interactive plots using plotly
- Sentiment analysis framework (ready for real lyric data)
- Dashboard layout concept (can be expanded with Shiny)

## Files in This Repository
- `music_trends_analysis.R`: Main R script containing all analysis
- `music_trends_dataset.csv`: Generated dataset (created when running the script)
- `README.md`: This file

## Future Enhancements
1. Integration with Spotify API for real data
2. Implementation of a full Shiny dashboard
3. Advanced sentiment analysis using tidytext on actual lyrics
4. Additional visualizations for deeper insights
5. Machine learning models to predict trends