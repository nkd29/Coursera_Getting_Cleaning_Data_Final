# Review Criteria:
# 1. The submitted data set is tidy. 
# 2. The Github repo contains the required scripts.
# 3. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate 
# all the variables and summaries calculated, along with units, and any other relevant information.
# 4. The README that explains the analysis files is clear and understandable.
# 5. The work submitted for this project is the work of the student who submitted it.

# You should create one R script called run_analysis.R that does the following. 
# 1.Merges the training and the test sets to create one data set.
# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names. 
# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.

# *************   V4 Update: adds in forgotten Subject Data   *************

# Week 4 Course Project
library(dplyr)
library(data.table)

# Set setwd() to working directory containing data
setwd("C:/Users/nkd29/Desktop/Nikhils_Stuff/01_Career/03_Courses/Coursera_R_Data_Science_Johns_Hopkins/03_Getting_and_Cleaning_Data/Week4/course_final_data/UCI_HAR_Dataset")
# list.files()

# Load in data
data_test_set <- tbl_df(read.table("test/X_test.txt")) 
data_test_labels <- tbl_df(read.table("test/y_test.txt")) %>% rename(ActivityCode=V1)
data_test_subj <- tbl_df(read.table("test/subject_test.txt")) %>% rename(Subject=V1)
  
data_trn_set <- tbl_df(read.table("train/X_train.txt"))
data_trn_labels <- tbl_df(read.table("train/y_train.txt")) %>% rename(ActivityCode=V1)
data_trn_subj <- tbl_df(read.table("train/subject_train.txt")) %>% rename(Subject=V1)

data_features <-  tbl_df(read.table("features.txt")) %>% rename(id_num=V1,Feature=V2)
filt_features <- data_features %>% filter(Feature %like% "mean"|Feature %like% "std")

# write to csv to paste into README file
write.csv(filt_features,"filt_features.csv")

data_activity_key <- tbl_df(read.table("activity_labels.txt"))

# Set up column names to replace, and define new column names
oldnames = names(data_test_set)
length(oldnames)
oldnames
newnames = data_features$Feature    # same for both test and training sets
newnames
length(newnames)

# Rename each set's columns V1,V2,etc. with proper Feature Labels
colnames(data_test_set) <- newnames
colnames(data_trn_set) <- newnames

# Add in Subject & Activity Code label column to each data set
data_test_set <- cbind(data_test_subj,data_test_labels,data_test_set)
data_trn_set <- cbind(data_trn_subj,data_trn_labels,data_trn_set)

# COMBINE (RBIND) TEST AND TRAINING DATA SETS
data_comb <- rbind(data_test_set,data_trn_set)

# SUBSET the Activity, Mean and Standard Columns!
data_comb <-  data_comb %>% select(contains("Subject")|contains("Activity")|contains("mean")|contains("std"))

# *KEY/VALUE* Lookup table for Activities
getActivity <- data_activity_key$V2
names(getActivity) <- data_activity_key$V1

# Add column with Activity names using KEY/VALUE table
data_comb <- data_comb %>% 
  mutate(ActivityName=getActivity[data_comb$ActivityCode]) %>% 
  select(ActivityCode,ActivityName,everything())

# Step 5.From the data set in step 4, creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject.

# Creates group of 'EACH Subject and Activity' (hw step 5)
data_comb_grp <- group_by(data_comb,Subject,ActivityName)

# CREATES the independent tidy data set with Averages across numeric columns for each Activity/Subject pair
tidy_avg <- data_comb_grp %>% summarise(across(is.numeric,mean))

# TIDY UP the final table
add_avg <- function(name) {
  newname <- paste("AVG_",name,sep = "")
  return(newname)
}
tidy_avg <- rename_with(tidy_avg,add_avg,.cols = 4:ncol(tidy_avg))
View(tidy_avg)

write.table(tidy_avg,"tidy_avg.txt",row.names = FALSE)





# OLD:
# # This function works but was not needed, since all train and test data were 'row-combined'. 
# add_test <- function(name) {
#   newname <- paste(name,"_test",sep = "")
#   return(newname)
# }
# data_mean_std <- rename_with(data_mean_std,add_test)

# Summarize explanation: 
# | The last of the five core dplyr verbs, summarize(), collapses the dataset to a single row. Let's say we're
# | interested in knowing the average download size. summarize(cran, avg_bytes = mean(size)) will yield the mean
# | value of the size variable. Here we've chosen to label the result 'avg_bytes', but we could have named it
# | anything. Give it a try.


# TO DO: add in training data to final (data_mean_std) table
# 
# # 
# # add_x <- function(name) {
# #   newname <- paste(name,"_X",sep = "")
# #   return(newname)
# # }
# # add_x("nikhil")
# # # 
# # # data_trn_set <- tbl_df(read.table("train/X_train.txt"))
# # # data_trn_labels <- tbl_df(read.table("train/y_train.txt"))
# # # data_activity_key <- tbl_df(read.table("activity_labels.txt"))
# # # 
# # # View(data_test_x)
# # 
# # # Sample function:
# # # fahrenheit_to_celsius <- function(temp_F) {
# # #   temp_C <- (temp_F - 32) * 5 / 9
# # #   return(temp_C)
# # # }