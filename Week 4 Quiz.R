# Question 1

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "C:/Users/asus/Documents/RStudio Files/Getting-and-Cleaning-Data-by-JHU/housing.csv", method = "curl")
housingData <- read.csv("C:/Users/asus/Documents/RStudio Files/Getting-and-Cleaning-Data-by-JHU/housing.csv")
splitNames = strsplit(names(housingData), "wgtp")
splitNames[[123]]

# Question 2

library(data.table)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", "FGDP.csv", method = "curl")
FGDP <- data.table::fread("FGDP.csv", skip = 5
                         , nrows = 190
                         , select = c(1, 2, 4, 5)
                         , col.names = c("CountryCode", "Rank", "Country", "GDP"))

# Removing commans and converting to an integer
FGDP[as.integer(gsub(',', '', x = 'GDP'))]
# For mean
FGDP[ , mean(as.integer(gsub(',', '', x = GDP)))]

# Question 3

grep("^United", FGDP[, Country])

# Question 4

library(data.table)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", "FGDP.csv", method = "curl")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", "FEDSTATS_Country.csv", method = "curl")
FGDP = data.table::fread("FGDP.csv", skip=4
                         , nrows = 190
                         , select = c(1, 2, 4, 5)
                         , col.names = c("CountryCode", "Rank", "Economy", "Total"))
FEDSTATS_Country = data.table::fread("FEDSTATS_Country.csv")
mergeddata <- merge(FGDP, FEDSTATS_Country, by = "CountryCode")
mergeddata[grepl(pattern = "Fiscal year end: June 30;", mergeddata[, `Special Notes`]), .N]

# Question 5

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

timedata <- data.table::data.table(timeCol = sampleTimes)

# How many values were collected in 2012? 
timedata[(timeCol >= "2012-01-01") & (timeCol < "2013-01-01"), .N ]

# How many values were collected on Mondays in 2012?
timedata[((timeCol >= "2012-01-01") & (timeCol < "2013-01-01")) & (weekdays(timeCol) == "Monday"), .N ]
           