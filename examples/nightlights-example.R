require(nightlights)
require(rgdal)
require(R.utils)

q <- readline(prompt="Download shapefile and night lights data for example (about 500MB)? (Y/n)")
if (q != "Y") {
  stop("Aborted.")
}

# Get an example shapefile to work with:
download.file("ftp://ftp2.census.gov/geo/tiger/TIGER2015/COUSUB/tl_2015_25_cousub.zip",
              destfile = "tl_2015_25_cousub.zip")
unzip("tl_2015_25_cousub.zip")
shp <- rgdal::readOGR(".", "tl_2015_25_cousub")

# Download and extract some night lights data to a directory "night-lights":
downloadNightLights(years = 1999:2000, directory = "night-lights")

# By default, the function gets the sum of night lights within the regions:
nl.sums <- extractNightLights(directory = "night-lights", shp)

# You can specificy other statistics to get, e.g. the mean & standard deviation:
nl.mean.sd <- extractNightLights(directory = "night-lights", shp,
                                 stats = c("mean", "sd"))
