---
title: "ReadMe for Getting and Cleaning Data Course Project"
author: "bmareddy"
date: "January 19, 2018"
output: html_document
---

## Cleaning Smartphone based Activity data

This document explains how the script run_analysis.R works. The scritp contains 3 sections

### Downloading the raw data
First section deals with exploratory phase of data collection and reconnaissance. The script downloads the file and has the code for the user to execute to get high level summary of the files that are in the downloaded zip file. One can use these simple commands to identify the files of interest and learn more about their formats.

### Data Cleaning
This section imports the data from files into R objects for further manupulation. It performs below actions

1. From the features file, extract the indices and names of measurements that are mean and standar deviation. This is done using ```grep("mean|std",x)``` command
2. Convert the activity labels list in to a data frame of 6 observations and 2 variables to facilitate merge with activity data
3. From the test folder, each of X, y and subject data is imported. X data is subsetted to include only measurements of interest as stated in step 1. y data is merged with activity data from step 2 and the activity codes are converted to activity names. 
4. The clean versions of X, y and subject test data are combined in to one data frame using ```cbind()``` function. 
5. Steps 3 and 4 are repeated for train data set

By the end of this section, we have clean test and train data sets. These are two are merged using ```rbind()``` function to form a clean data output data set that can be used in the analysis.

### Transformation
The section creates a tidy data set of means of all the measurement variables from the data set created in the section above. The script uses ```ddply``` function from plyr package. The code splits the data on subject and activity variables and applied colMeans function on all the other columns.
