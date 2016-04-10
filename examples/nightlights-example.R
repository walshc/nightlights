require(nightlights)
require(rgdal)

# Get a shapefile to work with:
download.file("ftp://ftp2.census.gov/geo/tiger/TIGER2015/COUSUB/tl_2015_25_cousub.zip",
              destfile = "tl_2015_25_cousub.zip")
unzip("tl_2015_25_cousub.zip")
shp <- readOGR(".", "tl_2015_25_cousub")

# Directory where the night lights data are stored:
nl.dir <- "~/night-lights"

# By default, the function gets the sum of night lights within the regions:
nl.sums <- extractNightLights(nl.dir, shp)

# You can specificy other statistics to get, e.g. the mean & standard deviation:
nl.mean.sd <- extractNightLights(nl.dir, shp, stats = c("mean", "sd"))
