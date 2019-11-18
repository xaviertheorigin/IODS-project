#Xavier Riera
#18th November 2019
#Creating the data set
#Data source https://archive.ics.uci.edu/ml/machine-learning-databases/00320/student.zip

#Load the necessary libraries
library(dplyr)

#First we read the data and store it into two different variables
math <- read.table("student-mat.csv", sep = ";", header =TRUE)
por <- read.table("student-por.csv", sep = ";", header = TRUE)

#We explore the structure
str(math)
str(por)

#We explore the dimensions
dim(math)
dim(por)

#We join the two datasets into a single one
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
math_por <- inner_join(math, por, by = join_by, suffix = c(".math",".por"))

#We explore the new joint dataset
str(math_por)
dim(math_por)

# print out the column names of 'math_por'
colnames(math_por)

# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data
glimpse(alc)

#We take the average of the answers related to weekday and weekend alcohol consumption to create a new column 'alc_use'
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

#We use 'alc_use' to create a new logical column 'high_use' which is TRUE for students for which 'alc_use' is greater than 2
alc <- mutate(alc, high_use = alc_use > 2)

#We inspect the result
glimpse(alc)

#We save the results
write.table(alc, sep = "\t", col.names = TRUE, file ="~/IODS-project/data/alc.csv")