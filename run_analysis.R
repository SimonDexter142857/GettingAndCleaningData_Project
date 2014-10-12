##############################################
# Author: Simon Dexter, simondex@yahoo.com
# Date:   10/12/14
#
# Descr: source code for class project
#
##############################################



require(reshape2);
require(dplyr);

options(digits=10);

# reading the features dictionary 
features = read.table("UCI HAR Dataset\\features.txt", header=F, stringsAsFactors=F,colClasses='character');

# assigning column names 
colnames(features) = c('FeatureIndex', 'FeatureDescr'); 


# selecting columns which correspond to average and standard deviations
f = unique ( c(grep('mean', features$FeatureDescr), grep('std', features$FeatureDescr) ));

# reading activity dictionary
al = read.table(
	file="UCI HAR Dataset\\activity_labels.txt", 
	header=F, 
	stringsAsFactors=F,
	strip.white=T,
	colClasses='character'
);

# assignining meaningful columns
colnames(al) = c('ActivityId', 'ActivityDescr'); 


#
x.tr = read.table(
	file="UCI HAR Dataset\\train\\X_train.txt", 
	header=F, 
	stringsAsFactors=F,
	strip.white=T
#	colClasses='character'
);



x.ts = read.table(
	file="UCI HAR Dataset\\test\\X_test.txt", 
	header=F, 
	stringsAsFactors=F,
	strip.white=T
#	colClasses='character'
);

x.all=rbind(x.tr, x.ts);


colnames(x.all) = features$FeatureDescr;




s.tr = read.table(
	file="UCI HAR Dataset\\train\\subject_train.txt", 
	header=F, 
	stringsAsFactors=F,
	strip.white=T,
	colClasses='character'
);


s.ts = read.table(
	file="UCI HAR Dataset\\test\\subject_test.txt", 
	header=F, 
	stringsAsFactors=F,
	strip.white=T,
	colClasses='character'
);

s.all=rbind(s.tr, s.ts);

colnames(s.all) = c('SubjectId');



y.tr = read.table(
	file="UCI HAR Dataset\\train\\y_train.txt", 
	header=F, 
	stringsAsFactors=F,
	strip.white=T,
	colClasses='character'
);



y.ts = read.table(
	file="UCI HAR Dataset\\test\\y_test.txt", 
	header=F, 
	stringsAsFactors=F,
	strip.white=T,
	colClasses='character'
);

y.all = rbind(y.tr, y.ts);

colnames(y.all) = c('ActivityId');

y.all.lab = merge(y.all, al, by='ActivityId');



x.all.d = data.frame( x.all[, f], check.names=F );


# step 4
data.combined = data.frame(SubjectId = s.all$SubjectId, ActivityDescr = y.all.lab$ActivityDescr,  x.all.d, check.names=F);


# making a tidy dataset 
m = melt(data.combined,id=c('SubjectId', 'ActivityDescr'), na.rm=T );
# assigning better-looking column names for consistency
colnames(m)[3:4] = c('Variable', 'Value');
# preparing for dplyr operations
mt = tbl_df(m);

# final aggregation is output
data.summarized = {
	mt %>% 
	group_by (SubjectId, ActivityDescr, Variable ) %>% 
	summarize(Average = mean(Value, na.rm=T))
}

write.table(data.summarized, 'output.txt', row.name=F,sep='\t', quote=F);




