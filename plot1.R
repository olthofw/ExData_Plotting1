main <- function(){
  rm(list=ls())
  setWorkingDirectory()
  filepath <- paste(getwd(), "/","household_power_consumption.txt", sep="")
  data <- loadData(filepath)
  plot1(getwd(), data)
}

loadData <- function(path){
  
  powerData <- read.table(path, skip=grep("1/2/2007", readLines(path)), nrows=2879, sep=";", header=FALSE)
  
  ## Assign correct variable names
  names(powerData)[1] <- "Date"
  names(powerData)[2] <- "Time"
  names(powerData)[3] <- "Global_active_power"
  names(powerData)[4] <- "Global_reactive_power"
  names(powerData)[5] <- "Voltage"
  names(powerData)[6] <- "Global_intensity"
  names(powerData)[7] <- "Sub_metering_1"
  names(powerData)[8] <- "Sub_metering_2"
  names(powerData)[9] <- "Sub_metering_3"
  
  return(powerData)
}

plot1 <- function(path, data){
  file <- paste(path,"/","plot1.png", sep="")
  png(filename = file, width=480, height=480)
  hist(as.numeric(data$Global_active_power), breaks=20, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")
  dev.off()
}

setWorkingDirectory <- function(){
  
  WD <- readline(prompt="Set your working directory:")
  setwd(WD)
  print(paste("Working directory set to: ", getwd()), sep="")
}