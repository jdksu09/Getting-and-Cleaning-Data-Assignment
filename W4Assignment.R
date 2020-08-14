library(dplyr)
#Downloand zip folder to temporary file for unzipping
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", temp)

#Unzip and read in activity and feature files
activities <- read.table(unz(temp, "UCI HAR Dataset/activity_labels.txt"))
features <- read.table(unz(temp, "UCI HAR Dataset/features.txt"))

#Unzip and read in test data files
test_subjects <- read.table(unz(temp, "UCI HAR Dataset/test/subject_test.txt"))
test_data <- read.table(unz(temp, "UCI HAR Dataset/test/X_test.txt"))
test_labels <- read.table(unz(temp, "UCI HAR Dataset/test/y_test.txt"))

#Unzip and read in train data files and unlink the temp file
train_subjects <- read.table(unz(temp, "UCI HAR Dataset/train/subject_train.txt"))
train_data <- read.table(unz(temp, "UCI HAR Dataset/train/X_train.txt"))
train_labels <- read.table(unz(temp, "UCI HAR Dataset/train/y_train.txt"))
unlink(temp)

#Renaming columns
featurelist <- features[,2]
test_data <- setNames(test_data, featurelist)
train_data <- setNames(train_data, featurelist)
test_subjects <- rename(test_subjects, "Subject" = "V1")
train_subjects <- rename(train_subjects, "Subject" = "V1")
test_labels <- rename(test_labels, "Activity Code" = "V1")
train_labels <- rename(train_labels, "Activity Code" = "V1")
activities <- rename(activities, "Activity Code" = "V1")

#Bind the columns of the three data frames for test and train together to create one dataframe
testdf <- cbind(test_subjects, test_labels, test_data)
traindf <- cbind(train_subjects, train_labels, train_data)

#Merge activity names with the dataframes
testdf <- rename(merge(activities, testdf, by = "Activity Code"),"Activity" = "V2")
traindf <- rename(merge(activities, traindf, by = "Activity Code"), "Activity" = "V2")

#Clip test and train together and extract mean and standard deviation measurements
data <- rbind(testdf, traindf)
data <- select(data, Activity:Subject | contains("mean") | contains("std"))
data <- select(data, -contains("meanFreq"))

#Create second tidy set with average of each variable for each subject and activity
grouped_data <- group_by_at(data, vars(Subject, Activity))
grouped_data <- summarize_all(grouped_data, mean)

#Write new table with tidy data set
write.table(grouped_data, file = "HAR Tidy Data.txt", row.names = FALSE)



