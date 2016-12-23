#Script that created a tidy data set for the data generating for Samsung Galaxy S II
# (accelerometer and gyroscope)

#step1
# Prepare enviroment
if (!file.exists("a_data")){
        dir.create("a_data")
}
#step2
library(readr)
library(dplyr)
#step3
#Download Data Set
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./a_data/Dataset.zip",method="curl")
unzip(zipfile="./a_data/Dataset.zip",exdir="./a_data")

#step4
#TEST
#read file measurement for test
xtest <- read_fwf("./a_data/UCI HAR Dataset/test/X_test.txt", fwf_widths(rep(16,561)))
#read file column names for test
cnames <- read.table("./a_data/UCI HAR Dataset/features.txt")
# assigment names to columns
names(xtest) <- cnames$V2
#read file activities for test
ytest <- read.table("./a_data/UCI HAR Dataset/test/Y_test.txt")
# assigment names to column
names(ytest) <- c("activity_id")
#read file subjects for test
subjtest <- read.table("./a_data/UCI HAR Dataset/test/subject_test.txt")
# assigment name to column
names(subjtest)<- c("subjects")
# combine three files
tmptest <- cbind(subjtest, ytest, xtest)
#View(tmptest)
#step5
#TRAIN
#read file measurement for train
xtrain <- read_fwf("./a_data/UCI HAR Dataset/train/X_train.txt", fwf_widths(rep(16,561)))
#The file of variable names for train is the same to the test
# assigment names to columns
names(xtrain) <- cnames$V2
#read file activities for train
ytrain <- read.table("./a_data/UCI HAR Dataset/train/Y_train.txt")
# assigment names to column
names(ytrain) <- c("activity_id")
#read file subjects for train
subjtrain <- read.table("./a_data/UCI HAR Dataset/train/subject_train.txt")
# assigment name to column
names(subjtrain)<- c("subjects")
# combine three files
tmptrain <- cbind(subjtrain, ytrain, xtrain)
View(tmptrain)
#step6
#Merges the training and the test sets
humact <- rbind(tmptrain, tmptest)
View(humact)
#step7
# Subsetting the measurements on the mean and standard deviation for each measurement
humact1 <- grepl("[Mm][Ee][Aa][Nn]|[Ss][Tt][Dd]|subjects|activity_id", names(humact))
dataset <- humact[, humact1]
View(dataset)
#step8
#Uses descriptive activity names to name the activities in the data set
#Read de file activity_labels.txt 
actlabel <- read.table("./a_data/UCI HAR Dataset/activity_labels.txt")
# assigment names to column
names(actlabel) <- c("activity_id", "activity")
mdataset = merge(actlabel,dataset,by.x="activity_id",by.y="activity_id",all=TRUE)
mdataset <- mdataset[,-grep("^activity_id$", names(mdataset))]
View(mdataset)
#step9
#Appropriately labels the data set with descriptive variable names
oldnames <- names(mdataset)
oldnames <- sub("mean\\(\\)","mean", oldnames)
oldnames <- sub("std\\(\\)","standarddeviation", oldnames)
oldnames <- sub("meanFreq\\(\\)","meanfrequency", oldnames)
oldnames <- sub("^t","time", oldnames)
oldnames <- sub("^f","frequency", oldnames)
oldnames <- sub("\\(t","time", oldnames)
oldnames <- gsub("\\(|\\)|\\-|\\,","", oldnames)
oldnames <- sub("Acc","acceleration", oldnames)
oldnames <- sub("Mag","magnitude", oldnames)
names(mdataset) <- tolower(oldnames)
View(mdataset)

#step10
#data set with the average of each variable for each activity and each subject
meangroupdataset <- group_by(mdataset, activity, subjects) %>% summarise_each(funs(mean))
#step11
# use write.table() using row.name=FALSE
write.table(meangroupdataset, file = "./a_data/dataset.txt", row.names = FALSE)
