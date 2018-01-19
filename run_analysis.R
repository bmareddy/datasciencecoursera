#########################################################################################################################################
# This script is the solution for Course Project in "Getting and Cleaning Data" course offered through JHU. Instructor: Jeff Leek       #
# It contains 6 sections as described below:                                                                                            #
# 0. Download the required data files and code book (if applicable)                                                                     #
# 1. Merges the training and the test sets to create one data set.                                                                      #
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.                                            #
# 3. Uses descriptive activity names to name the activities in the data set                                                             #
# 4. Appropriately labels the data set with descriptive variable names.                                                                 #
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of                                       # 
#    each variable for each activity and each subject.                                                                                  #
#########################################################################################################################################

# ************************************************************************* #
# *** 0. Download the required data files and code book (if applicable) *** #
# ************************************************************************* #
wd <- getwd()
file <- "./data/GalaxySAccelerometerUCI.zip"
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,file,mode = "wb")

##-- recon; check what files exist in the zip file, preview files to get a sense what is in those files --
fileList <- as.data.frame(unzip(file,list = TRUE))
fileList
file.show(unzip(file, files = "UCI HAR Dataset/README.txt"))
file.show(unzip(file, files = "UCI HAR Dataset/features.txt"))
file.show(unzip(file, files = "UCI HAR Dataset/activity_labels.txt"))
head(read.table(unzip(file,files = "UCI HAR Dataset/test/X_test.txt")))
dim(read.table(unzip(file,files = "UCI HAR Dataset/test/y_test.txt")))
head(read.table(unzip(file,files = "UCI HAR Dataset/train/y_train.txt")))
dim(read.table(unzip(file,files = "UCI HAR Dataset/test/subject_test.txt")))

# ************************************************************************ #
# *** 1. Merges the training and the test sets to create one data set. *** #
# *** 2. Extracts only the measurements on the mean and standard deviation #
#        for each measurement.                                             #
# *** 3. Uses descriptive activity names to name the activities in the *** #
#        data set                                                          #
# ************************************************************************ #
library(data.table)
library(stringr)

#-- get the feautre names into a character vector
features <- readLines(unzip(file, files = "UCI HAR Dataset/features.txt"))
features.subset.indices <- grep("mean|std",features) # get indices of variables of only mean() and std() measurements
features.subset <- sapply(features[features.subset.indices], function(x) unlist(str_split(x," "))[2]) # get variable names of the indices from line above

#-- get acivity_labels corresponding to activity codes
activity.labels <- readLines(unzip(file, files = "UCI HAR Dataset/activity_labels.txt"))
activity.labels.df <- as.data.frame(t(as.data.frame(sapply(activity.labels,str_split,pattern = " "))))
rownames(activity.labels.df) <- NULL
activity.labels.df$V1 <- as.integer(activity.labels.df$V1)

#-- read test files in to data tables
X_test.dt = fread(unzip(file,files = "UCI HAR Dataset/test/X_test.txt"))
y_test.dt = fread(unzip(file,files = "UCI HAR Dataset/test/y_test.txt"))
subject_test.dt = fread(unzip(file,files = "UCI HAR Dataset/test/subject_test.txt"),col.names = c("subject"))

#-- clean the test files data and assign variable names
X_test.dt.clean = X_test.dt[,features.subset.indices,with = FALSE] # Subset X_test data using features subset generated above
colnames(X_test.dt.clean) = features.subset # Assign meaningful variable names
y_test.dt.clean = merge(y_test.dt,activity.labels.df,by.x = "V1",by.y = "V1",all = FALSE)[,c("V2")] # Change activity codes into activity names
colnames(y_test.dt.clean) = c("activity") # Assign meaningful variable names

#-- combine all test files data
test.dt = cbind(subject_test.dt,y_test.dt.clean,X_test.dt.clean)

#-- read train files in to data tables
X_train.dt = fread(unzip(file,files = "UCI HAR Dataset/train/X_train.txt"))
y_train.dt = fread(unzip(file,files = "UCI HAR Dataset/train/y_train.txt"))
subject_train.dt = fread(unzip(file,files = "UCI HAR Dataset/train/subject_train.txt"),col.names = c("subject"))

#-- clean the train files data and assign variable names
X_train.dt.clean = X_train.dt[,features.subset.indices,with = FALSE] # Subset X_train data using features subset generated above
colnames(X_train.dt.clean) = features.subset # Assign meaningful variable names
y_train.dt.clean = merge(y_train.dt,activity.labels.df,by.x = "V1",by.y = "V1",all = FALSE)[,c("V2")] # Change activity codes into activity names
colnames(y_train.dt.clean) = c("activity") # Assign meaningful variable names

#-- combine all train files data
train.dt = cbind(subject_train.dt,y_train.dt.clean,X_train.dt.clean)

#-- Merge test and train data sets
dt = as.data.frame(rbind(test.dt,train.dt))

#-- clean up unused large data sets
remove("X_test.dt","X_test.dt.clean","test.dt")
remove("X_train.dt","X_train.dt.clean","train.dt")

# ************************************************************************* #
# *** 5. From the data set in step 4, creates a second, independent tidy ** #
#        data set with the average of each variable for each activity       #
#        and each subject.                                                  #
# ************************************************************************* #
library(plyr)
library(dplyr)
mean.dt = ddply(dt, ~subject+activity,function(x) colMeans(x[,3:ncol(x)])) # calculate mean for all variables by subject and activity

write.table(mean.dt,file = "./data/Ch3ProjectOuput.txt", row.names = FALSE)