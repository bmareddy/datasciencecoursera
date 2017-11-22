complete <- function(directory, id = 1:332) {
  
    result <- c(numeric(0), numeric(0))
    for (i in id) {
        
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
      result <- rbind(result, c(i,nobs))
    }
    output <- as.data.frame(result)
    colnames(output) <- c("id","nobs")
    output
}