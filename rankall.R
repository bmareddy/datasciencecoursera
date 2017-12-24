## Function to return a hospital of nth rank by a given outcome.
## This code does not use other functinos that are part of the assignment
## , though the author acknowledges that this can be simplified by referenceing
## rankhospital()

rankall <- function(outcome, num = "best") {
  
  ## read outcome data
  wd <- getwd()
  setwd("C:/Users/bmareddy/Documents/RLab/working/ProgAssignment3")
  data <- read.csv("outcome-of-care-measures.csv")
  setwd(wd)
  
  ## check that outcome is valid
  outcomes <- c("heart attack","heart failure","pneumonia")
  if (!(outcome %in% outcomes)) stop("invalid outcome")
  
  ## obtain the column index based on outcome input
  outcomeCols <- c(11,17,23) # Indices for the valid outcomes, in the same order
  col <- outcomeCols[match(outcome,outcomes)]
  
  ## initialize an empty data frame to hold the output data set
  out <- data.frame(character(),character(),stringsAsFactors = FALSE)
  
  ## Get all valid states and sort them
  states <- as.character(unique(data[,7]))
  states <- sort(states)
  
  ## FOr each state find the nth rank hospital by given outcome
  for (s in states)
  {
    filteredData <- data[data$State==s,c(2,col),] # Get the subset of data filtered by state
    colnames(filteredData) <- c("hospital", "outcome")
    filteredData$hospital <- as.character(filteredData$hospital)
    filteredData$outcome <- suppressWarnings(as.numeric(as.character(filteredData$outcome)))

    ## sort the data frame on outcome and then on hospital while excluding NA values
    sortedData <- filteredData[with(filteredData, order(outcome, hospital, na.last = NA)),] # Sort the data
    n <- num
    if(num == "best") n <- 1
    if(num == "worst") n <- nrow(sortedData)
    n <- as.numeric(n)
    out <- rbind.data.frame(out, c(hospital=sortedData[n,1],state=s), stringsAsFactors = FALSE) # Append the output row to the output data frame
  }
  colnames(out) <- c("hospital","state")
  rownames(out) <- out$state
  out # Final output
}
