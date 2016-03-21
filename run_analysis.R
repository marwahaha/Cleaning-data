library(dplyr)

## This script uses data, obtained by downloading and extracting data from 
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## Directory "data" with unpacked archive needs to be in the working directory.
## Reads data (x_test and x_train), 
## Matches them with subjects (subject_test and subject_train) and activities
## (y_test and y_train).
## Joines test and training sets of data
## Labels data frame with measuremnents' names (features) 
## Extracts only the measurements on the mean and standard deviation for each measurement.
## Replaces codes with descriptive activity names to name the activities in the data set
## Changes labels of the data set to descriptive variable names.
## Retutns new data set with the average of each variable for each activity and each subject.

run_analysis <- function(){
        get_data() 
        lable_and_combine_data()
        ## extract only "mean()" and standart deviation variables
        allData <<- allData[c(1,2,grep("mean\\(",names(allData)),grep("std",names(allData)) )]
        tidy_data_names()
        newData <- allData %>% 
                group_by(activity,subject) %>%
                summarise_each(funs(mean))
        for (i in seq_along(names(newData))) {
                if (i> 2) {
                        names(newData)[i] <- paste ("average ",names(newData)[i], sep = "")
                }
        }
        newData
        
}

## get_data reads data into r 
get_data <- function(){
      
        dataPath <- "./data/UCI HAR Dataset"
        activityLables <<- read.table(paste(dataPath, "/activity_labels.txt", sep = ""))
        features <<- read.table(paste(dataPath, "/features.txt", sep = ""))
        testPath <- paste(dataPath, "/test", sep = "")
        testData <<- read.table(paste(testPath, "/x_test.txt", sep = ""))
        testActivities <<- read.table(paste(testPath, "/y_test.txt", sep = ""))
        testSubjects <<- read.table(paste(testPath, "/subject_test.txt", sep = ""))
        trainPath <- paste(dataPath, "/train", sep = "")
        trainData <<- read.table(paste(trainPath, "/x_train.txt", sep = ""))
        trainActivities <<- read.table(paste(trainPath, "/y_train.txt", sep = ""))
        trainSubjects <<- read.table(paste(trainPath, "/subject_train.txt", sep = ""))
        
}

## lable__and_combine_data lables test and training data with measurements names from features, 
## adds subject codes and activity names, merges both sets in allData
lable_and_combine_data <- function(){
        names(testData) <<- features[,2]
        names(trainData) <<- features[,2]
        names(testSubjects) <<- "subject"
        names(trainSubjects) <<- "subject"
        names(testActivities) <<- "activity"
        names(trainActivities) <<- "activity"
        testData <<- cbind.data.frame(testSubjects,testActivities,testData)
        trainData <<- cbind.data.frame(trainSubjects,trainActivities,trainData)
        allData <<- rbind(testData,trainData)
        allData$activity <<- sapply(allData$activity, function(x) {x <- activityLables[x,2]})
        
}

## Tidy the names of the data frame: split into words, transform into lower case and
## replace abreviations
tidy_data_names <- function(){
        names(allData) <<- names(allData) %>% 
                sapply( function(x) {gsub("([[:upper:]])", " \\1", x)}) %>%
                tolower() %>%
                sapply( function(x) {sub("^t ",  "time ", x)}) %>%
                sapply( function(x) {sub("^f ",  "frequency ", x)}) %>% 
                sapply( function(x) {sub("acc",  "acceleration", x)}) %>% 
                sapply( function(x) {sub("gyro",  "gyroscope", x)}) %>% 
                sapply( function(x) {sub("mag",  "magnitude", x)}) %>%
                sapply( function(x) {sub("body body",  "body", x)}) %>%
                sapply( function(x) {sub("(.*)(-mean\\(\\))(-){0,1}",  "mean of \\1", x)}) %>%
                sapply( function(x) {sub("(.*)(-std\\(\\))(-){0,1}",  "standart deviation of \\1", x)})
       
        
}