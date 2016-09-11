library(reshape2)

filename <- "Dataset.zip"

## Download and unzip the dataset

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename)
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

## Load activity and features
activity_label <- read.table("UCI HAR Dataset/activity_labels.txt")
activity_label[,2] <- as.character(activity_label[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

## Select data on mean and standard deviation
features_wanted <- grep(".*-mean*|.*-std*", features[,2])
features_wanted.names <- features[features_wanted,2]
features_wanted.names = gsub("-mean()","Mean",features_wanted.names)
features_wanted.names = gsub("-std()","Std",features_wanted.names)

## Load Dataset and filter  wanted features
test_X <- read.table("UCI HAR Dataset/test/X_test.txt")[features_wanted]
test_Y <- read.table("UCI HAR Dataset/test/Y_test.txt")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_data <- cbind(test_subject,test_Y,test_X)

train_X <- read.table("UCI HAR Dataset/train/X_train.txt")[features_wanted]
train_Y <- read.table("UCI HAR Dataset/train/Y_train.txt")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
train_data <- cbind(train_subject,train_Y,train_X)

## merger data set and add label
DataSet <- rbind(test_data,train_data)
colnames(DataSet) <- c("Subject","Activities",features_wanted.names)

DataSet$Activities <- factor(DataSet$Activities, levels = activity_label[,1], labels = activity_label[,2])
DataSet$Subject <- as.factor(DataSet$Subject)


## Calculate average of each variable for each activity and each subject
DataSet.melted <- melt(DataSet, id = c("Subject", "Activities"))
DataSet.mean <- dcast(DataSet.melted, Subject + Activities ~ variable, mean)

write.table(DataSet.mean, "tidy.txt", row.names = FALSE, quote = FALSE)

