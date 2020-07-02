# Week 4

# Editing text variables

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "C:/Users/asus/Documents/RStudio Files/Getting-and-Cleaning-Data-by-JHU/cameras.csv", method = "curl")
cameraData <- read.csv("C:/Users/asus/Documents/RStudio Files/Getting-and-Cleaning-Data-by-JHU/cameras.csv")
names(cameraData)
# all lowercase
tolower(names(cameraData))
# split names according to character
splitNames = strsplit(names(cameraData), "\\.")
splitNames[[5]]
splitNames[[6]]
splitNames[[6]][1]

firstElement <- function(x){x[1]}
sapply(splitNames, firstElement)

grep("Alameda", cameraData$intersection)
table(grepl("Alameda", cameraData$intersection))

cameraData2 <- cameraData[!grepl("Alameda", cameraData$intersection), ]

