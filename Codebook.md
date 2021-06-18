	Downloaded dataset is in “UCI HAR Dataset”

	Assigned data are in variables:
1.	subjtrain <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
has the train data of the subjects
2.	subjtest <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
has the test data of the subjects
3.	activitytrain <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity")
has recorded train activity data 
4.	activitytest <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity")
has recorded activity of test data
5.	train <- read.table("UCI HAR Dataset/train/X_train.txt")
has recorded train features data
6.	test <- read.table("UCI HAR Dataset/test/X_test.txt")
has recorded feature of test data 

Step 1. Merges the training and the test sets to create one data set
1.	mergeddata <- rbind(train, test)
this code binds the train and test data into one dataframe “mergeddata”
2.	features <- read.table("UCI HAR Dataset/features.txt")
this code puts information from festures.txt into the dataframe “features”
3.	names(mergeddata) <- features$V2
this code assigns the measurement names into “mergeddata”

Step 2. Extracts only the measurements on the mean and standard deviation for each measurement
1.	meansd <- c(grep("mean\\(",names(mergeddata)),grep("std\\(", names(mergeddata)))
this code puts the results from extracting means and SDs into the vector “meansd”
2.	meansd <- meansd[order(meansd)]
this code reorders the orders of variables in “meansd”
3.	extracted <- mergeddata[,meansd]
this code binds the previous data with the new one with means and SDs into “extracted”

Step 3. Uses descriptive activity names to name the activities in the data set
1.	allsubjs <- rbind(subjtrain, subjtest)
this code binds “subjtrain” and “subjtest” into “allsubjs”
2.	allactivity <- rbind(activitytrain, activitytest)
this code binds “subjtrain” and “subjtest” into “allsubjs”
3.	extracted <- cbind(mergeddata[,meansd], allsubjs, allactivity)
this code binds “allsubjs” and “allactivity” into “extracted” and put them in the last two columns
4.	activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt")
this code assigns data to the dataframe “activitylabels” 
5.	extracted$activity <- factor(extracted$activity, labels = activitylabels$V2)
this code assigns the names of activity variables to the corresponding activity column in “extracted”

Step 4. Appropriately labels the data set with descriptive variable names
1.	names(mergeddata)<-gsub("^t", "time", names(mergeddata))
2. names(mergeddata)<-gsub("^f", "frequency", names(mergeddata))
3. names(mergeddata)<-gsub("Acc", "Accelerometer", names(mergeddata))
4. names(mergeddata)<-gsub("Gyro", "Gyroscope", names(mergeddata))
5. names(mergeddata)<-gsub("Mag", "Magnitude", names(mergeddata))
6. names(mergeddata)<-gsub("BodyBody", "Body", names(mergeddata)) 

the above labels the dataset

Step 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject 
1.	dtmergeddata <- data.table(extracted)
this code converts “extracted” into a data table named “tidydata”
2.	tidydata <- dtmergeddata[,lapply(.SD,mean), by = .(activity, subject)]
this code puts the tidy dataset into a variable
3.	write.table(tidydata, file = "tidydata.txt", row.names = FALSE) ## output the tidy dataset
this code writes “tidydata” into a txt file named “tidydata.txt”
4.	str(tidydata)
5.	tidydata
these two serve as the final check for the variable names and descriptive
