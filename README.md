# Getting_Cleaning_Data
This is a project where we get and clean data(Getting and Cleaning Data). The R script, run_analysis.R, does the following:

1. First and for most, it sets up the working directory to the data folder created in the UCI_HAR_Dataset folder on the local machine.
2. Downloads and unzips the dataset to the working directory.
3. Loads needed packages.
4. Reads the SUBJECT, ACTIVITY, and FEATURES files and creates data tables.
5. Concatenates the data tables by rows.
6. sets names to variables.
7. Merges columns to get the data frame dataTable for all data.
8. Subsets Name of Features by measurements on the mean and standard deviation.
9. Subsets the data frame Data by seleted names of Features.
10. Uses descriptive activity names to name the activities in the data set.
11. Appropriately labels the data set with descriptive variable names.
12. Creates a second,independent tidy data set and ouput it.

The end result is shown in the file tidy.txt.
