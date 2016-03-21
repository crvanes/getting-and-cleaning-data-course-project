library(dplyr)

features<-read.table("UCI HAR Dataset/features.txt")

subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
X_train<-read.table("UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("UCI HAR Dataset/train/y_train.txt")

names(subject_train)="Subject_ID"
names(X_train)=features[,2]     
names(y_train)="Activity"
X.1<-cbind(subject_train,y_train,X_train)

subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
X_test<-read.table("UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("UCI HAR Dataset/test/y_test.txt")

names(subject_test)="Subject_ID"
names(X_test)=features[,2]     
names(y_test)="Activity"
X.2<-cbind(subject_test,y_test,X_test)

X<-rbind(X.1,X.2)     #Merges the training and the test sets to create one data set.

X<-X[,!duplicated(colnames(X))]
X.subset<-select(X, Subject_ID, Activity, ends_with("-std()"), ends_with("-mean()"))     #Extracts only the measurements on the mean and standard deviation for each measurement.


#3. Uses descriptive activity names to name the activities in the data set:
X.subset[,2]<-sub("1","WALKING",X.subset[,2])
X.subset[,2]<-sub("2","WALKING_UPSTAIRS",X.subset[,2])
X.subset[,2]<-sub("3","WALKING_DOWNSTAIRS",X.subset[,2])
X.subset[,2]<-sub("4","SITTING",X.subset[,2])
X.subset[,2]<-sub("5","STANDING",X.subset[,2])
X.subset[,2]<-sub("6","LAYING",X.subset[,2])

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject:
library(reshape2)
n=names(X.subset)[3:20]
X.Melt<-melt(X.subset,id=c("Subject_ID","Activity"),measure.var=n)
Data1<-dcast(X.Melt,Subject_ID~variable,mean)
Data2<-dcast(X.Melt,Activity~variable,mean)
names(Data1)[1]="Subject_ID/Activity"
names(Data2)[1]="Subject_ID/Activity"
Data<-rbind(Data1,Data2)

write.table(Data,file="data_set_step_5.txt",row.name=FALSE)


