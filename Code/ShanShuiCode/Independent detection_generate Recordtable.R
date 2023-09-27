setwd("D:/AS202108-tagged")

library("camtrapR")

#Automatically call exiftool during run R: 
exiftoolPath (exiftoolDir = "D:/AS202108-tagged")

#Test R automatically calls exiftool: 
grepl ("D:/AS202108-tagged", Sys.getenv ("PATH"))
#Get the return value "TRUE" to prove that the system can call exiftool

# generate a record table of species
speciesrecordtable_AS202108 <- recordTable(inDir = "D:/AS202108-tagged",
                                     IDfrom = "metadata",
                                      minDeltaTime = 30,
                                      deltaTimeComparedTo = "lastIndependentRecord",
                                      timeZone = "Asia/Taipei",
                                      stationCol = "Station",
                                      writecsv = TRUE,
                                      metadataHierarchyDelimitor = "|",
                                      metadataSpeciesTag = "Species",
                                      removeDuplicateRecords = FALSE)
