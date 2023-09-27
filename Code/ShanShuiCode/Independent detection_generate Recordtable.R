dirPath = "/Volumes/雪豹-那曲/数据处理流程尝试/Angsai-2022.1-3/Angsai_2022.4.2回收/原始数据-已打标签"

setwd(dirPath)

library("camtrapR")
library("tidyverse")

#Automatically call exiftool during run R: ---NOT needed, exiftool installed on my macbook
#exiftoolPath (exiftoolDir = dirPath)


#Test R automatically calls exiftool: 
#grepl (dirPath, Sys.getenv ("PATH"))
#Get the return value "TRUE" to prove that the system can call exiftool

# generate a record table of species
RecordTable <- recordTable(inDir = dirPath,
                                     IDfrom = "metadata",
                                      minDeltaTime = 30,
                                      deltaTimeComparedTo = "lastIndependentRecord",
                                      timeZone = "Asia/Taipei",
                                      stationCol = "Station",
                                      writecsv = TRUE,
                                      metadataHierarchyDelimitor = "|",
                                      metadataSpeciesTag = "Species",
                                      removeDuplicateRecords = FALSE)


# Added by Miaoxi Chen to remove blank, useless and NA data
filtered <- speciesrecordtable_AS202108 %>% filter(Species != "Blank" & Species != "Useless data" & Species != "NA")

# Compare with data generated previously
ex09 <- read.csv("/Volumes/雪豹-那曲/数据处理流程尝试/Angsai-2022.1-3/Angsai_2022.4.2回收/各类表格/record_table_30min_deltaT_2022-09-05.csv")
ex05 <- read.csv("/Volumes/雪豹-那曲/数据处理流程尝试/Angsai-2022.1-3/Angsai_2022.4.2回收/各类表格/record_table_30min_deltaT_2022-05-25.csv")

filtered$DateTimeOriginal = as.character(filtered$DateTimeOriginal)
filtered$Date = as.character(filtered$Date)

filtered <- filtered %>% select(Station,Species)
ex09 <- ex09 %>% select(Station,Species)

anti_join(filtered, ex09)
