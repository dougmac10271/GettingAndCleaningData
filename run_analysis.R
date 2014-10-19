## set the working directory
setwd("C:/R/Class3") 

## load the train data
train = read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE) 

## load the train activity data into an appended column
train[,(ncol(train) + 1)] = read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE) 

## load the train subject data into another appended column
train[,(ncol(train) + 1)] = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE) 

## load the test data
test = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE) 

## load the test activity data into an appended column
test[,(ncol(test) + 1)] = read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE) 

## load the test subject data into another appended column
test[,(ncol(test) + 1)] = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE) 

## load the activity labels
activityLabels = read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE) 

## load the features
features = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE) 

## replace key strings 
features[,2] = gsub('-mean', 'Mean', features[,2]) 
features[,2] = gsub('-std', 'Std', features[,2]) 

## insert placeholder @ 
features[,2] = gsub('angle(', 'angle@', features[,2], fixed = TRUE) 

## eliminate dashes and parentheses 
features[,2] = gsub('[-()]', '', features[,2])  

## replace @ with dash so that angle column names read angle-arg1,arg2
features[,2] = gsub('@', '-', features[,2], fixed = TRUE) 

## merge the train and test datasets
comboDataset = rbind(train, test)  

## create a vector of column numbers to process, where the column name contains Mean or Std
colsToProcess <- grep("Mean|Std", features[,2]) 

## the numbers in colsToProcess define both the row numbers to select in the features table
## and the column numbers to select in comboDataset (not including the Activity and Subject columns)
features <- features[colsToProcess,] 

## add the last two column numbers to the vector of column numbers to process 
colsToProcess <- c(colsToProcess, (ncol(comboDataset) - 1), ncol(comboDataset)) 

## remove the unwanted columns from comboDataset 
comboDataset <- comboDataset[,colsToProcess] 

## assign all of the feature names as the column names in comboDataset 
colnames(comboDataset) <- c(features$V2,"Activity", "Subject")

## look up and assign the activity labels to the Activity column
for (i in 1:nrow(comboDataset)) {
  for (j in 1:nrow(activityLabels)) {
    if (comboDataset$Activity[i] == activityLabels$V1[j] ) {
      comboDataset$Activity[i] = as.character(activityLabels$V2[j])
      break
    }
  }
}

## define the columns to be used as factors for aggregation
comboDataset$Activity <- as.factor(comboDataset$Activity) 
comboDataset$Subject <- as.factor(comboDataset$Subject) 

## determine the aggregated mean for the columns by Subject within Activity 
tidyDataset = aggregate(comboDataset, by=list(comboDataset$Activity, comboDataset$Subject), FUN="mean") 

# remove the Activity and SUbject columns  
tidyDataset[,ncol(tidyDataset)] = NULL 
tidyDataset[,ncol(tidyDataset)] = NULL 

## write the tidyDataset to a file
