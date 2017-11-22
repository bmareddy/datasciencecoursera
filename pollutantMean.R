## Function to compute mean of a pollutant in a set of air quality data files
pollutantMean <- function(directory, pollutant, id = 1:332) {
      
      finalDataSet <- numeric(0)
      
      for (i in id) {
        
        # Pad ID to be character element of length 3 with leading 0s
        if (i<10) { j <- paste0("00",i) }
        else if (i<100) { j <- paste0("0",i) }
        else { j <- i }
        
        # construct absolute file path
        file <- file.path(directory,paste(j,".csv",sep=""))
        # Validate that this file exists
        
        # read and collect required data from the file
        data <- read.csv(file)
        pollutantDataRaw <- data[,pollutant]
        
        # accumulate data from multiple files
        finalDataSet <- c(finalDataSet, pollutantDataRaw)
      }
      
      mean(finalDataSet, na.rm = TRUE)
}