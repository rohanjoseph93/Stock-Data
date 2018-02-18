
#Install quantmod package
#install.packages('quantmod')
library(quantmod)

#Get Stock list on NASDAQ
List <- read.csv("http://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=NASDAQ&render=download",
                 header=T,stringsAsFactors = F)

#Extract the symbols and sort and store them as vectors
Symbols <- unlist(sort(unique(List$Symbol)))

#Create empty data frame
stockdata <- data.frame()
for(i in 1:10) {

  tryCatch({
#Download data based on stock code
stocksymbol <- Symbols[i]
print(Symbols[i])
A <- as.data.frame(getSymbols(stocksymbol,src="yahoo",from =Sys.Date()-180, 
                              to = Sys.Date(),env=NULL))

#Rename columns
colnames(A) <- c("Open","High","Low","Close","Volume","Adjusted")

#Add stock name as a column
A$stock <- stocksymbol

#Store the data and continue the loop
if(nrow(stockdata) > 0) {
stockdata <- rbind(A,stockdata)}
else {
  stockdata <- A}},
error=function(e){cat("ERROR")})
}
