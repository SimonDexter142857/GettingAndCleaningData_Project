# ###################################################
# Author: Simon Dexter, simondex@yahoo.com
# Date:   10/12/14
#
#         ; 10/25/14: adding additional comments
#
# Descr: source code for class project
#
# Precondition(s):
#         ; script expects source files to be in the working 
#         directory under 'UCI HAR Dataset' folder
#
#
# ###################################################


# two packages which will be required for the script to operate
require(reshape2);
require(dplyr);
# making R show extra digits (to account for the full significand)
options(digits=10);

# reading the features dictionary 
# may need to change path separator depending on the system (i.e. Windows-based / UNIX-based)
features = read.table("UCI HAR Dataset\\features.txt", header=F, stringsAsFactors=F,colClasses='character');

# assigning column names 
colnames(features) = c('FeatureId', 'FeatureDescr'); 


# selecting columns which correspond to average and standard deviations
# note -- this will grab 'meanFreq' features as well 
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


# reading training portion of the dataset
x.tr = read.table(
	file="UCI HAR Dataset\\train\\X_train.txt", 
	header=F, 
	stringsAsFactors=F,
	strip.white=T
);




# reading testing portion of the dataset

x.ts = read.table(
	file="UCI HAR Dataset\\test\\X_test.txt", 
	header=F, 
	stringsAsFactors=F,
	strip.white=T

);

# combining train and test datasets in union-all fashion
x.all=rbind(x.tr, x.ts);

# assigning feature column names to the combined dataset
colnames(x.all) = features$FeatureDescr;
# removing extaneous objects from workspace 
rm(list=c('x.tr','x.ts'));

# reading the training and testing subject list
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
# combining in union-all fashion
s.all = rbind(s.tr, s.ts);
rm(list = c('s.tr','s.ts'));

colnames(s.all) = c('SubjectId');

# reading training and testing activity labels

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
# combining in union-all fashion
y.all = rbind(y.tr, y.ts);
# assigning valid column name
colnames(y.all) = c('ActivityId');
# removing extaneous objects from workspace 
rm(list=c('y.tr','y.ts'));
# inner-joining activity label dictionary for translation
y.all.lab = merge(y.all, al, by='ActivityId');


# selecting only the features of interest, check.names option is for R
# to avoid truncating names
x.all.d = data.frame( x.all[, f], check.names=F );


# step 4: creating combined dataset
data.combined = data.frame(SubjectId = s.all$SubjectId, ActivityDescr = y.all.lab$ActivityDescr,  x.all.d, check.names=F);

# removing extraneous datasets
rm(list=c('s.all', 'y.all.lab', 'x.all.d', 'x.all', 'y.all', 'features', 'al', 'f' ));

# making a tidy dataset 
m = melt(data.combined,id=c('SubjectId', 'ActivityDescr'), na.rm=T );
# assigning better-looking column names for consistency
colnames(m)[3:4] = c('Variable', 'Value');
# preparing for dplyr operations
mt = tbl_df(m);


# producing final aggregated output
data.summarized = {
	mt %>% 
	group_by (SubjectId, ActivityDescr, Variable ) %>% 
	summarize(Average = mean(Value, na.rm=T))
}
# recording into output file
write.table(data.summarized, 'output.txt', row.name=F,sep='\t', quote=F);

rm('m');


