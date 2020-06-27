# Subsetting and Sorting

set.seed(13435)
X <- data.frame("var1" = sample(1:5), "var2" = sample(6:10), "var3" = sample(11:15))
X <- X[sample(1:5), ] ; X$var2[c(1, 3)] = NA
X[(X$var1 <= 3 & X$var3 > 11), ]
X[(X$var1 <= 3 | X$var3 > 15), ]
X[which(X$var2 > 8)]
sort(X$var2, na.last = T)
X[order(X$var1), ]

library(plyr)
arrange(X, var1)
arrange(X, desc(var1))

X$var4 <- rnorm(5)
Y <- cbind(X, rnorm(5))
Y <- rbind(X, rnorm(5))

# Summarizing Data

fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "C:/Users/asus/Documents/RStudio Files/Getting-and-Cleaning-Data-by-JHU/restaurants.csv", method = "curl")
restData <- read.csv("C:/Users/asus/Documents/RStudio Files/Getting-and-Cleaning-Data-by-JHU/restaurants.csv")

quantile(restData$councilDistrict, na.rm = TRUE)
quantile(restData$councilDistrict, probs = c(0.5, 0.75, 0.9))
table(restData$zipCode, useNA = "ifany")
table(restData$zipCode, restData$councilDistrict)

sum(is.na(restData$councilDistrict))
# Goes through full dataset and gives True or False for the command
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0)
colSums(is.na(restData))
all(colSums(is.na(restData)==0))
table(restData$zipCode %in% c("21212"))
restData[restData$zipCode %in% c("21212", "21213"), ]

data(UCBAdmissions)
DF = as.data.frame(UCBAdmissions)
summary(DF)
xt <- xtabs(Freq ~ Gender + Admit, data = DF)

# Creating new variables

restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)

restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
ftable(restData$zipWrong, restData$zipCode < 0)

restData$zipGroups = cut(restData$zipCode, breaks = quantile(restData$zipCode))
table(restData$zipGroups, restData$zipCode)

library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g = 4)
table(restData$zipGroups)

restData$zcf = factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf) # factor

library(Hmisc)
library(plyr)
restData2 = mutate(restData, zipGroups = cut2(zipCode, g = 4))
table(restData2$zipGroups)

# Reshaping

library(reshape2)
mtcars$carName <- rownames(mtcars)
carMelt <- melt(mtcars, id = c("carName", "gear", "cyl"), measure.vars = c("mpg", "hp"))
cylData <- dcast(carMelt, cyl ~ variable)

# Averaging values
data("InsectSprays")
tapply(InsectSprays$count, InsectSprays$spray, sum)
spIns = split(InsectSprays$count, InsectSprays$spray)
sprCount = lapply(spIns, sum)
unlist(sprCount)
sapply(spIns, sum)

library(plyr)
ddply(InsectSprays, .(spray), summarize, sum = sum(count))
spraySums <- ddply(InsectSprays, .(spray), summarize, sum = ave(count, FUN = sum))

# Manipulating data with dplyr and tidyr - swirl

sat %>%
  select(-contains("total")) %>%
  gather(part_sex, count, -score_range) %>%
  separate(part_sex, c("part", "sex")) %>%
  ### <Your call to group_by()> %>%
  group_by(part, sex) %>%
  mutate(total = sum(count),
         prop = count / total
  ) %>% print



