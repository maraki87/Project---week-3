# Project---week-3
Folder for the project of w3 "Getting &amp; Cleaning Data"

This file explains how the script works and the codebook describing the variables used for this assignment.

EXERCISE 1
# 1.  Merges the training and the test sets to create one data set

First of all it is necessary to import in R the different datasets: I called the first one "TRAIN" (containing 70% of the observations that were recorded during the experiment) and the second one "TEST" (containing 30% of the observations that were recorded during the experiment). The code to import the two datasets and to merge them is:


TRAIN = read.table("train/X_train.txt", header = FALSE, sep = "", dec = ".")
View(TRAIN)

TEST = read.table("test/X_test.txt", header = FALSE, sep = "", dec = ".")
View(TEST)

ALL = rbind(TRAIN, TEST)

For this exercise it was sufficient to use the "rbind" function (instead of the usual "merge" function) since the two datasets have exactly the same variables (i.e. 561-feature vector with time and frequency domain variables). This could be controlled by using the commands:

names(TRAIN)
names(TEST)
intersect(names(TRAIN), names(TEST))

