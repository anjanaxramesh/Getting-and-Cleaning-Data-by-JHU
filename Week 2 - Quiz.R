# Week 2 - Quiz

# Question 1
# Reference - Hadley Wickham's guide

library(jsonlite)
library(httr)
library(httpuv)

# oauth settings for github
oauth_endpoints("github")

# My app's credentials
myapp <- oauth_app(appname = "API for Getting and Cleaning Data Quiz", key = "7a95ffd0417285018d9c",
                   secret = "4a37326f25aa5007b1140cec5a66a7b45e472d36")

# Getting OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# Using API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken) # Request created

# Taking action on http error
stop_for_status(req)

# Extracting content from a request
json1 = content(req)

# Converting to a data frame
gitDF = jsonlite::fromJSON(jsonlite::toJSON(json1))

# Subsetting data frame to answer question - When was the req repo created?
gitDF[gitDF$full_name == "jtleek/datasharing", "created_at"] 

# Output = 2013-11-07T13:25:07Z


# Question 2

library(sqldf)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
filesave <- file.path(getwd(), "ss06pid.csv")
download.file(url, filesave)

# Loading the data into an object
acs = data.table::data.table(read.csv(filesave))

# Query which will select only the data for the probability weights pwgtp1 with ages less than 50
query1 <- sqldf("select pwgtp1 from acs where AGEP < 50")

# Question 3

# Function equivalent to unique(acs$AGEP)
query2 <- sqldf("select distinct AGEP from acs")


# Question 4

# Getting the data from the web
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)

# Getting the 10th, 20th, 30th and 100th characters from the HTML. 
char <- c(nchar(htmlCode[10]), nchar(htmlCode[20]), nchar(htmlCode[30]), nchar(htmlCode[100]))

# Output - 45 31 7 25

# Question 5

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"

# Read fixed width format files with given widths for the records
data <- read.fwf(url, skip = 4, widths = c(12, 7, 4, 9, 4, 9, 4, 9, 4))

# To get the sum of the numbers in the fourth of the nine columns.
sum(data[, 4])

# Output - 32426.7
