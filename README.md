# Getting and Cleaning Data
This is the course project for Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

1. Check if the dataset is available in working directory. If not, download and unzip the dataset
2. Load the activity and features
3. Selecting the wanted features(mean and standard deviation) from the loaded activities and features list
4. Load the activity and subject data for each dataset and filter the wanted features
5. Merges the two datasets
6. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
7. The end result is shown in the file tidy.txt.
