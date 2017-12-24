rankhospital <- function(state, outcome, num = "best") {
  
  ## read outcome data
  wd <- getwd()
  setwd("C:/Users/bmareddy/Documents/RLab/working/ProgAssignment3")
  data <- read.csv("outcome-of-care-measures.csv")
  setwd(wd)
  
  ## check that state and outcome are valid
  outcomes <- c("heart attack","heart failure","pneumonia")
  outcomeCols <- c(11,17,23)
  if (!(outcome %in% outcomes)) stop("invalid outcome")
  
  states <- as.character(unique(data[,7]))
  if (!(state %in% states)) stop("invalid state")
  
  ## obtain the column index based on outcome input
  col <- outcomeCols[match(outcome,outcomes)]
  
  ## obtain the subset of data by applying inputs as filters
  filteredData <- data[data$State==state,c(2,col),]
  colnames(filteredData) <- c("hospital", "outcome")
  filteredData$hospital <- as.character(filteredData$hospital)
  filteredData$outcome <- suppressWarnings(as.numeric(as.character(filteredData$outcome)))
  
  ## sort the data frame on outcome and then on hospital while excluding NA values
  sortedData <- filteredData[with(filteredData, order(outcome, hospital, na.last = NA)),]
  if(num == "best") num <- 1
  if(num == "worst") num <- nrow(sortedData)
  num <- as.numeric(num)
  sortedData[num,1]
}
