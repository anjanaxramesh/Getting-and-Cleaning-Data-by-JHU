## Web Scraping

con = url("https://scholar.google.com/citations?hl=en&user=HI-I6C0AAAAJ")
htmlCode = readLines(con)
close(con)

library("XML")
url <- "https://scholar.google.com/citations?hl=en&user=HI-I6C0AAAAJ"
html <- htmlTreeParse(url, useInternalNodes = T)
xpathSApply(html, "//title", xmlValue)
xpathSApply(html, "//td[@id='col-citedby']", xmlValue)

library(httr)
html2 = GET(url)
content2 = content(html2, as = "text")
parsedHtml = htmlParse(content2, asText = T)
xpathSApply(parsedHtml,  "//title", xmlValue)
xpathSApply(parsedHtml, "//td[@id='col-citedby']", xmlValue)

google = handle("https://www.google.com/")
pg1 = GET(handle = google, path = "/")
pg2 = GET(handle = google, path = "search")

library(httr)
library(jsonlite)
myapp = oauth_app("twitter", key = "yourConsumerKeyHere", secret = "yourConsumerSecretHere" )
sig = sign_oauth1.0(myapp, token = "yourTokenHere", token_secret = "yourTokenSecretHere")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)
json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1, 1:4]
