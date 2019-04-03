# reading activity_labels.txt
labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# reading test dataset
# reading X_test.txt
test <- read.table("./UCI HAR Dataset/test/X_test.txt")
# reading y_test.txt
test_y <- read.table("./UCI HAR Dataset/test/y_test.txt")
# reading subject_test.txt
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
# adding column Acitivity to test
test["Activity"] <- test_y
# adding column Subject to test
test["Subject"] <- subject_test
# Adding Descriptive names to activities
test$Activity <- factor(test$Activity,levels = c(1,2,3,4,5,6), labels = labels$V2)

# reading train dataset
# reading X_train.txt
train <- read.table("./UCI HAR Dataset/train/X_train.txt")
# reading y_train.txt
train_y <- read.table("./UCI HAR Dataset/train/y_train.txt")
# reading subject_test.txt
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
# adding column Acitivity to train
train["Activity"] <- train_y
# adding column Subject to train
train["Subject"] <- subject_train
# Adding Descriptive names to activities
train$Activity <- factor(train$Activity,levels = c(1,2,3,4,5,6), labels = labels$V2)


# merging test and train into a single dataset
data <- merge(test,train,all=TRUE)

# extracting features
feature <- read.table("./UCI HAR Dataset/features.txt")
# giving every column a proper description from features.txt
colnames(data) <- c(as.character(feature$V2),"Activity","Subject")

# only extracting mean and standard deviation of measurements
mean_std_data <- data[grep("(std)|(mean)|(Activity)|(Subject)",colnames(data))]

# grouping by acitivity and subject and finding mean of all the values
activity <- group_by(mean_std_data,Activity)
subject <- group_by(mean_std_data,Subject)
set <- aggregate(activity[1:79],list(activity$Activity,activity$Subject),mean)