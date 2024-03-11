# Install required packages
install.packages("tidyverse")  # For data manipulation and visualization
install.packages("here")       # For easy file path management
install.packages("janitor")    # For data cleaning tasks
install.packages("lubridate")  # For working with dates and times
install.packages("skimr")      # For summary statistics and data visualization


# Load required libraries
library(tidyverse)
library(here)
library(janitor)
library(lubridate)
library(skimr)


# Read data from CSV files
daily_activity <- read.csv("~/R Code/Fitabase Data 4.12.16-5.12.16/dailyActivity_merged.csv")
daily_sleep <- read_csv("~/R Code/Fitabase Data 4.12.16-5.12.16/sleepDay_merged.csv")
weight <- read_csv("~/R Code/Fitabase Data 4.12.16-5.12.16/weightLogInfo_merged.csv")
hourly_intensity <- read_csv("~/R Code/Fitabase Data 4.12.16-5.12.16/hourlyIntensities_merged.csv")
hourly_calories <- read_csv("~/R Code/Fitabase Data 4.12.16-5.12.16/hourlyCalories_merged.csv")
hourly_steps <- read_csv("~/R Code/Fitabase Data 4.12.16-5.12.16/hourlySteps_merged.csv")


# View each dataset interactively
view(daily_activity)
view(daily_sleep)
view(weight)
view(hourly_intensity)
view(hourly_calories)
view(hourly_steps)


# Display the first few rows of each dataset
head(daily_activity)
head(daily_sleep)
head(weight)
head(hourly_intensity)
head(hourly_calories)
head(hourly_steps)


# Display column names of each dataset
colnames(daily_activity)
colnames(daily_sleep)
colnames(weight)
colnames(hourly_intensity)
colnames(hourly_calories)
colnames(hourly_steps)


# Merging hourly_intensity, hourly_calories, and hourly_steps into one single dataframe
hourly_activity <- merge(hourly_intensity, hourly_calories, by=c("Id","ActivityHour"))
hourly_activity <- merge(hourly_activity, hourly_steps, by=c("Id","ActivityHour"))


# Explore the merged dataframe hourly_activity
head(hourly_activity)
view(hourly_activity)
colnames(hourly_activity)


# Clean column names for each dataframe
daily_activity <- clean_names(daily_activity)
daily_sleep <- clean_names(daily_sleep)
weight <- clean_names(weight)
hourly_activity <- clean_names(hourly_activity)


# Display the number of rows with NA values in each dataframe
sum(is.na(daily_activity))
sum(is.na(daily_sleep))
sum(is.na(weight))
sum(is.na(hourly_activity))


# Remove rows with NA values in weight dataframe
weight <- na.omit(weight)
sum(is.na(weight))


# Display the number of rows in each dataframe
nrow(daily_activity)
nrow(daily_sleep)
nrow(weight)
nrow(hourly_activity)


# Determine the number of unique participants
n_distinct(daily_activity$id)
n_distinct(daily_sleep$id)
n_distinct(weight$id)
n_distinct(hourly_activity$id)


# Note: 
# The 'weight' dataframe contains only 2 distinct participants, 
# which results in a sample size that is too small for further analysis. 
# Therefore, this dataframe will be excluded from further analysis.


# Count duplicated rows in each dataframe
sum(duplicated(daily_activity))
sum(duplicated(daily_sleep))
sum(duplicated(hourly_activity))


# Remove duplicated rows in daily_sleep dataframe
daily_sleep <- unique(daily_sleep)
sum(duplicated(daily_sleep))


# Convert date and time format in daily_activity, daily_sleep, and hourly_activity dataframes
daily_activity$activity_date <- format(mdy(daily_activity$activity_date), "%d/%m/%Y")
daily_sleep$sleep_day <- format(mdy_hms(daily_sleep$sleep_day), "%d/%m/%Y %H:%M:%S")
hourly_activity$activity_hour <- format(mdy_hms(hourly_activity$activity_hour), "%d/%m/%Y %H:%M:%S")


# Extract day of the week from the activity date in daily_activity dataframe
daily_activity$day_of_week <- wday(daily_activity$activity_date)


# Convert numerical day_of_week to corresponding weekday names in daily_activity dataframe
daily_activity <- daily_activity %>% 
  mutate(day_of_week = recode(day_of_week,"1" = "Sunday","2" = "Monday","3" = "Tuesday","4" = "Wednesday","5" = "Thursday","6" = "Friday","7" = "Saturday"))


# Arrange day_of_week column in daily_activity dataframe for visualization clarity
daily_activity$day_of_week <- ordered(daily_activity$day_of_week, levels=c("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"))


# Calculate total active hours from various activity minutes columns in daily_activity dataframe
daily_activity$total_active_hours = (daily_activity$fairly_active_minutes + daily_activity$lightly_active_minutes + daily_activity$sedentary_minutes + daily_activity$very_active_minutes)/60
daily_activity$total_active_hours <- round(daily_activity$total_active_hours,2)


# Calculate total hours asleep and total hours in bed from total minutes in daily_sleep dataframe
daily_sleep$total_hours_asleep = round((daily_sleep$total_minutes_asleep)/60,2)
daily_sleep$total_hours_in_bed = round((daily_sleep$total_time_in_bed)/60,2)


## Summary statistics:

#For the daily activity dataframe:
daily_activity %>%  
  select(total_steps,
         total_distance,
         sedentary_minutes) %>%
  summary()

#For the daily sleep dataframe:
daily_sleep %>%  
  select(total_sleep_records,
         total_minutes_asleep,
         total_time_in_bed) %>%
  summary()

#For the hourly activity dataframe:
hourly_activity %>%  
  select(total_intensity,
         average_intensity,
         calories,
         step_total) %>%
  summary()


# Merge daily_activity and daily_sleep dataframes by 'id' column, including all observations
combined_data <- merge(daily_activity, daily_sleep, by="id", all = TRUE)
view(combined_data)
nrow(combined_data)
n_distinct(combined_data$id)
sum(duplicated(combined_data))


## Plotting explorations:

# Relationship between steps taken in a day and sedentary minutes
ggplot(data=daily_activity, aes(x=total_steps, y=sedentary_minutes)) + 
  geom_point(alpha = 0.5, color = "blue") +
  labs(x = "Total Steps", y = "Sedentary Minutes") +
  ggtitle("Correlation between Steps and Sedentary Minutes") +
  geom_smooth(method = 'lm', se = TRUE, color = 'black', size = 0.5) 

# Calculate correlation coefficient between total steps and sedentary minutes
correlation <- cor(daily_activity$total_steps, daily_activity$sedentary_minutes, use = "complete.obs")
print(paste("Correlation coefficient between total steps and sedentary minutes:", correlation))



# Relationship between minutes asleep and time in bed
ggplot(data=daily_sleep, aes(x=total_minutes_asleep, y=total_time_in_bed)) + 
  geom_point(alpha = 0.5, color = "red") +
  labs(x = "Minutes Slept", y = "Minutes Spent in Bed") +
  ggtitle("Correlation between Minutes Slept and Minutes Spent in Bed") +
  geom_smooth(method = 'lm', se = TRUE, color = 'black', size = 0.5) 

# Calculate correlation coefficient between minutes asleep and time in bed
correlation <- cor(daily_sleep$total_minutes_asleep, daily_sleep$total_time_in_bed, use = "complete.obs")
print(paste("Correlation coefficient between minutes asleep and time in bed:", correlation))



# Relationship between total steps and calories burned
ggplot(data = daily_activity, aes(x = total_steps, y = calories)) +
  geom_point(alpha = 0.6, color = "purple") +
  labs(x = "Total Steps", y = "Calories Burned") +
  ggtitle("Correlation between Steps and Calories Burned") +
  geom_smooth(method = 'lm', se = FALSE, color = 'black', size = 0.5)

# Calculate correlation coefficient between total steps and calories burned
correlation <- cor(daily_activity$total_steps, daily_activity$calories, use = "complete.obs")
print(paste("Correlation coefficient between total steps and calories burned:", correlation))



# Relationship between hours asleep and calories burned
ggplot(data = combined_data, aes(x = total_hours_asleep, y = calories)) +
  geom_point(color = 'skyblue') +
  labs(x = "Time Asleep (Hours)", y = "Calories Burned") +
  ggtitle("Relationship between Time Slept and Calories Burned")

# Calculate correlation coefficient between total hours asleep and calories burned
correlation <- cor(combined_data$total_hours_asleep, combined_data$calories, use = "complete.obs")
print(paste("Correlation coefficient between total hours asleep and calories burned:", correlation))



# Relationship between total active hours and calories burned
ggplot(data = combined_data, aes(x = total_active_hours, y = calories)) +
  geom_point(color = 'purple') +
  labs(x = "Total Active Hours", y = "Calories Burned") +
  ggtitle("Relationship between Total Active Hours and Calories Burned") +
  geom_smooth(se = TRUE, color = 'black', size = 0.5) 

# Calculate correlation coefficient between total active hours and calories burned
correlation <- cor(combined_data$total_active_hours, combined_data$calories, use = "complete.obs")
print(paste("Correlation coefficient between total active hours and calories burned:", correlation))



# Relationship between total active hours and sedentary minutes
ggplot(data = combined_data, aes(x = total_active_hours, y = sedentary_minutes)) +
  geom_point(color = 'darkgreen') +
  labs(x = "Total Active Hours", y = "Sedentary Minutes") +
  ggtitle("Relationship between Total Active Hours and Sedentary Minutes") +
  geom_smooth(method = 'lm', se = TRUE, color = 'black', size = 0.5) 

# Calculate correlation coefficient between total active hours and sedentary minutes
correlation <- cor(combined_data$total_active_hours, combined_data$sedentary_minutes, use = "complete.obs")
print(paste("Correlation coefficient between total active hours and sedentary minutes:", correlation))



# Calculate the average minutes for each activity level by day of the week
avg_activity <- aggregate(cbind(sedentary_minutes, lightly_active_minutes, 
                                fairly_active_minutes, very_active_minutes) ~ day_of_week, 
                          data = daily_activity, FUN = mean)

# Reshape the data to long format for ggplot
avg_activity_long <- tidyr::gather(avg_activity, activity_type, avg_minutes, 
                                   sedentary_minutes:very_active_minutes)

# Plot average activity by day of the week with different activity types
ggplot(data = avg_activity_long, aes(x = day_of_week, y = avg_minutes, fill = activity_type)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "Day of the Week", y = "Average Minutes") +
  ggtitle("Average Activity by Day of the Week") +
  scale_fill_manual(values = c("sedentary_minutes" = "skyblue", 
                               "lightly_active_minutes" = "lightgreen",
                               "fairly_active_minutes" = "orange",
                               "very_active_minutes" = "red"))



# Calculate the average number of steps for each day of the week
avg_steps <- aggregate(total_steps ~ day_of_week, data = daily_activity, FUN = mean)

# Plot average number of steps by day of the week
ggplot(data = avg_steps, aes(x = day_of_week, y = total_steps)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(x = "Day of the Week", y = "Average Number of Steps") +
  ggtitle("Average Number of Steps by Day of the Week")



# Convert activity_hour to POSIXct format
hourly_activity$activity_hour <- as.POSIXct(hourly_activity$activity_hour, format = "%m/%d/%Y %H:%M:%S")

# Extract the hour from the activity_hour column
hourly_activity$hour <- as.POSIXlt(hourly_activity$activity_hour)$hour

# Calculate the average total intensity for each hour of the day
avg_intensity <- aggregate(total_intensity ~ hour, data = hourly_activity, FUN = mean)

# Plot average total intensity by hour of the day
ggplot(data = avg_intensity, aes(x = factor(hour), y = total_intensity)) +
  geom_bar(stat = "identity", fill = "orange", size = 0.5) +
  labs(x = "Hour of the Day", y = "Average Total Intensity") +
  ggtitle("Average Total Intensity by Hour of the Day") +
  scale_x_discrete(labels = function(x) sprintf("%02d:00", as.numeric(x))) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))



# Define threshold for good sleep (e.g., 6 hours)
threshold <- 360  

# Categorize sleep quality based on total sleep duration
combined_data$sleep_quality <- ifelse(combined_data$total_minutes_asleep >= threshold, "Good sleepers", "Poor sleepers")

# Subset data to include only relevant columns
subset_data <- combined_data[, c("sleep_quality", "sedentary_minutes")]

# Remove rows with NA values in sleep_quality column
subset_data <- subset_data[!is.na(subset_data$sleep_quality), ]

# Plot comparison of sedentary minutes by sleep quality
ggplot(data = subset_data, aes(x = sleep_quality, y = sedentary_minutes, fill = sleep_quality)) +
  geom_boxplot(outlier.colour="red") +
  labs(x = "Sleep Quality", y = "Sedentary Minutes") +
  ggtitle("Comparison of Sedentary Minutes by Sleep Quality")




