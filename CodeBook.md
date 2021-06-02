# CodeBook

## Background:

**Name:** Nikhil Das  
**Course:** Coursera - Data Science Johns Hopkins - Getting and Cleaning Data Final project (Week 4)  
**Location:** San Francisco, CA  
**Email:** nikd29@gmail.com  
**Data Source:** https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
**Data Source Description:** http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  


## Processing Steps:

An R script was created called run_analysis.R that has the following steps:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Detailed Steps:

**Step 1**:  
- Data was loaded and test, training, associated activity and feature label data were all read in as tibbles to tidy the data with dplyr.
- Columns were renamed descriptively to make manipulation easier (using colnames() function with the 'data_features' tibble), and Subject/Activity Columns were combined with training and test data with cbind()
- Then, the training and test data sets were row combined using rbind(), with the training data appended to the last row of test data (row 2947)

**Step 2**:  
- A combination of select() and contains() logicals were used to subset the row combined data that contained the words 'mean' and 'std' (as well as 'Subject' and 'Activity' columns)

**Step 3**:  
- As stated before a key/value lookup list was used to make description activity names, and tidy the data. The list was defined using the 'activity_labels.txt' file, in combination with the names() function.

**Step 4**:   
- Variables were renamed (see Step 1.2) with colnames() function from provided 'features.txt' file defined as a 'data_features' tibble. 

**Step 5**:   
- Creates group of 'EACH Subject and Activity' (hw step 5) using group_by() function with Subject and ActivityName as parameters.
- CREATES the independent tidy data set with Averages across each numeric column for each Activity/Subject pair using summarise() function with is.numeric() and mean()
- TIDY UP the final table using a function to prefix feature columns with 'AVG_' to indication the tables values are Averages across the Activity/Subject combinations. Applied this function with the rename_with() function to rename columns 4:end (numeric columns)


## Feature Selection Overview (copied from source):
***Note: Only std() and mean() variables apply for this assignment***

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were 
captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. 
Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a 
corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these 
three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. 
(Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  

'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

*tBodyAcc-XYZ  
tGravityAcc-XYZ  
tBodyAccJerk-XYZ  
tBodyGyro-XYZ  
tBodyGyroJerk-XYZ  
tBodyAccMag  
tGravityAccMag  
tBodyAccJerkMag  
tBodyGyroMag  
tBodyGyroJerkMag  
fBodyAcc-XYZ  
fBodyAccJerk-XYZ  
fBodyGyro-XYZ  
fBodyAccMag  
fBodyAccJerkMag  
fBodyGyroMag  
fBodyGyroJerkMag*  

The set of variables that were estimated from these signals are: 

**mean(): Mean value**  
**std(): Standard deviation**  
mad(): Median absolute deviation  
max(): Largest value in array  
min(): Smallest value in array  
sma(): Signal magnitude area  
energy(): Energy measure. Sum of the squares divided by the number of values.  
iqr(): Interquartile range  
entropy(): Signal entropy  
arCoeff(): Autorregresion coefficients with Burg order equal to 4  
correlation(): correlation coefficient between two signals  
maxInds(): index of the frequency component with largest magnitude  
meanFreq(): Weighted average of the frequency components to obtain a mean frequency  
skewness(): skewness of the frequency domain signal  
kurtosis(): kurtosis of the frequency domain signal  
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.  
angle(): Angle between to vectors.  

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean  
tBodyAccMean  
tBodyAccJerkMean  
tBodyGyroMean  
tBodyGyroJerkMean  

The complete list of variables of each feature vector is available in 'features.txt'



## Variables List:

**Subject**  
	1-30 Subjects tested during the study


**ActivityCode & ActivityName**  
	1 WALKING  
	2 WALKING_UPSTAIRS  
	3 WALKING_DOWNSTAIRS  
	4 SITTING  
	5 STANDING  
	6 LAYING  


**Feature Names**  
***Note: All quanitities in this study were prefixed with "AVG_" to indicate average across each ActivityName/Subject pair***

	tBodyAcc-mean()-X
	tBodyAcc-mean()-Y
	tBodyAcc-mean()-Z
	tBodyAcc-std()-X
	tBodyAcc-std()-Y
	tBodyAcc-std()-Z
	tGravityAcc-mean()-X
	tGravityAcc-mean()-Y
	tGravityAcc-mean()-Z
	tGravityAcc-std()-X
	tGravityAcc-std()-Y
	tGravityAcc-std()-Z
	tBodyAccJerk-mean()-X
	tBodyAccJerk-mean()-Y
	tBodyAccJerk-mean()-Z
	tBodyAccJerk-std()-X
	tBodyAccJerk-std()-Y
	tBodyAccJerk-std()-Z
	tBodyGyro-mean()-X
	tBodyGyro-mean()-Y
	tBodyGyro-mean()-Z
	tBodyGyro-std()-X
	tBodyGyro-std()-Y
	tBodyGyro-std()-Z
	tBodyGyroJerk-mean()-X
	tBodyGyroJerk-mean()-Y
	tBodyGyroJerk-mean()-Z
	tBodyGyroJerk-std()-X
	tBodyGyroJerk-std()-Y
	tBodyGyroJerk-std()-Z
	tBodyAccMag-mean()
	tBodyAccMag-std()
	tGravityAccMag-mean()
	tGravityAccMag-std()
	tBodyAccJerkMag-mean()
	tBodyAccJerkMag-std()
	tBodyGyroMag-mean()
	tBodyGyroMag-std()
	tBodyGyroJerkMag-mean()
	tBodyGyroJerkMag-std()
	fBodyAcc-mean()-X
	fBodyAcc-mean()-Y
	fBodyAcc-mean()-Z
	fBodyAcc-std()-X
	fBodyAcc-std()-Y
	fBodyAcc-std()-Z
	fBodyAcc-meanFreq()-X
	fBodyAcc-meanFreq()-Y
	fBodyAcc-meanFreq()-Z
	fBodyAccJerk-mean()-X
	fBodyAccJerk-mean()-Y
	fBodyAccJerk-mean()-Z
	fBodyAccJerk-std()-X
	fBodyAccJerk-std()-Y
	fBodyAccJerk-std()-Z
	fBodyAccJerk-meanFreq()-X
	fBodyAccJerk-meanFreq()-Y
	fBodyAccJerk-meanFreq()-Z
	fBodyGyro-mean()-X
	fBodyGyro-mean()-Y
	fBodyGyro-mean()-Z
	fBodyGyro-std()-X
	fBodyGyro-std()-Y
	fBodyGyro-std()-Z
	fBodyGyro-meanFreq()-X
	fBodyGyro-meanFreq()-Y
	fBodyGyro-meanFreq()-Z
	fBodyAccMag-mean()
	fBodyAccMag-std()
	fBodyAccMag-meanFreq()
	fBodyBodyAccJerkMag-mean()
	fBodyBodyAccJerkMag-std()
	fBodyBodyAccJerkMag-meanFreq()
	fBodyBodyGyroMag-mean()
	fBodyBodyGyroMag-std()
	fBodyBodyGyroMag-meanFreq()
	fBodyBodyGyroJerkMag-mean()
	fBodyBodyGyroJerkMag-std()
	fBodyBodyGyroJerkMag-meanFreq()
