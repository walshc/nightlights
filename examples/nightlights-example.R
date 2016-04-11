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

# Download and extract some night lights data (one year here as an example):
download.file("http://ngdc.noaa.gov/eog/data/web_data/v4composites/F182013.v4.tar",
              destfile = "F182013.v4.tar")
untar("F182013.v4.tar")
R.utils::gunzip("F182013.v4c_web.stable_lights.avg_vis.tif.gz")

# Directory where night lights data are stored (current directory here):
nl.dir <- "."

# By default, the function gets the sum of night lights within the regions:
nl.sums <- extractNightLights(nl.dir, shp)

# You can specificy other statistics to get, e.g. the mean & standard deviation:
nl.mean.sd <- extractNightLights(nl.dir, shp, stats = c("mean", "sd"))
