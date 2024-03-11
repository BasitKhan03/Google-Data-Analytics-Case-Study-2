# Google-Data-Analytics-Case-Study-2
Google Data Analytics capstone case study for Bellabeat data analysis

**Case study:** *How Can a Wellness Technology Company Play It Smart?*

**Course:** [Google Data Analytics Capstone: Complete a Case Study](https://www.coursera.org/learn/google-data-analytics-capstone/)

## Scenario
You are a junior data analyst working on the marketing analyst team at Bellabeat, a high-tech manufacturer of health-focused products for women. Bellabeat is a successful small company, but they have the potential to become a larger player in the global smart device market. Urška Sršen, cofounder and Chief Creative Officer of Bellabeat, believes that analyzing smart device fitness data could help unlock new growth opportunities for the company. You have been asked to focus on one of Bellabeat’s products and analyze smart device data to gain insight into how consumers are using their smart devices. The insights you discover will then help guide marketing strategy for the company. You will present your analysis to the Bellabeat executive team along with your high-level recommendations for Bellabeat’s marketing strategy.


## Ask
Sršen asks you to analyze smart device usage data in order to gain insight into how consumers use non-Bellabeat smart devices. She then wants you to select one Bellabeat product to apply these insights to in your presentation. These questions will guide your analysis:
1. What are some trends in smart device usage?
2. How could these trends apply to Bellabeat customers?
3. How could these trends help influence Bellabeat marketing strategy?

### -> Business Task: 
Analyze smart device usage data to understand how consumers use non-Bellabeat smart devices. Identify trends, patterns, and preferences among users, including popular features and frequency of use. Select one Bellabeat product to apply these insights and inform marketing strategy for potential growth opportunities in the smart device market


## Prepare
Sršen encourages you to use public data that explores smart device users’ daily habits. Now, prepare your data for analysis using the Case Study Roadmap as a guide.

### -> Data Sources: 
For this analysis, we primarily utilized the FitBit Fitness Tracker Data available on Kaggle, provided by Mobius under the CC0: Public Domain Creative Common License. This dataset encompasses smart health data from personal fitness trackers used by thirty Fitbit users. 

#### • Data Location:- 
The FitBit Fitness Tracker Data used for this analysis was sourced from the provided link [FitBit Fitness Tracker Data](https://www.kaggle.com/datasets/arashnic/fitbit) on Kaggle, and it is stored in a secure and accessible location for analysis.

#### • Data Organization:- 
The dataset consists of 18 CSV files, each representing the smart health data from personal fitness trackers used by thirty Fitbit users. The data, collected via a survey of personal tracker data, includes minute-level output for physical activity, heart rate, and sleep monitoring, spanning from March 12, 2016, to May 12, 2016. Key columns include information on daily activity, steps, heart rate, and other relevant metrics.

#### • Licensing, Privacy, Security, and Accessibility:- 
The usage of the data adheres to the provided license terms, ensuring compliance with legal and ethical considerations. It was provided by [Möbius](https://www.kaggle.com/arashnic) on Kaggle under the CC0: Public Domain Creative Common License. Privacy has been maintained, and personally identifiable information has been excluded to comply with data-privacy regulations.

#### • Data Integrity Verification:- 
The integrity of the data has been verified by checking for missing values, inconsistencies, and outliers. Any discrepancies found have been addressed through appropriate cleaning and preprocessing steps.

#### • Data Issues:- 
While the FitBit Fitness Tracker Data provides valuable insights into users' habits, limitations exist due to the small sample size, dataset age, and absence of demographic information. These factors may impact the relevance and applicability of the insights generated for informing marketing strategy recommendations.

### -> ROCCC analysis:
1) **Reliability:** The reliability of the dataset is considered LOW due to its collection from a limited sample of 30 individuals, with unknown gender demographics.
   
2) **Originality:** The originality of the dataset is rated as LOW as it was sourced from third-party data collection using Amazon Mechanical Turk, limiting its uniqueness.
   
3) **Comprehensive:** The dataset's comprehensiveness is assessed as MEDIUM, given its inclusion of multiple fields capturing daily activity intensity, calories expended, daily step counts, sleep duration, and weight records.
   
4) **Current:** While the data is 5 years old, it is argued that daily habits may not drastically change over this timeframe, resulting in a MEDIUM rating for currentness.
   
5) **Cited:** The dataset benefits from a HIGH rating in terms of citation, as the data collector and source are well-documented, enhancing its credibility.


## Process
Then, process your data for analysis using the Case Study Roadmap as a guide.

### -> Tools:
I have utilized `RStudio` to clean the data, organize the various datasets, and create visualizations.

### -> Change Log:
|#|Title|Description|Status|
| --- | :---: | --- | :---: |
| 1) | Select Datasets | 6 out of 18 CSV files are selected for the analysis, namely ‘dailyActivity_merged’, ‘sleepDay_merged’, ‘weightLogInfo_merged’, ‘hourlyIntensities_merged’, ‘hourlyCalories_merged’ & ‘hourlySteps_merged’ | Completed |
| 2) | Merge Datasets | Merged ‘hourly_intensity’, ‘hourly_calories’, and ‘hourly_steps’ into one single dataframe ‘hourly_activity’ | Completed |
| 3) | Clean Column Names | Cleaned column names for each dataframe | Completed |
| 4) | Remove Null Values | Rows containing Null values are removed for the analysis | Completed |
| 5) | Remove Duplicate Rows | Duplicate rows are removed for the analysis | Completed |
| 6) | Exclude Dataset | The sample size of ‘weight’ dataframe is too small for further analysis. Therefore, it will be excluded from further analysis | Completed |
| 7) | Convert Format | Converted date and time format in ‘daily_activity’, ‘daily_sleep’, and ‘hourly_activity’ dataframes | Completed |
| 8) | Add Column | Added a column for the day of week in ‘daily_activity’ | Completed |
| 9) | Add Column | Added a column for finding total active hours from various activity minutes columns in ‘daily_activity’ | Completed |
| 10) | Transform Data Time Units | Added two columns for calculating total hours asleep and total hours in bed from total minutes in ‘daily_sleep’ | Completed |
| 11) | Merge Datasets | Merged ‘daily_activity’ and ‘daily_sleep’ dataframes by 'id' column for exploring different relationships between activity and sleep | Completed |

### -> Data Observation:
#### 1) Number of columns and observations in each dataframe:
<img src="https://github.com/BasitKhan03/Google-Data-Analytics-Case-Study-2/assets/101899595/72b5907e-e824-4a9b-8c36-3fd99061876e" width="50%">

#### 2) Number of unique participants in each dataframe:
<img src="https://github.com/BasitKhan03/Google-Data-Analytics-Case-Study-2/assets/101899595/293c7c7f-fb69-4d7e-bb75-2eeea2d11954" width="32%">

#### 3) Number of duplicate rows in each dataframe:
<img src="https://github.com/BasitKhan03/Google-Data-Analytics-Case-Study-2/assets/101899595/5a52dee5-a7ad-4eb2-8aa6-002dabea7339" width="32%">

#### 4) Summary statistics for ‘daily activity’ dataframe:
<img src="https://github.com/BasitKhan03/Google-Data-Analytics-Case-Study-2/assets/101899595/12e30dc3-c4fb-4ffc-bfa1-96d60312a9cb" width="41%">

#### 5) Summary statistics for ‘daily sleep’ dataframe:
<img src="https://github.com/BasitKhan03/Google-Data-Analytics-Case-Study-2/assets/101899595/898def36-a789-4c33-8eeb-c527131531cf" width="47%">

#### 6) Summary statistics for ‘hourly activity’ dataframe:
<img src="https://github.com/BasitKhan03/Google-Data-Analytics-Case-Study-2/assets/101899595/d2e422d0-f3c0-45af-8612-6970ae23da91" width="55%">


## Analyze & Share
Now that your data is stored appropriately and has been prepared for analysis, start putting it to work. Once you have completed your analysis, create your data visualizations. The visualizations should clearly communicate your high-level insights and recommendations.

### -> Analysis:
To address our business objective, it would be helpful to visualize key observations regarding trends in smart device utilization. We will first analyze the relationship between steps taken in a day and sedentary minutes.

![image](https://github.com/BasitKhan03/Google-Data-Analytics-Case-Study-2/assets/101899595/18c93db3-ef9d-481c-8b03-ecb4850d0705) 

It has a negative correlation coefficient of -0.327 which indicates a moderately strong inverse relationship between the number of steps taken in a day and sedentary minutes. This suggests that as the number of steps increases, the amount of time spent in sedentary activities decreases. In practical terms, individuals who engage in more physical activity tend to spend less time in sedentary behaviors, which aligns with recommendations for maintaining an active lifestyle.

The next interesting data to observe is the correlation between the number of hours slept and the number of hours spent in bed.

![image](https://github.com/BasitKhan03/Google-Data-Analytics-Case-Study-2/assets/101899595/b1a91ee4-860c-4ba5-8933-5941ac647e91)

It has a strong positive correlation coefficient of 0.930 which indicates a close relationship between the number of hours slept and the number of hours spent in bed. This suggests that individuals who spend more time in bed also tend to sleep for longer durations. This observation emphasizes the significance of maintaining consistent and sufficient sleep schedules to promote optimal health outcomes.

Now, we will analyze the relationship between the total number of steps taken in a day and calories burned.

![image](https://github.com/BasitKhan03/Google-Data-Analytics-Case-Study-2/assets/101899595/ab64d323-1908-4710-99ce-3fbf622d71d9)

It has a correlation coefficient of 0.592 that indicates a moderate positive relationship between these two variables. This suggests that individuals who take more steps tend to burn more calories. This finding underscores the importance of physical activity in energy expenditure and weight management.

Next, we will delve into the relationship between total active hours and calories burned.

![image](https://github.com/BasitKhan03/Google-Data-Analytics-Case-Study-2/assets/101899595/56ff2763-2f1c-48a5-9364-d005b3bb3c30)

It has a correlation coefficient of 0.138 which suggests a weak positive relationship between these two variables. Additionally, an interesting observation emerges i.e. individuals who have spent 15-19 active hours in a day tend to burn more calories. This implies that extended periods of activity may contribute to higher calorie expenditure. While the correlation is weak, this specific insight sheds light on the potential impact of prolonged activity on energy expenditure.

Furthermore, we will explore the relationship between total time asleep and calories burned.

![image](https://github.com/BasitKhan03/Google-Data-Analytics-Case-Study-2/assets/101899595/8c9953a0-3b5f-4104-8839-5b650de00ec8)



