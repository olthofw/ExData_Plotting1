main <- function(){
  rm(list=ls())
  setWorkingDirectory()
  filepath <- paste(getwd(), "/","household_power_consumption.txt", sep="")
  data <- loadData(filepath)
  plot3(getwd(), data)
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

plot3 <- function(path, data){
  ## Energy sub metering vs days
  file <- paste(path, "/", "plot3.png", sep="")
  png(filename = file, width=480, height=480)
  plot(data$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", xaxt="n")
  axis(1, at=c(1, 1439, 2879), lab=c("Thu", "Fri", "Sat"))
  lines(data$Sub_metering_2, type="l", col="red")
  lines(data$Sub_metering_3, type="l", col="blue")
  legend("topright", lty=1, lwd=1, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"))
  dev.off()
}

setWorkingDirectory <- function(){
  
  ## Set working directory
  WD <- readline(prompt="Set your working directory:")
  setwd(WD)
  print(paste("Working directory set to: ", getwd()), sep="")
}