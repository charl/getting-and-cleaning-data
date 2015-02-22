## run_analysis.R - https://github.com/charl/getting-and-cleaning-data
## 
## This script uses the data from "./data/UCI HAR Dataset/" and does the following:
##
## * Merges the training and test sets to create one data set.
## * Extracts only the measurements on the mean and standard deviation for each measurement.
## * Uses descriptive activity names to name the activities in the data set
## * Appropriately labels the data set with descriptive variable names.
## * From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Libraries.
library(dplyr)

## Process the training data.
##
## Read the list of all features from ./data/UCI\ HAR\ Dataset/features.txt into a table.
features <- read.table("./data/UCI\ HAR\ Dataset/features.txt")

## Add column names to the features.
colnames(features) <- c("Index", "FeatureName")

## Read the Training set from ./data/UCI\ HAR\ Dataset/train/X_train.txt into a table.
trainData <- read.table("./data/UCI\ HAR\ Dataset/train/X_train.txt")

## Use the list of all features as column names for the training data.
colnames(trainData) <- features[,"FeatureName"]

## Select out the features that relate to the mean or standard deviation of a measurement.
filterColumns <- features[grep("mean\\(|std\\(", features[,"FeatureName"], perl=TRUE), "FeatureName"]

## Drop all columns that are not the mean or standard deviation of a measurement.
trainData <- trainData[, names(trainData) %in% filterColumns]

## Read in the training lables from ./data/UCI\ HAR\ Dataset/train/y_train.txt into a table.
trainLabels <- read.table("./data/UCI\ HAR\ Dataset/train/y_train.txt")

## Use ./data/UCI\ HAR\ Dataset/activity_labels.txt to add descriptive activity names to the activities in the data set.
activityLabels <- read.table("./data/UCI\ HAR\ Dataset/activity_labels.txt")
activityLabels <- merge(trainLabels, activityLabels, by="V1", sort=FALSE)
trainData <- cbind(Activity=activityLabels[, "V2"], trainData)

## Append a data type column to the training data that will play a role when merging with the test data.
trainData <- cbind(DataType="Training", trainData)

## Read in the subject who's performed the activity for each window sample.
subjects <- read.table("./data/UCI\ HAR\ Dataset/train/subject_train.txt")

## Add column names to the subjects.
colnames(subjects) <- c("Subject")

## Append the subjects to the training data.
trainData <- cbind(Subject=subjects[, "Subject"], trainData)

## Process the test data.
##
## Read the Test set from ./data/UCI\ HAR\ Dataset/test/X_test.txt into a table.
testData <- read.table("./data/UCI\ HAR\ Dataset/test/X_test.txt")

## Use the list of all features as column names for the training data.
colnames(testData) <- features[,"FeatureName"]

## Drop all columns that are not the mean or standard deviation of a measurement.
testData <- testData[, names(testData) %in% filterColumns]

## Read in the training lables from ./data/UCI\ HAR\ Dataset/train/y_train.txt into a table.
testLabels <- read.table("./data/UCI\ HAR\ Dataset/test/y_test.txt")

## Use ./data/UCI\ HAR\ Dataset/activity_labels.txt to add descriptive activity names to the activities in the data set.
activityLabels <- read.table("./data/UCI\ HAR\ Dataset/activity_labels.txt")
activityLabels <- merge(testLabels, activityLabels, by="V1", sort=FALSE)
testData <- cbind(Activity=activityLabels[, "V2"], testData)

## Append a data type column to the training data that will play a role when merging with the test data.
testData <- cbind(DataType="Test", testData)

## Read in the subject who's performed the activity for each window sample.
subjects <- read.table("./data/UCI\ HAR\ Dataset/test/subject_test.txt")

## Add column names to the subjects.
colnames(subjects) <- c("Subject")

## Append the subjects to the training data.
testData <- cbind(Subject=subjects[, "Subject"], testData)

## Merge both data sets.
##
## Merge the training and test data sets into totalData that is a long form tiny data set.
totalData <- rbind(trainData, testData)

## Summarise totalData.
##
## Create a second tidy data set with the average of each variable for each activity and each subject from totalData.
summary <- totalData %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))

## Transform all DataType entries to a more descriptive string label.
summary$DataType <- ifelse(summary$DataType == 1, "Training", "Test")

## Write the summarised data to ./data/step5-summary.table.
write.table(summary, "./data/step5-summary.table.txt", row.name=FALSE)
