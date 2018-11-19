library(rgdal)
library(data.table)
library(tigris)
library(leaflet)
setwd('/Users/caleblam/Desktop/R Stuff/ACS-Project')
dictionary <- read.csv('ACS_variable_descriptions.csv')

#Dallas
id <- '37-00049'

# read shapefile
shpPath <- paste('Dept_', id, '/', id, '_Shapefiles', sep = '')
shpName <- list.files(path = shpPath, pattern = '\\.shp$')
policeAreas_raw <- readOGR(paste(shpPath, '/', shpName, sep = ''))
policeAreas <- spTransform(policeAreas, CRS('+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0'))


# read other data
initialPath <- paste('Dept_', id, '/', id, '_ACS_data', sep = '')

edAttain <- read.csv(paste(initialPath,'/', id,'_ACS_education-attainment/ACS_16_5YR_S1501_with_ann.csv', sep = ''))

geoid <- edAttain[2,'GEO.id2']
censusShapes <- tracts(substr(geoid, 0,2),substr(geoid, 3,5))

crimeData <- read.csv(paste('Dept_', id, '/', id, '_UOF-P_2016_prepped.csv', sep=''))[-1, ]
crimeData$INCIDENT_TIMESTAMP <- as.POSIXct(paste(crimeData$INCIDENT_DATE, crimeData$INCIDENT_TIME), format ="%m/%d/%y %I:%M:%S %p")
crimeData$INCIDENT_DATE <- as.Date(crimeData$INCIDENT_DATE, format = '%m/%d/%y')

crimeData$OFFICER_HIRE_DATE <- as.Date(crimeData$OFFICER_HIRE_DATE, format = '%m/%d/%y')

#officer experience distribution
hist(as.numeric(crimeData$OFFICER_YEARS_ON_FORCE))

#officer racial makeup
summary(crimeData$OFFICER_RACE)

#officer gender makeup
summary(crimeData$OFFICER_GENDER)

#subject racial makeup
summary(crimeData$SUBJECT_RACE)

#subject gender makeup
summary(crimeData$SUBJECT_GENDER)

