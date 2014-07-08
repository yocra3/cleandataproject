#Step 1: merging both datasets
##Load the data
setwd("CleanData/cleandataproject/")
testdata <- read.table("./data/test/X_test.txt")
trainingdata <- read.table("./data/train/X_train.txt")
testlabels <- read.table("./data/test/Y_test.txt")
traininglabels <- read.table("./data/train/Y_train.txt")
testsubject <- read.table("./data/test/subject_test.txt")
trainsubject <- read.table("./data/train/subject_train.txt")
varnames <- read.table("./data/features.txt")

##Merge the activity labels
wholelabels <- rbind(testlabels, traininglabels)
colnames(wholelabels) <- "activity"

##Merge the subject labels
wholesubjects <- rbind(testsubject, trainsubject)
colnames(wholesubjects) <- "subject"

##Merge the data 
wholedata <- rbind(testdata, trainingdata)
colnames(wholedata) <- varnames$V2

#Step 2: Extract the measurements of mean and standard deviation
##The variables are filtered and only those that have a mean( or std( pattern are included
filtervalues <- grep("mean\\(|std\\(", colnames(wholedata), value=TRUE)
wholedata <- wholedata[,filtervalues]

##The labels and the data are merged
data <- cbind(wholesubjects, wholelabels, wholedata)

#Step 3: Use descriptive activity names
activities <- c("walking", "walkingupstairs", "walkingdownstairs", "sitting", "standing", "laying")
data$activity <- factor(activities[data$activity])

#Step 4: Use descriptive variable names
newvariablenames <- c("subject", "activity", "meantimebodyaccelerometeraxisx", "meantimebodyaccelerometeraxisy", 
                      "meantimebodyaccelerometeraxisz", "stdtimebodyaccelerometeraxisx", 
                      "stdtimebodyaccelerometeraxisy", "stdtimebodyaccelerometeraxisz",
                      "meantimegravityaccelerometeraxisx", "meantimegravityaccelerometeraxisy",
                      "meantimegravityaccelerometeraxisz", "stdtimegravityaccelerometeraxisx",
                      "stdtimegravityaccelerometeraxisy", "stdtimegravityaccelerometeraxisz",
                      "meantimebodyjerkaccelerometeraxisx", "meantimebodyjerkaccelerometeraxisy",
                      "meantimebodyjerkaccelerometeraxisz", "stdtimebodyjerkaccelerometeraxisx",
                      "stdtimebodyjerkaccelerometeraxisy", "stdtimebodyjerkaccelerometeraxisz",
                      "meantimebodygyroscopeaxisx", "meantimebodygyroscopeaxisy",
                      "meantimebodygyroscopeaxisz", "stdtimebodygyroscopeaxisx",
                      "stdtimebodygyroscopeaxisy", "stdtimebodygyroscopeaxisz",
                      "meantimebodyjerkgyroscopeaxisx", "meantimebodyjerkgyroscopeaxisy",
                      "meantimebodyjerkgyroscopeaxisz", "stdtimebodyjerkgyroscopeaxisx",
                      "stdtimebodyjerkgyroscopeaxisy", "stdtimebodyjerkgyroscopeaxisz",
                      "meantimebodyaccelerometermagnitude", "stdtimebodyaccelerometermagnitude",
                      "meantimegravityaccelerometermagnitude", "stdtimegravityaccelerometermagnitude",
                      "meantimebodyjerkaccelerometermagnitude", "stdtimebodyjerkaccelerometermagnitude",
                      "meantimebodygyroscopemagnitude", "stdtimebodygyroscopemagnitude",
                      "meanfrequencybodyjerkgyroscopemagnitude","stdfrequencybodyjerkgyroscopemagnitude",
                      "meanfrequencybodyaccelerometeraxisx", "meanfrequencybodyaccelerometeraxisy", 
                      "meanfrequencybodyaccelerometeraxisz", "stdfrequencybodyaccelerometeraxisx", 
                      "stdfrequencybodyaccelerometeraxisy", "stdfrequencybodyaccelerometeraxisz",
                      "meanfrequencybodyjerkaccelerometeraxisx", "meanfrequencybodyjerkaccelerometeraxisy",
                      "meanfrequencybodyjerkaccelerometeraxisz", "stdfrequencybodyjerkaccelerometeraxisx",
                      "stdfrequencybodyjerkaccelerometeraxisy", "stdfrequencybodyjerkaccelerometeraxisz",
                      "meanfrequencybodygyroscopeaxisx", "meanfrequencybodygyroscopeaxisy",
                      "meanfrequencybodygyroscopeaxisz", "stdfrequencybodygyroscopeaxisx",
                      "stdfrequencybodygyroscopeaxisy", "stdfrequencybodygyroscopeaxisz",
                      "meanfrequencybodyaccelerometermagnitude", "stdfrequencybodyaccelerometermagnitude",
                      "meanfrequencybodyjerkaccelerometermagnitude", "stdfrequencybodyjerkaccelerometermagnitude",
                      "meanfrequencybodygyroscopemagnitude", "stdfrequencybodygyroscopemagnitude",
                      "meanfrequencybodyjerkgyroscopemagnitude", "stdfrequencybodyjerkgyroscopemagnitude")
colnames(data) <- newvariablenames

#Step 5: create the second data set
##Split the data by subject and then by activity and calculate the average of each variable
subdata <- split(data, data$subject)
activitydata <- lapply(subdata, function(x) split(x, x$activity))
newdata <- lapply(activitydata, function(x) lapply(x, function(y) colMeans(y[,-c(1,2)])))

##Merge all the means in one dataset
finaldataset <- data.frame()
for(i in 1:length(newdata)){
        subject <- names(newdata)[i]
        for (j in 1:length(newdata[[i]])){
                activity <- names(newdata[[i]])[j]
                newrow <- t(data.frame(c(subject,activity, newdata[[i]][[j]])))
                colnames(newrow) <- colnames(data)
                finaldataset <- rbind(finaldataset, newrow)
        }
}
rownames(finaldataset) <- 1:dim(finaldataset)[1]
write.table(finaldataset, "./secondataset.txt", row.names=FALSE, quote=FALSE)
