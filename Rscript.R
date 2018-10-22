library(rgdal)
library(data.table)
library(tigris)
library(leaflet)
dictionary <- read.csv('ACS_variable_descriptions.csv')

#Dallas
id <- '37-00049'

# read shapefile
shpPath <- paste('/Users/caleblam/Downloads/data-science-for-good/Dept_', id, '/', id, '_Shapefiles', sep = '')
shpName <- list.files(path = shpPath, pattern = '\\.shp$')
policeAreas_raw <- readOGR(paste(shpPath, '/', shpName, sep = ''))
policeAreas <- spTransform(policeAreas, CRS('+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0'))

# read other data
initialPath <- paste('Dept_', id, '/', id, '_ACS_data', sep = '')

edAttain <- read.csv(paste(initialPath,'/', id,'_ACS_education-attainment/ACS_16_5YR_S1501_with_ann.csv', sep = ''))

geoid <- edAttain[2,'GEO.id2']
censusShapes <- tracts(substr(geoid, 0,2),substr(geoid, 3,5))
