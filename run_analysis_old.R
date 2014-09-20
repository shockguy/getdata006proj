#My comments are verbose.  I realized this is not useful for production code.
#I am trying to clearly communicate to you, dear peer reviewer, what I 
#did and why I did it.

#Read in of the training data.  X_train.txt is fixed width,
#but read.table was much faster.  Used the others just to see what worked
traind<-read.table("./dataset/train/X_train.txt",strip.white=TRUE,nrows=7352,sep="")
trainsub<-read.delim("./dataset/train/subject_train.txt",header=FALSE,sep="", nrows=7352)
trainact<-read.fwf("./dataset/train/y_train.txt",widths=1,header=FALSE,n=7352)

#Read in of the test data
testd<-read.table("./dataset/test/X_test.txt",nrow=2947,strip.white=TRUE,sep="")
testsub<-read.delim("./dataset/test/subject_test.txt",header=FALSE,sep="", nrows=2947)
testact<-read.fwf("./dataset/test/y_test.txt",widths=1,header=FALSE,n=2947)

#Add Names to the subject and activity columns
names(testsub)<-"subject"
names(trainsub)<-"subject"
names(testact)<-"activityNumber"
names(trainact)<-"activityNumber"

#Read in "features.txt" file for naming of data columns
features<-read.table("./dataset/features.txt",nrows=561)
colnames<-as.vector(features$V2, mode="character")
#Applied names to the training data.  This is a bit out of order from the instructions,
#but I wanted to use the column names to select the requested mean and std columns
names(testd)<-colnames
names(traind)<-colnames

#Created lables to map to the activity ID numbers
actlable=c("walking","walking_upstairs","walking_downstairs","sitting","standing","laying")

#Add lables as fractors mapped to activity ID numbers 
trainf<-factor(trainact$activityNumber,labels=actlable)
#Create a descriptive activity column that can be added to the training data frame
trainf<-data.frame(trainf)
#Give the column a descriptive name
names(trainf)<-"activity"

#Same activity desciptive name column mapping/naming for test as was done for training
testf<-factor(testact$activityNumber,labels=actlable)   
testf<-data.frame(testf)
names(testf)<-"activity"

#Add the respective activity name columns to their dataframes
#This is done sooner than the steps in the instructions imply,
#but it allow the "mean" and "std" column data to be selected easily. 
test<-cbind(testf, testact, testsub, testd)
training<-cbind(trainf, trainact, trainsub, traind)

#Merge the training and test data.  Could have used merge(), but it does not maintain
#order of rows, and I wanted to stay as close to the original data structure as possible
data<-rbind(test,training)

#Determine which columns are "mean" and "std".
#The result is a integer vector of those column numbers
#Used the character strings to identify those columns, which is why I had already the
#descriptions to the columns.
meancol<-grep(c("mean"),c(names(data)))
stdcol<-grep(c("std"),c(names(data)))
measurecol<-append(stdcol,meancol)

#Create the data frame having only extracted "mean" and "std" columns from the complete set
#as instructed in Step to of the instructions.
part2_data<-data[,measurecol]

#Write out the "mean" and "std" only frame.  Not called for in the instructions,
#but why create if not to keep and use for something
write.table(part2_data,file="part2_data.txt",row.names=FALSE,sep=",")

#sub1<-subset(data,activity=="standing" & subject=="2")

#The final output is the average of all variables per activity/subject
#This creates the descriptive column names for that by taking
#the origional column names and prepending "avg-"
avg_colnames<-sapply(colnames, function(x) paste("avg-", x,sep=""),USE.NAMES=FALSE)

#Create the data frame of all variables averaged, per activity/subject.  
#I am getting these from the full combined data set.  It was not clear from the
#instructions if this averaged data from should be from the complete set, or from the 
#"mean" and "std" set.  I went with the larger, and clearly if you can do one 
#then you can do the other.
all_avgs<-aggregate(data[,-(1:3)],c(data["activity"],data["subject"]),function(x) mean(x))

#Applied the descriptive column names, which have the avg- prepend
#Also have to include the names for the subject and activity
names(all_avgs)<-c(names(all_avgs[1:2]),avg_colnames)

#Write out the averages of all variables per activity. 
#This satisfies the final step in the instructions, and is uploaded
#into the first peer review block
write.table(all_avgs,file="project_upload.txt",row.names=FALSE,sep=",")
