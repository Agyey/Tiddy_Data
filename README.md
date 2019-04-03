# Tiddy_Data Creation


# 0. Cleaning and accessing Data

## Reading activity_labels.txt to labels, getting values for factor 1-6 
```
labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
```
## Reading test dataset
### Reading X_test.txt to test 
```
test <- read.table("./UCI HAR Dataset/test/X_test.txt")
```
### Reading y_test.txt to test_y for activity values
```
test_y <- read.table("./UCI HAR Dataset/test/y_test.txt")
```
### Reading subject_test.txt to subject_test for subject IDs
```
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
```
## Adding column Acitivity to test from test_y
```
test["Activity"] <- test_y
```
## Adding column Subject to test from subject_test
```
test["Subject"] <- subject_test
```
# 3.1 Descriptive acitivity names
## Adding Descriptive names to activities
```
test$Activity <- factor(test$Activity,levels = c(1,2,3,4,5,6), labels = labels$V2)
```

## Reading train dataset
### Reading X_train.txt to train
```
train <- read.table("./UCI HAR Dataset/train/X_train.txt")
```
### Reading y_train.txt to train_y for activity values
```
train_y <- read.table("./UCI HAR Dataset/train/y_train.txt")
```
### Reading subject_test.txt to subject_train for subject IDs
```
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
```
## Adding column Acitivity to train from train_y
```
train["Activity"] <- train_y
```
## Adding column Subject to train from subject_train
```
train["Subject"] <- subject_train
```
# 3.2 Descriptive acitivity names
## Adding Descriptive names to activities
```
train$Activity <- factor(train$Activity,levels = c(1,2,3,4,5,6), labels = labels$V2)
```

# 1. Merging Data
## Merging test and train into a single dataset
```
data <- merge(test,train,all=TRUE)
```

## Extracting features/column names from features.txt
```
feature <- read.table("./UCI HAR Dataset/features.txt")
```
# 4. Appropriately labelling columns
## Giving every column a proper description from features.txt
```
colnames(data) <- c(as.character(feature$V2),"Activity","Subject")
```

# 2. Extracting mean standard deviation Values
## Only extracting mean and standard deviation of measurements
```
mean_std_data <- data[grep("(std)|(Mean)|(mean)|(Activity)|(Subject)",colnames(data))]
```

# 5. Grouping and mean
## grouping by acitivity and subject and finding mean of all the values
```
activity <- group_by(mean_std_data,Activity)
subject <- group_by(mean_std_data,Subject)
set <- aggregate(activity[1:86],list(activity$Activity,activity$Subject),mean)
set <- rename(set,Activity = Group.1,Subject = Group.2)
```
