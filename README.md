## GettingAndCleaningData
======================

This repository contains the deliverables for the class assignment.

### Script explanation

* set the working directory
* load the train data
* load the train activity data into an appended column
* load the train subject data into another appended column
* load the test data
* load the test activity data into an appended column
* load the test subject data into another appended column
* load the activity labels
* load the features and replace key strings 
* insert placeholder @ 
* eliminate dashes and parentheses 
* replace @ with dash so that angle column names read "angle-arg1,arg2"
* merge the train and test datasets
* create a vector of column numbers to process, where the column name contains Mean or Std
* select the features based on the previous step (see Note 1)
* add the last two column numbers to the vector of column numbers to process 
* remove the unwanted columns from comboDataset 
* assign all of the feature names as the column names in comboDataset 
* look up and assign the activity labels to the Activity column
* define the columns to be used as factors for aggregation
* determine the aggregated mean for the columns by Subject within Activity 
* remove the Activity and SUbject columns  
* write the tidyDataset to a file

### Code book / variables explanation

* train - a data frame that contains the training data with appended training activity and subject columns.
* test - a data frame that contains the test with appended test activity and subject columns.
* activityLabels - a data frame that contains the data from activity_labels.txt.
* features - a data frame that contains the data from features.txt.
* comboDataset - a data frame that contains the combination of the train and test data frames.
* colsToProcess - a vector of columns to process, with all but the last two columns determined by filtering features with "mean" and "std" in the names and the last two columns being the activity and subject columns.
* tidyDataset - a data frame created by determining the mean of the aggregated Activity and Subject columns.

### Notes

1. The numbers in colsToProcess define both the row numbers to select in the features table and the column numbers to select in comboDataset (not including the Activity and Subject columns).

### External Sources

I could not discern that the subject and activity files were csv files until I consulted the following source:
    https://github.com/eriky/coursera-getting-and-cleaning-data
