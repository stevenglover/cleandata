# This script merges two datasets of physical activity tests using wearable mobile technology.
# The final output is a tidy dataset showing the average of all individual mean and standard deviation 
# measurements for each of the 6 activities performed by each of the 30 participants.
# This script requires the package "dpylr" to run, it can be installed by running the command 
# install.packages("dplyr") in R.


library(dplyr)

### PART 1 - Create one dataset from raw test and train data
# Read column headings into R
features <- read.table("./UCI HAR Dataset/features.txt", header=F)

# Read test data into R, call subject col "subject", y col "activity", assign x col names to names in features
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt", header=F, col.names=features$V2)
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt", header=F, col.names="activity")
subtest <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=F, col.names="subject")

# Read train data into R, call subject col "subject", y col "activity", assign x col names to names in features
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt", header=F, col.names=features$V2)
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt", header=F, col.names="activity")
subtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=F, col.names="subject")

# Merge test and train data into two dataframes, clean up originals
test <- cbind(subtest,ytest,xtest); rm(subtest,ytest,xtest)
train <- cbind(subtrain,ytrain,xtrain); rm(subtrain,ytrain,xtrain)

# Merge all, create variable "type"= 1 if test, 2 if train
#test <- mutate(test,type=1) ; train <- mutate(train, type=2) ## this line would be used to separate test and train participants if required
df1 <- rbind(test,train) ; rm(test,train) ##final dataset for PART 1

### PART 2 - Extracts mean and sd variables
# Extracts means and sd measurements, drops meanFreq
colmeanstd <- select(df1, contains("mean", ignore.case=T), contains("std", ignore.case=T))
colmeanstd <- select(colmeanstd, -contains("meanFreq", ignore.case=T))


#remerges with subject, activity and type data
infovars <- select(df1, subject, activity)
df2 <- cbind(infovars,colmeanstd) ; rm(colmeanstd) ## final dataset for PART 2


### PART 3 - Names activities in the dataset
activitylabels <- c("walking","walkingup","walkingdown","sitting","standing","laying")
df2$activity <- factor(df2$activity, labels=activitylabels) ##final dataset for PART 3


### PART 4 - Label variable names
# Clear (), -  and . from var names
names(df2) <- gsub("\\.","",names(df2))

# Remove BodyBody typo
names(df2) <- gsub("BodyBody","Body",names(df2))

# Expand start of var to time or freq
names(df2) <- gsub("^t","time",names(df2))
names(df2) <- gsub("^f","freq",names(df2))
names(df2) <- gsub("anglet","angletime",names(df2))


# Expand Gyro to Gyroscope and Acc to Accelerometer and Mag to Magnitude
names(df2) <- gsub("Gyro","Gyroscope",names(df2))
names(df2) <- gsub("Acc","Accelerometer",names(df2))
names(df2) <- gsub("Mag","Magnitude",names(df2))

# Expand std to stdeviation
names(df2) <- gsub("std","stdeviation",names(df2))

# To lowercase
names(df2) <- tolower(names(df2)) ## final dataset for PART 4

### PART 5 - Create dataset with average of each variable for each activity and subject
datafinal <- df2 %>% group_by(subject,activity) %>% summarise_each(funs(mean)) ## final dataset for PART 5

# end
