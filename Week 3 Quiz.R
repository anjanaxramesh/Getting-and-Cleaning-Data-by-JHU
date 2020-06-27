# Question 1

library(dplyr)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url, destfile = "C:/Users/asus/Documents/RStudio Files/Getting-and-Cleaning-Data-by-JHU/agriculture.csv", mmethod = "curl")
agridata <- read.csv("C:/Users/asus/Documents/RStudio Files/Getting-and-Cleaning-Data-by-JHU/agriculture.csv")
agricultureLogical <- agridata$ACR == 3 & agridata$AGS == 6
head(which(agricultureLogical))
# Output Answer - 125, 238, 262

# Question 2
library(jpeg)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", "jeff.jpg", mode = 'wb')
# Reading the picture
pic <- jpeg::readJPEG("jeff.jpg", native = TRUE)
# Getting the 30th and 80th quantiles
quantile(pic, c(0.3, 0.8))

# Question 3
library(data.table)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", "FGDP.csv", method = "curl")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", "FEDSTATS_Country.csv", method = "curl")
FGDP = data.table::fread("FGDP.csv", skip=4
                     , nrows = 190
                     , select = c(1, 2, 4, 5)
                     , col.names = c("CountryCode", "Rank", "Economy", "Total"))
FEDSTATS_Country = data.table::fread("FEDSTATS_Country.csv")
mergeddata <- merge(FGDP, FEDSTATS_Country, by = "CountryCode")
nrow(mergeddata)
# Sorting
mergeddata[order(-Rank)][13,.(Economy)]

# Question 4

mergeddata[`Income Group` == "High income: OECD"
         , lapply(.SD, mean)
         , .SDcols = c("Rank")
         , by = "Income Group"]

mergeddata[`Income Group` == "High income: nonOECD"
         , lapply(.SD, mean)
         , .SDcols = c("Rank")
         , by = "Income Group"]

# Question 5

breaks <- quantile(mergeddata[, Rank], probs = seq(0, 1, 0.2), na.rm = TRUE)
mergeddata$quantileGDP <- cut(mergeddata[, Rank], breaks = breaks)
mergeddata[`Income Group` == "Lower middle income", .N, by = c("Income Group", "quantileGDP")]
