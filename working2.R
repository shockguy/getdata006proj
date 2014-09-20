

traind<-read.table("./dataset/train/X_train.txt",strip.white=TRUE,nrows=7352,sep="")
trainsub<-read.delim("./dataset/train/subject_train.txt",header=FALSE,sep="", nrows=7352)
trainact<-read.fwf("./dataset/train/y_train.txt",widths=1,header=FALSE,n=7352)

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
names(testd)<-colnames
names(traind)<-colnames
actlable=c("walking","walking_upstairs","walking_downstairs","sitting","standing","laying")
trainf<-factor(trainact$activityNumber,labels=actlable)
trainf<-data.frame(trainf)
names(trainf)<-"activity"
testf<-factor(testact$activityNumber,labels=actlable)   
testf<-data.frame(testf)
names(testf)<-"activity"

test<-cbind(testf, testact, testsub, testd)
training<-cbind(trainf, trainact, trainsub, traind)

data<-rbind(test,training)

meancol<-grep(c("mean"),c(names(data)))
stdcol<-grep(c("std"),c(names(data)))
measurecol<-append(stdcol,meancol)

part2_data<-data[,measurecol]

sub1<-subset(data,activity=="standing" & subject=="2")
avg_colnames<-sapply(colnames, function(x) paste("avg-", x,sep=""),USE.NAMES=FALSE)


all_avgs<-aggregate(data[,-(1:3)],c(data["activity"],data["subject"]),function(x) mean(x))

names(all_avgs)<-c(names(all_avgs[1:2]),avg_colnames)

write.table(all_avgs,file="project_upload.txt",row.names=FALSE,sep=",")
