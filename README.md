# Getting and Cleaning Data Assignment
The script for getting the raw data and creating the tidy set is in the W4Assignmnet.R file.  This script first pulls files from the original project data at the link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

There are folders for training data and test data, with the explantion of the sets in the ReadMe file contained in the folder.  This script extracts the variable data for each set,
then the subject for each measurement, contained in a separate file, the activity for each measurement, also contained in another file.  These are then combined to form one data set for 
each training and test data sets.  Then only the mean and std measurements are recorded.  Also the codes for activities are replaced with their names using the activity_labels file.
Both sets are combined to form one data frame.

Then using the mean of each variable and each activity and subject it generates a tidy data text file according to the principles of wide tidy data.
