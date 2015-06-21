# 1.  Merges the training and the test sets to create one data set

TRAIN = read.table("train/X_train.txt", header = FALSE, sep = "", dec = ".")
View(TRAIN)

TEST = read.table("test/X_test.txt", header = FALSE, sep = "", dec = ".")
View(TEST)

names(TRAIN)
names(TEST)
intersect(names(TRAIN), names(TEST))

ALL = rbind(TRAIN, TEST)
View(ALL)

# 2.  Extracts only the measurements on the mean and standard deviation for each measurement

FEATURES = read.table("features.txt", header = FALSE, sep = "", dec = ".")
View(FEATURES)

subset = ALL[ , c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254, 266:271, 345:350, 424:429, 503:504, 516:517, 529:530, 542:543)]
View(subset)

# 3.  Uses descriptive activity names to name the activities in the data set

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

View(ROWnamesALL)

names(ROWnamesALL) = "Activity"
names(ROWnamesALL)

DATASET = cbind(ROWnamesALL, subset, deparse.level = 1)
View(DATASET)

# 4.  Appropriately labels the data set with descriptive variable names

View(DATASET)
names(DATASET)

names(DATASET)[2:67] = c("tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z",
                         "tBodyAcc-std()-X", "tBodyAcc-std()-Y", "tBodyAcc-std()-Z", "tGravityAcc-mean()-X",
                         "tGravityAcc-mean()-Y", "tGravityAcc-mean()-Z", "tGravityAcc-std()-X", "tGravityAcc-std()-Y",
                         "tGravityAcc-std()-Z", "tBodyAccJerk-mean()-X", "tBodyAccJerk-mean()-Y", "tBodyAccJerk-mean()-Z",
                         "tBodyAccJerk-std()-X", "tBodyAccJerk-std()-Y", "tBodyAccJerk-std()-Z", "tBodyGyro-mean()-X",
                         "tBodyGyro-mean()-Y", "tBodyGyro-mean()-Z", "tBodyGyro-std()-X", "tBodyGyro-std()-Y",
                         "tBodyGyro-std()-Z", "tBodyGyroJerk-mean()-X", "tBodyGyroJerk-mean()-Y", "tBodyGyroJerk-mean()-Z",
                         "tBodyGyroJerk-std()-X", "tBodyGyroJerk-std()-Y", "tBodyGyroJerk-std()-Z", "tBodyAccMag-mean()",
                         "tBodyAccMag-std()", "tGravityAccMag-mean()", "tGravityAccMag-std()", "tBodyAccJerkMag-mean()",
                         "tBodyAccJerkMag-std()", "tBodyGyroMag-mean()", "tBodyGyroMag-std()", "tBodyGyroJerkMag-mean()",
                         "tBodyGyroJerkMag-std()", "fBodyAcc-mean()-X", "fBodyAcc-mean()-Y", "fBodyAcc-mean()-Z",
                         "fBodyAcc-std()-X", "fBodyAcc-std()-Y", "fBodyAcc-std()-Z", "fBodyAccJerk-mean()-X",
                         "fBodyAccJerk-mean()-Y", "fBodyAccJerk-mean()-Z", "fBodyAccJerk-std()-X", "fBodyAccJerk-std()-Y",
                         "fBodyAccJerk-std()-Z", "fBodyGyro-mean()-X", "fBodyGyro-mean()-Y", "fBodyGyro-mean()-Z",
                         "fBodyGyro-std()-X", "fBodyGyro-std()-Y", "fBodyGyro-std()-Z", "fBodyAccMag-mean()",
                         "fBodyAccMag-std()", "fBodyBodyAccJerkMag-mean()", "fBodyBodyAccJerkMag-std()",
                         "fBodyBodyGyroMag-mean()", "fBodyBodyGyroMag-std()", "fBodyBodyGyroJerkMag-mean()",
                         "fBodyBodyGyroJerkMag-std()")

View(DATASET)

# 5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

SUBJECT = read.table("train/subject_train.txt", header = FALSE, sep = "", dec = ".")
unique(SUBJECT)
names(SUBJECT) = "Subject"
View(SUBJECT)

DATASET2 = DATASET[1:7352, ]
View(DATASET2)

DATASET3 = cbind(SUBJECT, DATASET2)
View(DATASET3)

FINAL = with(DATASET3, tapply(DATASET3[, 3:68], list(DATASET3$Subject, DATASET3$Activity), mean))

write.table(FINAL, file = "FINAL.txt", row.name=FALSE)
