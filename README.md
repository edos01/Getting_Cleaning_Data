# Getting_Cleaning_Data
This is a project where we get and clean data(Getting and Cleaning Data). The R script, run_analysis.R, does the following:

First and for most, it sets up the working directory to the data folder created in the UCI_HAR_Dataset folder on the local machine.
Downloads and unzips the dataset to the working directory.
Loads needed packages.
Reads the SUBJECT, ACTIVITY, and FEATURES files and creates data tables.
Concatenates the data tables by rows.
sets names to variables.
Merges columns to get the data frame dataTable for all data.
Subsets Name of Features by measurements on the mean and standard deviation.
Subsets the data frame Data by seleted names of Features.
Uses descriptive activity names to name the activities in the data set.
Appropriately labels the data set with descriptive variable names.
Creates a second,independent tidy data set and ouput it.
