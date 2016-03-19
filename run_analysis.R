#Setting up the working directory to the UCI HAR Dataset folder created on my localhost(PC)
#and download zip
fileroot <- "/Users/grafix2/Documents/Getting_and_Cleaning_Data/UCI_HAR_Dataset/data"
setwd(fileroot)
if(!file.exists("./data")){dir.create("./data")}
fileurlA <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurlA, destfile = "./data/Dataset.zip", method = "curl")

###Unzip Dataset to /data directory
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")

###Load needed packages
library(dplyr)
library(data.table)
library(tidyr)

#Read the SUBJECT, ACTIVITY, and FEATURES FILES and create data tables
filepath <- "/Users/grafix2/Documents/Getting_and_Cleaning_Data/UCI_HAR_Dataset/data"

#Read SUBJECT files
dataSubjectTain <- tbl_df(read.table(file.path(filepath, "train", "subject_train.txt")))
dataSubjectTest <- tbl_df(read.table(file.path(filepath, "test", "subject_test.txt")))

#Read ACTIVITY files
dataActivityTrain <- tbl_df(read.table(file.path(filepath, "train", "y_train.txt")))
dataActivityTest <- tbl_df(read.table(file.path(filepath, "test", "y_test.txt")))

#Read FEATURES files
dataFeaturesTrain <- tbl_df(read.table(file.path(filepath, "train", "x_train.txt")))
dataFeaturesTest <- tbl_df(read.table(file.path(filepath, "test", "x_test.txt")))

------------------------------------------------
##1. Concatenating data tables by rows
maindataSubject <- rbind(dataSubjectTain, dataSubjectTest)
maindataActivity <- rbind(dataActivityTrain, dataActivityTest)
dataFeatures <- rbind(dataFeaturesTrain, dataFeaturesTest)

#Setting valiable names
dataFeaturesNames <- tbl_df(read.table(file.path(filepath, "features.txt"), header = FALSE))
names(maindataSubject) <- c("subject")
names(maindataActivity) <- c("activity")
names(dataFeatures) <- dataFeaturesNames$V2

#column names for activity labels
activityLabels <- tbl_df(read.table(file.path(filepath, "activity_labels.txt")))
setnames(activityLabels, names(activityLabels), c("activity", "activityName"))

#Merge columns
maindata <- cbind(maindataSubject, maindataActivity)
dataTable <- cbind(dataFeatures, maindata)

--------------------------------------------------
##2. Mean and standard deviation measurements to subset Names of Features
subdataFeaturesNames <- dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

#Data frame dataTable subset by selected Feature names
selectedNames <- c(as.character(subdataFeaturesNames), "subject", "activity")
dataTable <- subset(dataTable, select = selectedNames)

---------------------------------------------------
##3. Enters name of activity in dataTable
dataTable <- merge(activityLabels, dataTable, by="activity", all.x = TRUE)
dataTable$activityName <- as.character(dataTable$activityName)

#Create dataTable with variable means arranged by subject and Activity
dataTable$activityName <- as.character(dataTable$activityName)
dataAggr <- aggregate(. ~ subject - activityName, data = dataTable, mean)
dataTable <- tbl_df(arrange(dataAggr, subject, activityName))

---------------------------------------------------
##4
names(dataTable) <- gsub("^t", "time", names(dataTable))
names(dataTable) <- gsub("^f", "frequency", names(dataTable))
names(dataTable) <- gsub("^Acc", "Accelerometer", names(dataTable))
names(dataTable) <- gsub("^Gyro", "Gyroscope", names(dataTable))
names(dataTable) <- gsub("^Meg", "Magnitude", names(dataTable))
names(dataTable) <- gsub("^BodyBody", "Body", names(dataTable))

---------------------------------------------------
##5. Write to text file
write.table(dataTable, "TidyData.txt", row.names = FALSE)