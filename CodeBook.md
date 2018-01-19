---
title: "CodeBook for Getting and Cleaning data course project"
author: "bmareddy"
date: "January 18, 2018"
output: html_document
---

## Introduction

The markdown file explains the output of the "Getting and Cleaning Data" course project and lists down the variables in each output data set. 

## Input(raw) Data
The input data set is "Smartphone-Based Recognition of Human Activities and Postural Transitions Data Set" located at http://archive.ics.uci.edu/ml/datasets/Smartphone-Based+Recognition+of+Human+Activities+and+Postural+Transitions. This is an activity recognition data set built from the recordings of 30 subjects performing 6 basic activities while carrying Galaxy S smartphones.

## Output Data
The accompanying script run_analysis.R generates two output data sets.

1. Data set containing 10299 observations of 81 variables with time and frequency domany of mean() and std() measurements
Full summary of this data set can be obtained by running the following code
```{dt}
summary(dt)
```
2. Data set containing 40 observations of the mean of all the measurement variables split by subject and activity. Full summary of this data set can be obtained by running the following code
```{mean.dt}
summary(mean.dt)
````

## Variables
Both the output data sets contain 81 variables.

1. SUBJECT - This is identifier of the participating subject. Data type is integer. Range 1-30
2. ACTIVITY - A enumerated list of 6 activities performed by subjects. Data type is character
  .1 WALKING
  .2 WALKING_UPSTAIRS
  .3 WALKING_DOWNSTAIRS
  .4 SITTING
  .5 STANDING
  .6 LAYING

3. The remaining 79 variables are mean() and std() measurements whose details are stored in the character vector. Data type is numeric
```features.subset```

In the ```mean.dt``` data set, these 79 variables are mean of the original variables representing mean for each subject and activity combination
