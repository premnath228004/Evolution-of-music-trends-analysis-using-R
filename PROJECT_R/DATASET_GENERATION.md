# Music Trends Dataset Generation

This document explains how the complete dataset for the music trends analysis is generated.

## Dataset Structure

The dataset contains the following columns:
- `Song_Name`: Unique identifier for each song
- `Artist`: Name of the artist or composer
- `Language`: Language of the song (Hindi, Punjabi, or English)
- `Year`: Release year of the song (1990-2020)
- `Genre`: Musical genre classification
- `Popularity`: Popularity score (0-100)
- `Danceability`: Danceability metric (0-1)
- `Energy`: Energy level metric (0-1)
- `Tempo`: Beats per minute
- `Sentiment`: Lyrical sentiment (Positive, Negative, Neutral)

## Data Generation Process

The complete dataset is generated programmatically using the following approach:

1. **Time Period Coverage**: Songs from 1990 to 2020 (31 years)
2. **Language Distribution**: 
   - Hindi: 40% of songs
   - English: 40% of songs
   - Punjabi: 20% of songs
3. **Temporal Trends**: 
   - Energy and danceability increase over time
   - More recent songs tend to have higher metrics
4. **Language Characteristics**:
   - English songs have slightly higher popularity on average
   - Different tempo ranges by language
5. **Realistic Variations**:
   - Random missing values to simulate real data
   - Artist repetition to reflect prolific artists
   - Genre diversity

## Sample Data

A small sample of the data is provided in `sample_data.csv` to show the structure. The full analysis script generates a much larger dataset with 1,550 songs (50 per year across 31 years).

## Using Real Data

To use real data instead of the synthetic dataset:

1. Replace the `create_music_dataset()` function with code to import from:
   - Spotify API
   - Kaggle datasets
   - CSV files from music databases
2. Ensure the imported data has the same column structure
3. Maintain the same data types for each column

## Data Quality Features

The synthetic data generation includes several features that make it realistic:

- **Missing Values**: ~3% of sentiment values are NA to simulate incomplete data
- **Duplicates Removal**: Process to remove exact duplicates
- **Temporal Trends**: Metrics that evolve over time to reflect real music evolution
- **Language Characteristics**: Different patterns for different languages
- **Statistical Validity**: All metrics fall within realistic ranges

## Customization

The data generation parameters can be easily modified to test different hypotheses:

- Change language distribution weights
- Adjust temporal trend slopes
- Modify correlation between metrics
- Add new metrics or genres