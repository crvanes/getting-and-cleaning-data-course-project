# getting-and-cleaning-data-course-project
# First of all the data of the test group and the train group are read in to the variables X.1 and X.2 respectively.
# Then the training and test sets are merged in the variable X.
# In the next step the column names that end with `-std()` or  ´-mean()´ are selected (because the dataset contains duplicate column names, they have to be filtered out)
# Then the numbers 1-6 are replaced by descriptive activity names.
# Finally a new tidy data set containing the averages for each subject and each activity is created. In the first column a number between 1 and 30 points to the subject.
