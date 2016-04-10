\name{extractNightLights}
\alias{extractNightLights}
\title{Extract Night Lights data from regions in a shapefile}
\description{Extract NOAA night lights data for regions in a
  SpatialPolygonsDataFrame. For years with two different satellite readings, it
  first takes the average between the two years.}
\usage{
extractNightLights(nl.dir = ".", shp, stats = c("sum"))
}
\arguments{
\item{nl.dir}{The directory the night lights data is stored in. Default is the
  current directory.}
\item{shp}{The \code{SpatialPolygonsDataFrame} to extract data from.}
\item{stats}{A vector of functions to apply to the data within each region, for
  example \code{c("sum", "mean", "sd")}. The default is \code{"sum"}.}
}
\examples{
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
}
