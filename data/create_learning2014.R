#Xavier Riera 
#11th November 2019
#Regression and Model Validation

#First we read the whole dataset and we store as learning14.
learning14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt",header = TRUE, sep = "\t")

#Next, we analyze the structure of the data frame. This shows us the name of the variable, the type of the variable and the first values of each one.
str(learning14)

#Although we can observe the dimensions with the str() function, we can also use dim(). It shows that we have 183 rows and 60 columns.
dim(learning14)

library(dplyr)

#attitude_questions <- c("Da","Db","Dc","Dd","De","Df","Dh","Di","Dj")
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

#attitude_columns <- select(learning14,one_of(attitude_questions))
deep_columns <- select(learning14,one_of(deep_questions))
surface_columns <- select(learning14,one_of(surface_questions))
strategic_columns <- select(learning14,one_of(strategic_questions))

learning14$deep <- rowMeans(deep_columns)
learning14$surf <- rowMeans(surface_columns)
learning14$stra <- rowMeans(strategic_columns)

keep_columns <- c("gender","Age","Attitude","deep","stra","surf","Points")
learning2014 <- select(learning14,one_of(keep_columns))

colnames(learning2014)[2] <- "age"
colnames(learning2014)[3] <- "attitude"
colnames(learning2014)[7] <- "points"

learning2014 <- filter(learning2014, points > 0)

str(learning2014)

write.table(learning2014, sep = "\t", col.names = TRUE, file = "data/learning2014.txt")