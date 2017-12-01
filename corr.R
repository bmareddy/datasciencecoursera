corr <- function(directory, threshold = 0) {
  
    correlation <- numeric(0)
    for (i in 1:332) {
    
      # Pad ID to be character element of length 3 with leading 0s
      j <- paste0("000",i)
      j <- substr(j, nchar(j)-2, nchar(j))
      
      # construct absolute file path
      file <- file.path(directory,paste(j,".csv",sep=""))
      # Validate that this file exists
      
      # read and collect required data from the file
      data <- read.csv(file)
      ok <- complete.cases(data)
      nobs <- sum(ok)
      if (nobs > threshold) {
        correlation <- c(correlation, cor(data[,"sulfate"], data[,"nitrate"], use = "complete.obs"))
      }
    }
    correlation
}