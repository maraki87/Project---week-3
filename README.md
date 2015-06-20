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

# --------------------------------------------------#

EXERCISE 2
# 2.  Extracts only the measurements on the mean and standard deviation for each measurement

To retrieve the information of mean and standard deviation, I have a look at the "features.txt" file, that I import using the command:

FEATURES = read.table("features.txt", header = FALSE, sep = "", dec = ".")
View(FEATURES)

From there, it is possible to detect the number of columns of the dataset ALL that report the information on the mean and the standard deviation. Therefore I create a subset of ALL, just with these measurements.

subset = ALL[ , c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254, 266:271, 345:350, 424:429, 503:504, 516:517, 529:530, 542:543)]
View(subset)

# ---------------------------------------------------#

EXERCISE 3


First of all, I have a look at the file "activity_labels.txt" to check where
