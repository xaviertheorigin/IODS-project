hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#We explore the datasets.
str(hd)
str(gii)
dim(hd)
dim(gii)
summary(hd)
summary(gii)

#We rename the variables
names(hd) <- c("HDI.Rank", "Country", "hdi", "lifeExp", "educationExp", "meanEdu", "gni", "gniRank")
names(gii) <- c("gii.rank", "Country", "gii", "matMor", "birth", "repParl", "secEduF", "secEduM", "labourF", "labourM")

#We create new variables
gii$edu2FM <- gii$secEduF / gii$secEduM
gii$labFM <- gii$labourF / gii$labourM

#We join the datasets
human <- inner_join(hd, gii, "Country")
dim(human)
glimpse(human)

#We save the file
write.table(human, sep = "\t", col.names = TRUE, file ="~/IODS-project/data/human.csv")