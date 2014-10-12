##############################################
# Author: Simon Dexter, simondex@yahoo.com
# Date:   10/12/14
#
# 
##############################################

run_analysis.R reads data from 'UCI HAR Dataset' folder which should have subfolders for test and training data. The folder 'UCI HAR Dataset' should be in the working directory for R to see. The script looks for file 'activity_labels.txt' and constructs the dictionary of activities. The following two files are combined in row-wise fashion:

UCI HAR Dataset\train\X_train.txt
UCI HAR Dataset\test\X_test.txt

The resultant dataset is assigned column names from 'features.txt' which is located in:

"UCI HAR Dataset\features.txt"

Only columns corresponding to mean and standard deviation values are selected. Note that 'meanFreq' is taken to be a mean value. For example, the following feature is selected: 

'tBodyAcc-mean()-X'

but 'tBodyAcc-mad()-X' is excluded. 

Subject ids are read from the following two files:

UCI HAR Dataset\train\subject_train.txt
UCI HAR Dataset\test\subject_test.txt

The activity, subject and x files (which consist of both training and testing datasets by now) are combined in column-wise fashion to form data.combined. This dataset is further brought into tidy form by application of melt command. The data is then aggregate with respect to subject, activity and variable columns by averaging 'value' column. The product of this aggregation is recorded into final resultant file 'output.txt'.


Please consult Codebook.md file for more concise description of output.txt










