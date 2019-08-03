# Cleaning-data
repository for the Coursera "Getting and Cleaning Data" course project

File run_analysis.R contains script that cleans and analyses data from Sumsung experiment
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data needs to be dowloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
And extracted into directory "data" in the R working directory.

Data consists of two sets of measurements, "train" and "test" 
files x_train.txt and x_test.txt contain measurements,
files y_train.txt and y_test.txt contain codes (1 to 6) of activities that were performed,
files subject_train.txt and subject_test.txt contain codes of subjects (1 to 30) who performed those activities
file features.txt contains names of the measurements
file activity_lables.txt provides names of activities and their numeric codes

The script works as follows:

1. function get_data() reads each file into R into separate data frame in global enviroment
2. function lable_and_combine_data() lables both train and test sets of data with measurements' names
    combines both train and test sets of data with corresponding subject and activity codes
    combines both sets together
    replaces activity codes with activity names
    labled data set is stored in allData data frame
4. extracts only mean ans standart deviation variables
5. function tidy_names() replaces abbreviated variable names with descriptive variable names
6. creates new data frame with averages of variables of tidy data set grouped by activity and subject
7. adds word "average" to the variable names in the new data set
8. returns new data set


