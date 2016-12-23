# GCData
Getting and Cleaning Data Assignment, it contain all documents required for the assignment

This tidy data set was created in:
computer: MacBook Pro, OSX EL CAPITAN, version: 10.11.4 (15E65),
Rstudio Version 0.99.903, R version 3.3.1 (2016-06-21)


## script name :  run_analysis.R

## Step 1: Prepare enviroment
Created a directory with name: a_data
 
## Step 2: loaded library
loaded library that using this script : readr and dplyr
Is important to install this libraries before to source this script

## Step 3: Download Data Set
download the data and prepare for handling

## Step 4: handling data  the test data, that is represent the 30% of total data
read the file in this order: X_test.txt, features.txt, Y_test.txt, subject_test.txt
this file contain:  measurement, the variable names, activities and subjects 
take the file with  variable names and assigment that name for each colum to the measure file and
create names to the columns to the files activity and subject. 
Create a unique  file for test with the mesurement, activity and subject

## Step 5: handling data  the Train data, that is represent the 70% of total data
this step did the same that step 4, oly read this file: X_train.txt, Y_train.txt, subject_train.txt
the features.txt file is the same for both group of data

## Step 6: Create a one data set with 100% of the data (test and train

## Step 7: Subsetting the measurements on the mean and standard deviation for each measurement

## Step 8: Put a descriptive activity names to name the activities in the data set
read the activity_labels.txt file to do that.

## Step 9: asigment appropriately labels the data set with descriptive variable names

## Step 10: create a tidy data set with the average of each variable for each activity and each subject

## Step 11: Write tidy data set
Write the file with the namen: dataset.txt and the directory: a_data



