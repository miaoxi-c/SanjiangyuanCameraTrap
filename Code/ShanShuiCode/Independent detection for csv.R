# For creating independent detections spread sheet from excel/csv files for "all-video sites"
setwd("C:/Users/wo/Desktop")

# read data
test <- read.csv("601702.csv")

head(test)
test$Species <- as.factor(test$Species)
test$Deployment <- as.factor(test$Deployment)
str(test)

# get all species and numbers from data frame
sp <- levels(test$Species)
l <- length(sp)

# create an empty output data frame
result <- data.frame()

# subset by species and set minimum delta time to calculate independent detection events

for (i in 1:l){
  sp.df <- subset(test, Species == sp[i])    # subset by species
  len1 <- length(sp.df[,1])                  # get length of subsets
  
  result <- rbind(result, sp.df[1,])         # get first row of each species
  
  for(j in 1:len1){                          # compare delta time and write output
    len2 <- length(result[,1])               # get length of result data frame
    
    if (abs(sp.df[j,3] - result[len2,3]) < 0.0208){      # compare current event with last independent detection event 
      j <- j+1
    } 
    else{
      result <- rbind(result, sp.df[j,])
    }
  }
}

write.csv(result, file = "test result.csv")  # write csv
