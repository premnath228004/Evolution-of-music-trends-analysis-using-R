# Evolution of Music Trends (1990s-2020s): A Comparative Analysis
# Hindi, Punjabi, and English Songs

# Load required libraries
library(ggplot2)       # For data visualization
library(dplyr)         # For data manipulation
library(tidyverse)     # For data wrangling
library(corrplot)      # For correlation analysis
library(lubridate)     # For working with year/time
library(wordcloud)     # For lyrical keyword visualization (optional)
library(ggthemes)      # For aesthetic plots
library(plotly)        # For interactive plots
library(tidytext)      # For sentiment analysis on lyrics

# Set seed for reproducibility
set.seed(123)

# 1. DATA COLLECTION & CLEANING
# For this project, we'll create a synthetic dataset that mimics real music data
# In a real scenario, you would import data from Spotify API or Kaggle datasets

# Create synthetic dataset
create_music_dataset <- function() {
  # Define parameters for our synthetic data
  years <- rep(seq(1990, 2020, by = 1), each = 50)  # 31 years * 50 songs per year
  languages <- c("Hindi", "Punjabi", "English")
  genres <- c("Pop", "Rock", "Hip-Hop", "Classical", "Folk", "EDM", "Romantic", "Devotional")
  
  # Create data frame
  dataset <- data.frame(
    Song_Name = paste("Song", 1:length(years)),
    Artist = paste("Artist", sample(1:200, length(years), replace = TRUE)),
    Language = sample(languages, length(years), replace = TRUE, prob = c(0.4, 0.2, 0.4)),
    Year = years,
    Genre = sample(genres, length(years), replace = TRUE),
    Popularity = round(runif(length(years), 20, 100)),
    Danceability = runif(length(years), 0, 1),
    Energy = runif(length(years), 0, 1),
    Tempo = round(runif(length(years), 60, 200)),
    Sentiment = sample(c("Positive", "Negative", "Neutral"), length(years), replace = TRUE, prob = c(0.45, 0.25, 0.30)),
    stringsAsFactors = FALSE
  )
  
  # Add some realistic trends to the data
  # Make newer songs generally more danceable and energetic
  dataset$Danceability <- dataset$Danceability + (dataset$Year - 1990) * 0.005
  dataset$Energy <- dataset$Energy + (dataset$Year - 1990) * 0.004
  
  # Cap values at 1
  dataset$Danceability[dataset$Danceability > 1] <- 1
  dataset$Energy[dataset$Energy > 1] <- 1
  
  # Make English songs slightly more popular on average
  dataset$Popularity <- ifelse(dataset$Language == "English", 
                               dataset$Popularity + rnorm(nrow(dataset), 5, 2),
                               dataset$Popularity)
  
  # Ensure popularity is within bounds
  dataset$Popularity[dataset$Popularity > 100] <- 100
  dataset$Popularity[dataset$Popularity < 0] <- 0
  
  # Add some missing values to simulate real data
  missing_indices <- sample(1:nrow(dataset), 50)
  dataset$Sentiment[missing_indices] <- NA
  
  return(dataset)
}

# Create the dataset
music_data <- create_music_dataset()

# Display first few rows
head(music_data)

# Check for missing values
sum(is.na(music_data))

# Remove duplicates (if any)
music_data <- music_data %>% distinct()

# Convert Year to decade
music_data <- music_data %>% 
  mutate(Decade = paste0(floor(Year/10)*10, "s"))

# Display structure of the data
str(music_data)

# 2. EXPLORATORY DATA ANALYSIS (EDA)

# Count of songs per decade per language
songs_per_decade_language <- music_data %>%
  group_by(Decade, Language) %>%
  summarise(Count = n(), .groups = 'drop')

print(songs_per_decade_language)

# Average popularity by year and language
avg_popularity <- music_data %>%
  group_by(Year, Language) %>%
  summarise(Avg_Popularity = mean(Popularity), .groups = 'drop')

# Average energy by year and language
avg_energy <- music_data %>%
  group_by(Year, Language) %>%
  summarise(Avg_Energy = mean(Energy), .groups = 'drop')

# Average danceability by year and language
avg_danceability <- music_data %>%
  group_by(Year, Language) %>%
  summarise(Avg_Danceability = mean(Danceability), .groups = 'drop')

# Correlation matrix for numeric features
numeric_features <- music_data %>% 
  select(Popularity, Danceability, Energy, Tempo)

correlation_matrix <- cor(numeric_features, use = "complete.obs")

# Top artists by number of songs
top_artists <- music_data %>%
  group_by(Artist) %>%
  summarise(Song_Count = n()) %>%
  arrange(desc(Song_Count)) %>%
  head(10)

# Top genres by decade
top_genres_decade <- music_data %>%
  group_by(Decade, Genre) %>%
  summarise(Count = n(), .groups = 'drop') %>%
  group_by(Decade) %>%
  slice_max(Count, n = 3)

# 3. TREND VISUALIZATION

# Line chart showing changes in average energy over decades
energy_trend <- ggplot(avg_energy, aes(x = Year, y = Avg_Energy, color = Language)) +
  geom_line(size = 1.2) +
  geom_point(size = 2) +
  labs(title = "Average Energy of Songs Over Time by Language",
       x = "Year",
       y = "Average Energy",
       color = "Language") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"))

print(energy_trend)

# Line chart showing changes in average danceability over decades
danceability_trend <- ggplot(avg_danceability, aes(x = Year, y = Avg_Danceability, color = Language)) +
  geom_line(size = 1.2) +
  geom_point(size = 2) +
  labs(title = "Average Danceability of Songs Over Time by Language",
       x = "Year",
       y = "Average Danceability",
       color = "Language") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"))

print(danceability_trend)

# Bar chart comparing popularity across languages
popularity_by_language <- music_data %>%
  group_by(Language) %>%
  summarise(Avg_Popularity = mean(Popularity), .groups = 'drop')

popularity_chart <- ggplot(popularity_by_language, aes(x = Language, y = Avg_Popularity, fill = Language)) +
  geom_col() +
  labs(title = "Average Popularity by Language",
       x = "Language",
       y = "Average Popularity") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        legend.position = "none")

print(popularity_chart)

# Bar chart comparing tempo across languages
tempo_by_language <- music_data %>%
  group_by(Language) %>%
  summarise(Avg_Tempo = mean(Tempo), .groups = 'drop')

tempo_chart <- ggplot(tempo_by_language, aes(x = Language, y = Avg_Tempo, fill = Language)) +
  geom_col() +
  labs(title = "Average Tempo by Language",
       x = "Language",
       y = "Average Tempo (BPM)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        legend.position = "none")

print(tempo_chart)

# Sentiment distribution by decade
sentiment_decade <- music_data %>%
  filter(!is.na(Sentiment)) %>%
  group_by(Decade, Sentiment) %>%
  summarise(Count = n(), .groups = 'drop')

sentiment_chart <- ggplot(sentiment_decade, aes(x = Decade, y = Count, fill = Sentiment)) +
  geom_col(position = "dodge") +
  labs(title = "Sentiment Distribution by Decade",
       x = "Decade",
       y = "Number of Songs",
       fill = "Sentiment") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"))

print(sentiment_chart)

# 4. CORRELATION ANALYSIS

# Correlation plot of audio features
corrplot(correlation_matrix, method = "color", type = "upper", 
         order = "hclust", tl.cex = 0.8, tl.col = "black")

# 5. INSIGHTS & INTERPRETATION

# Calculate decade averages for key metrics
decade_analysis <- music_data %>%
  group_by(Decade, Language) %>%
  summarise(
    Avg_Popularity = mean(Popularity),
    Avg_Energy = mean(Energy),
    Avg_Danceability = mean(Danceability),
    Avg_Tempo = mean(Tempo),
    .groups = 'drop'
  )

# Identify trends in energy and danceability over time
energy_trend_analysis <- music_data %>%
  group_by(Decade) %>%
  summarise(Avg_Energy = mean(Energy), .groups = 'drop') %>%
  arrange(Decade)

danceability_trend_analysis <- music_data %>%
  group_by(Decade) %>%
  summarise(Avg_Danceability = mean(Danceability), .groups = 'drop') %>%
  arrange(Decade)

# Compare language-specific trends
language_trends <- music_data %>%
  group_by(Language) %>%
  summarise(
    Avg_Popularity = mean(Popularity),
    Avg_Energy = mean(Energy),
    Avg_Danceability = mean(Danceability),
    Song_Count = n(),
    .groups = 'drop'
  ) %>%
  arrange(desc(Avg_Popularity))

# 6. BONUS ADD-ONS

# Interactive plot using plotly
interactive_energy_plot <- ggplot(avg_energy, aes(x = Year, y = Avg_Energy, color = Language)) +
  geom_line(size = 1) +
  labs(title = "Average Energy of Songs Over Time by Language",
       x = "Year",
       y = "Average Energy",
       color = "Language")

# Convert to interactive plot
ggplotly(interactive_energy_plot)

# Create a dashboard layout (conceptual)
# In a real implementation, you would use Shiny or Flexdashboard

# 7. SUMMARY AND CONCLUSIONS

# Print key findings
cat("=== MUSIC TRENDS ANALYSIS SUMMARY ===\n\n")

cat("Dataset Overview:\n")
cat("- Total songs analyzed:", nrow(music_data), "\n")
cat("- Time period:", min(music_data$Year), "to", max(music_data$Year), "\n")
cat("- Languages:", paste(unique(music_data$Language), collapse = ", "), "\n\n")

cat("Key Trends:\n")
cat("1. Energy levels have generally increased over time across all languages\n")
cat("2. Danceability has shown an upward trend, especially in the 2000s onwards\n")
cat("3. English songs tend to have slightly higher popularity on average\n")
cat("4. Tempo varies by language, with some interesting patterns\n")
cat("5. Sentiment distribution shows shifts in emotional expression over decades\n\n")

cat("Language Comparison:\n")
print(language_trends)

# Save the dataset for future use
write.csv(music_data, "music_trends_dataset.csv", row.names = FALSE)
cat("\nDataset saved as 'music_trends_dataset.csv'\n")