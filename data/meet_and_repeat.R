#Load libraries
library(dplyr)
library(tidyr)

#Read and save the data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt")

write.csv(BPRS, file = "~/IODS-project/data/bprs.csv")
write.csv(RATS, file = "~/IODS-project/data/rats.csv")

#Show some information of the datasets
names(BPRS)
names(RATS)

str(BPRS)
str(RATS)
#Thanks to the str() function, we can see that the treatment and subject variables in 
#BPRS are categorical. We also observe that the ID and Group variables in the RATS 
#dataset are categorical. 

dim(BPRS)
dim(RATS)

summary(BPRS)
summary(RATS)

#We convert the categorical variables to factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$Group <- factor(RATS$Group)
RATS$ID <- factor(RATS$ID)

#Convert the data sets to long form. Add a week variable to BPRS and a Time variable to RATS
BPRSL <- BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject) %>% mutate(weeks = as.integer(substr(weeks,5,5)))
RATSL <- RATS %>% gather(key = WD, value = Weight, -ID, -Group) %>% mutate(Time = as.integer(substr(WD,3,5)))

glimpse(BPRSL)
glimpse(RATSL)

names(BPRSL)
names(RATSL)

str(BPRSL)
str(RATSL)

write.csv(BPRSL, file = "~/IODS-project/data/bprsl.csv")
write.csv(RATSL, file = "~/IODS-project/data/ratsl.csv")