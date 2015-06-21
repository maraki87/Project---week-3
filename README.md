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
# 3. Uses descriptive activity names to name the activities in the data set

First of all, I import in R the two files containing the labels of the row names (i.e. “y_test.txt” and in “y_train.txt”) and I merge the two datasets for the train and test observations, to reconstruct the whole dataset. Opening the new dataset, I see that the activities are coded with numbers from 1 to 6. Therefore I look at the file "activity_labels.txt" to check the meaning of these different labels and I transform the names accordingly; I also assign the label “Activity” to this variable (that was initially called V1).  Finally I merge this with the dataset containing all the observations if the experiment (i.e. both the test and the train datasets).
The code to perform these steps is the following:
ROWnamesTRAIN = read.table("train/y_train.txt", header = FALSE, sep = ",")
View(ROWnamesTRAIN)

ROWnamesTEST = read.table("test/y_test.txt", header = FALSE, sep = "", dec = ".")
View(ROWnamesTEST)

ROWnamesALL = rbind(ROWnamesTRAIN, ROWnamesTEST)
View(ROWnamesALL)

unique(ROWnamesALL$V1)
class(ROWnamesALL$V1)

as.character(ROWnamesALL$V1)
ROWnamesALL$V1[ROWnamesALL$V1 == "1"] = "WALKING"
ROWnamesALL$V1[ROWnamesALL$V1 == "2"] = "WALKING_UPSTAIRS"
ROWnamesALL$V1[ROWnamesALL$V1 == "3"] = "WALKING_DOWNSTAIRS"
ROWnamesALL$V1[ROWnamesALL$V1 == "4"] = "SITTING"
ROWnamesALL$V1[ROWnamesALL$V1 == "5"] = "STANDING"
ROWnamesALL$V1[ROWnamesALL$V1 == "6"] = "LAYING"

names(ROWnamesALL) = "Activity"
names(ROWnamesALL)
DATASET = cbind(ROWnamesALL, subset, deparse.level = 1)
View(DATASET)

# ---------------------------------------------------#

