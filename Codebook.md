# Data Sources

The original data is read from the following files: 

Feature descriptions: 'UCI HAR Dataset/features.txt'
Activity descriptions: 'UCI HAR Dataset/activity_labels.txt'
Actual variable values: 'UCI HAR Dataset/train/X_train.txt' and 'UCI HAR Dataset/test/X_test.txt'
Subject ids: 'UCI HAR Dataset/train/subject_train.txt' and 'UCI HAR Dataset/test/subject_test.txt'
Activity ids appropriate for the data: 'UCI HAR Dataset/train/y_train.txt' and 'UCI HAR Dataset/test/y_test.txt'



# Transformations

Training and testing data were merged in union-all (i.e. row-wise) fashion w.r.t. the file type, e.g. subject id training
was merged with subject id testing in that order. Activity ids available in source data were translated to their 
descriptions using the dictionary. Only the features of interest were extracted (i.e. those columns of the actual data 
which correspond to mean and standard deviation of the features). meanFrequency was interepreted as qualifying for the pull. 

The resultant dataset is named data.combined and is further summarized into a tidy dataset mt (long format) which is aggregated 
into data.summarized by computing the mean values of every variable with respect to subject id and activity description (NA values (if any) 
are not taken into account). 




# Variable Names and Descriptions of the Final Tidy Dataset

SubjectId: integral value taken from 'subject_train.txt' and 'subject_test.txt' files

ActivityDescr: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

Variable: one of the following values (note, 'meanFreq' is taken to be mean value)

tBodyAcc-mean()-X
tBodyAcc-mean()-Y
tBodyAcc-mean()-Z
tGravityAcc-mean()-X
tGravityAcc-mean()-Y
tGravityAcc-mean()-Z
tBodyAccJerk-mean()-X
tBodyAccJerk-mean()-Y
tBodyAccJerk-mean()-Z
tBodyGyro-mean()-X
tBodyGyro-mean()-Y
tBodyGyro-mean()-Z
tBodyGyroJerk-mean()-X
tBodyGyroJerk-mean()-Y
tBodyGyroJerk-mean()-Z
tBodyAccMag-mean()
tGravityAccMag-mean()
tBodyAccJerkMag-mean()
tBodyGyroMag-mean()
tBodyGyroJerkMag-mean()
fBodyAcc-mean()-X
fBodyAcc-mean()-Y
fBodyAcc-mean()-Z
fBodyAcc-meanFreq()-X
fBodyAcc-meanFreq()-Y
fBodyAcc-meanFreq()-Z
fBodyAccJerk-mean()-X
fBodyAccJerk-mean()-Y
fBodyAccJerk-mean()-Z
fBodyAccJerk-meanFreq()-X
fBodyAccJerk-meanFreq()-Y
fBodyAccJerk-meanFreq()-Z
fBodyGyro-mean()-X
fBodyGyro-mean()-Y
fBodyGyro-mean()-Z
fBodyGyro-meanFreq()-X
fBodyGyro-meanFreq()-Y
fBodyGyro-meanFreq()-Z
fBodyAccMag-mean()
fBodyAccMag-meanFreq()
fBodyBodyAccJerkMag-mean()
fBodyBodyAccJerkMag-meanFreq()
fBodyBodyGyroMag-mean()
fBodyBodyGyroMag-meanFreq()
fBodyBodyGyroJerkMag-mean()
fBodyBodyGyroJerkMag-meanFreq()
tBodyAcc-std()-X
tBodyAcc-std()-Y
tBodyAcc-std()-Z
tGravityAcc-std()-X
tGravityAcc-std()-Y
tGravityAcc-std()-Z
tBodyAccJerk-std()-X
tBodyAccJerk-std()-Y
tBodyAccJerk-std()-Z
tBodyGyro-std()-X
tBodyGyro-std()-Y
tBodyGyro-std()-Z
tBodyGyroJerk-std()-X
tBodyGyroJerk-std()-Y
tBodyGyroJerk-std()-Z
tBodyAccMag-std()
tGravityAccMag-std()
tBodyAccJerkMag-std()
tBodyGyroMag-std()
tBodyGyroJerkMag-std()
fBodyAcc-std()-X
fBodyAcc-std()-Y
fBodyAcc-std()-Z
fBodyAccJerk-std()-X
fBodyAccJerk-std()-Y
fBodyAccJerk-std()-Z
fBodyGyro-std()-X
fBodyGyro-std()-Y
fBodyGyro-std()-Z
fBodyAccMag-std()
fBodyBodyAccJerkMag-std()
fBodyBodyGyroMag-std()
fBodyBodyGyroJerkMag-std()

Average: arithmetic mean value of the variables listed above w.r.t. subject id and activity description









