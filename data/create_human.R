#Xavier Riera
#R Script to read and store data from the United Nations Development Programme.
#http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt
library(dplyr)
library(stringr)

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
human <- inner_join(hd, gii, by = "Country")

#we explore the structure and the dimensions of the data
str(human)
dim(human)
glimpse(human)

# Description of 'human' dataset variables. 
# Original data from: http://hdr.undp.org/en/content/human-development-index-hdi
# Retrieved, modified and analyzed by Tuomo Nieminen 2017

# The data combines several indicators from most countries in the world
#
#"Country" = Country name
#"HDI.Rank" = Human Development Index Rank
#"hdi" = HDI value
#"gni" = Gross National Income per capita
#"gniRank" = GNI Rank
#"lifeExp" = Life expectancy at birth
#"educationExp" = Expected years of schooling 
#"matMor" = Maternal mortality ratio
#"birth" = Adolescent birth rate
#"repParl" = Percetange of female representatives in parliament
#"secEduF" = Proportion of females with at least secondary education
#"secEduM" = Proportion of males with at least secondary education
#"labourF" = Proportion of females in the labour force
#"labourM" " Proportion of males in the labour force

#"edu2FM" = secEduF / secEduM
#"labFM" = labourF / labourM

#We transform the GNI variable to numeric
human$gni <- str_replace(human$gni, pattern=",", replace ="") %>% as.numeric()

#We exclude unneeded variables
keep <- c("Country", "edu2FM", "labFM", "lifeExp", "educationExp", "gni", "matMor", "birth", "repParl")
human <- select(human, one_of(keep))

#We remove all rows with missing values
human <- filter(human, complete.cases(human))

#We remove the observations which relate to regions instead of countries.
tail(human, n = 10)
last <- nrow(human) - 7
human <- human[1:last, ]

#We define the row names of the data by the country names and remove the country name column from the data.
rownames(human) <- human$Country
human <- select(human, -Country)

#We save the file
write.csv(human, file ="~/IODS-project/data/human.csv", row.names = TRUE)